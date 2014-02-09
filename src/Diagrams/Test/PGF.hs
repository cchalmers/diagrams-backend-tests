module Diagrams.Test.PGF (pgfTester) where

import Diagrams.Backend.PGF
import Diagrams.Prelude hiding ((<.>))
import Diagrams.Tests
import System.FilePath ((</>), (<.>))
import System.Process
import Text.Html as H hiding ((</>))

pgfTester :: (String, Test -> IO Html)
pgfTester =
  ( "pgf"
  , \ (Test nm dig) -> do
      renderPGF (name nm "tex") (Dims 200 200) plaintexStandaloneSurface dig
      rawSystem "pdftex" ["--output-directory", "pgf", name nm "tex"]
      -- rawSystem "echo" ["--output-directory", "pgf", name nm "tex"]
      rawSystem "convert" [name nm "pdf", name nm "png"]
      return $ H.image ! [ src (name nm "png") ]
  )
 where
  name nm ext = prefix </> nm <.> ext
  prefix = "pgf"
