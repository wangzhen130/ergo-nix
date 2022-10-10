{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "ergo-node";
  version = "4.0.104";

  src = fetchurl {
    url = "https://github.com/ergoplatform/ergo/releases/download/v${version}/ergo-${version}.jar";
    sha256 = "87a39578389f6082b2224c1b37fa6625681ee3f6062fa727410fec235e0bb074";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    makeWrapper ${jre}/bin/java $out/bin/ergo --add-flags "-jar -Xmx3G -Dlogback.stdout.level=DEBUG $src"
  '';

}
