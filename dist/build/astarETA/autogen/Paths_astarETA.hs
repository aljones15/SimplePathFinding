{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_astarETA (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/andrewjones/.etlas/bin"
libdir     = "/Users/andrewjones/.etlas/lib/x86_64-osx-eta-0.0.9.1-ghc7_10_3/astarETA-0.1.0.0-lYnEdhTeZyAT1jIokdncS-astarETA"
dynlibdir  = "/Users/andrewjones/.etlas/lib/x86_64-osx-eta-0.0.9.1-ghc7_10_3"
datadir    = "/Users/andrewjones/.etlas/share/x86_64-osx-eta-0.0.9.1-ghc7_10_3/astarETA-0.1.0.0"
libexecdir = "/Users/andrewjones/.etlas/libexec"
sysconfdir = "/Users/andrewjones/.etlas/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "astarETA_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "astarETA_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "astarETA_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "astarETA_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "astarETA_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "astarETA_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
