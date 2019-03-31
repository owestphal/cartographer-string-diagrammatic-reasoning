module Cartographer.Editor.Types where

import Miso.String (MisoString)
import Data.Hypergraph
import Linear.V2 (V2(..))

import Cartographer.Layout (Layout(..))
import qualified Cartographer.Layout as Layout

import Cartographer.Viewer (Generator(..), ClickedPorts(..))
import qualified Cartographer.Viewer as Viewer

data Model = Model
  { _modelLayout      :: Layout Generator
  , _modelActionState :: ActionState
  } deriving(Eq, Ord, Show)

data Action
  = ViewerAction Viewer.Action
  | StartConnect
  | StartPlaceGenerator Generator
  deriving(Eq, Ord, Read, Show)

-- | 'ActionState' keeps track of what the user is trying to achieve for
-- multi-state actions, such as connecting two ports.
--
-- Here's an example trace:
--  user clicks Connect tool:  (ConnectSource, NoResult)
--  user clicks a source port, s: (ConnectTarget s, NoResult)
--  user clicks a target port, t: (NoAction, connectPorts s t layout)
data ActionState
  = Done -- ^ Nothing to do
  | ConnectSource
  | ConnectTarget (Port Source Open)
  | PlaceGenerator Generator
  deriving(Eq, Ord, Read, Show)
