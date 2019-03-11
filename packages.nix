{ mkDerivation, base, happy, alex, c2hs, ncurses, random, stdenv }:
mkDerivation {
  pname = "PathFinder";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base happy alex c2hs ncurses random ];
  executableHaskellDepends = [ base ncurses c2hs alex ];
  testHaskellDepends = [ base ];
  homepage = "https://github.com/githubuser/PathFinder#readme";
  license = stdenv.lib.licenses.bsd3;
}
