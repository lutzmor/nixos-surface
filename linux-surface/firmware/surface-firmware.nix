{stdenv,  unzip, kmod}:
stdenv.mkDerivation rec {
  pname = "surface_firmware";
  src = ./surface-ipts-firmware;
  buildPhase = "";
  installPhase = ''
    mkdir -p "$out/lib/firmware"
    cp -r firmware/* "$out/lib/firmware/"
  '';
}
