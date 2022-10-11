{ stdenv, fetchurl, makeWrapper, jre }:

stdenv.mkDerivation rec {
  pname = "ergo-explorer-backend";
  version = "9.16.6";

  src = fetchurl {
    url = "https://github.com/ergoplatform/explorer-backend/releases/download/${version}/explorer-${version}.tar.gz";
    sha256 = "17b73bee7aa02521029276aadc4807240ad244d84a3fbe8d39da505da1010d4d";
  };

  setSourceRoot = "sourceRoot=`pwd`";

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/share/java
    cp -v *.jar $out/share/java/
    makeWrapper ${jre}/bin/java $out/bin/ergo-chain-grabber --add-flags "-jar $out/share/java/ChainGrabber.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-explorer-api --add-flags "-jar $out/share/java/ExplorerApi.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-utx-broadcaster --add-flags "-jar $out/share/java/UtxBroadcaster.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-utx-tracker --add-flags "-jar $out/share/java/UtxTracker.jar"
    makeWrapper ${jre}/bin/java $out/bin/ergo-migrator --add-flags "-jar $out/share/java/Migrator.jar"
  '';

}
