{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_PathFinder (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/andrewjones/.cabal/bin"
libdir     = "/Users/andrewjones/.cabal/lib/x86_64-osx-ghc-8.0.2/PathFinder-0.1.0.0-3chpb9TkFv37OThEAPUF4g"
dynlibdir  = "/Users/andrewjones/.cabal/lib/x86_64-osx-ghc-8.0.2"
datadir    = "/Users/andrewjones/.cabal/share/x86_64-osx-ghc-8.0.2/PathFinder-0.1.0.0"
libexecdir = "/Users/andrewjones/.cabal/libexec/x86_64-osx-ghc-8.0.2/PathFinder-0.1.0.0"
sysconfdir = "/Users/andrewjones/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "PathFinder_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "PathFinder_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "PathFinder_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "PathFinder_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "PathFinder_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "PathFinder_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
