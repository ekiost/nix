{
  stdenv,
  lib,
  src,
}:
stdenv.mkDerivation {
  pname = "nowplaying-cli";
  version = src.shortRev or src.rev or "unstable";

  inherit src;

  installFlags = [ "PREFIX=${placeholder "out"}" ];

  meta = {
    description = "macOS command-line utility for retrieving currently playing media";
    homepage = "https://github.com/kirtan-shah/nowplaying-cli";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.darwin;
    mainProgram = "nowplaying-cli";
  };
}
