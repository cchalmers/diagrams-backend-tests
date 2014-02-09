module Main where

import Diagrams.Tests
import Diagrams.Test.PGF
import System.Directory

main = do
   createDirectoryIfMissing False "pgf"
   runTests examples "pgf-index.html" [pgfTester]
