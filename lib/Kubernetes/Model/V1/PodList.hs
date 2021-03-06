-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a MIT license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.PodList
    ( PodList (..)
    , kind
    , apiVersion
    , metadata
    , items
    , mkPodList
    ) where

import           Control.Lens.TH                       (makeLenses)
import           Data.Aeson.TH                         (defaultOptions,
                                                        deriveJSON,
                                                        fieldLabelModifier)
import           Data.Text                             (Text)
import           GHC.Generics                          (Generic)
import           Kubernetes.Model.Unversioned.ListMeta (ListMeta)
import           Kubernetes.Model.V1.Pod               (Pod)
import           Prelude                               hiding (drop, error, max,
                                                        min)
import qualified Prelude                               as P
import           Test.QuickCheck                       (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances             ()

-- | PodList is a list of Pods.
data PodList = PodList
    { _kind       :: !(Maybe Text)
    , _apiVersion :: !(Maybe Text)
    , _metadata   :: !(Maybe ListMeta)
    , _items      :: !([Pod])
    } deriving (Show, Eq, Generic)

makeLenses ''PodList

$(deriveJSON defaultOptions{fieldLabelModifier = (\n -> if n == "_type_" then "type" else P.drop 1 n)} ''PodList)

instance Arbitrary PodList where
    arbitrary = PodList <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

-- | Use this method to build a PodList
mkPodList :: [Pod] -> PodList
mkPodList xitemsx = PodList Nothing Nothing Nothing xitemsx
