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
      renderPDF (name nm "pdf") (Dims 200 200)
        -- latexStandaloneSurface
        -- contextStandaloneSurface 
        plaintexStandaloneSurface
        dig
      rawSystem "convert" [name nm "pdf", name nm "png"]
      return $ H.image ! [ src (name nm "png") ]
      -- is it possible to put all three next to each other?
  )
 where
  name nm ext = prefix </> nm <.> ext
  prefix = "pgf"
