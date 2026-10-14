{
  lib,
  maven,
  makeWrapper,
  jre,
}:

maven.buildMavenPackage (finalAttrs: {
  pname = "hkxpack";
  version = "0.2.0";

  mvnHash = "sha256-HW7DmRS7b19jkhTsOFzr2HX7bRRZlJdLFtnZmEWAToY=";

  src = ./.;
  doCheck = false;

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/share/hkxpack
    install -Dm644 core/target/hkxpack.jar $out/share/hkxpack/core.jar
    install -Dm644 cli/target/hkxpack.jar $out/share/hkxpack/cli.jar

    makeWrapper ${jre}/bin/java $out/bin/hkxpack --add-flags "-jar $out/share/hkxpack/cli.jar"

    runHook postInstall
  '';

  meta = {
    description = "HKXPack is a tool to pack and unpack HKX files from and to the TagXML format";
    homepage = "https://github.com/Dexesttp/hkxpack";
    license = lib.licenses.mit;
    mainProgram = "hkxpack";
    platforms = lib.platforms.all;
  };
})
