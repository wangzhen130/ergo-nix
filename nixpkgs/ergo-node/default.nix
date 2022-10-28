{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "ergo-node";
  version = "5.0.1";

  src = fetchurl {
    url = "https://github.com/ergoplatform/ergo/releases/download/v${version}/ergo-${version}.jar";
    sha256 = "6a81f69d11acda6df85c3b496f3212f10f3074855de1277284ea4c6da9d3d49f";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    makeWrapper ${jre}/bin/java $out/bin/ergo --add-flags "-jar -Xmx3G -Dlogback.stdout.level=DEBUG $src"
  '';

}
