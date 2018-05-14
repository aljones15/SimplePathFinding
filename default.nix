{ mkDerivation, alex, base, c2hs, happy, ncurses, random, stdenv }:
mkDerivation {
  pname = "PathFinder";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base ncurses random ];
  libraryToolDepends = [ alex c2hs happy ];
  executableHaskellDepends = [ base ncurses ];
  testHaskellDepends = [ base ];
  homepage = "https://github.com/githubuser/PathFinder#readme";
  license = stdenv.lib.licenses.bsd3;
}
