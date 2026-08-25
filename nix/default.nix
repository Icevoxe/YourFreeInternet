{ stdenv
, cmake
, pkg-config
}:

stdenv.mkDerivation {
  pname = "myctrl";
  version = "0.1.0";

  src = ./.;

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  installPhase = ''
    cmake --install build --prefix $out
  '';
}