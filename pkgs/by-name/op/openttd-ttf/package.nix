{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  python3,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "openttd-ttf";
  version = "0.7";

  src = fetchFromGitHub {
    owner = "zephyris";
    repo = "openttd-ttf";
    tag = finalAttrs.version;
    hash = "sha256-HKOG3Ov0LBCW7Z0FK5BrZRycn2S5gVRnwyU9fM3hb5M=";
  };

  nativeBuildInputs = [
    (python3.withPackages (
      pp: with pp; [
        fontforge
        pillow
        setuptools
      ]
    ))
  ];

  postPatch = ''
    chmod a+x build.sh
    # Test requires openttd source and an additional python module, doesn't seem worth it
    substituteInPlace build.sh \
      --replace-fail "python3 checkOpenTTDStrings.py ../openttd/src/lang" ""
    patchShebangs --build build.sh
  '';

  buildPhase = ''
    runHook preBuild
    ./build.sh
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -m444 -Dt $out/share/fonts/truetype */*.ttf
    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/zephyris/openttd-ttf";
    changelog = "https://github.com/zephyris/openttd-ttf/releases/tag/${finalAttrs.version}";
    description = "TrueType typefaces for text in a pixel art style, designed for use in OpenTTD";
    license = [ lib.licenses.gpl2 ];
    platforms = lib.platforms.all;
    maintainers = [ lib.maintainers.sfrijters ];
  };
})
