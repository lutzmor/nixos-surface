{ config, lib, pkgs, ... }:
{
  imports = [
    ./daemon/iptsd/surface-iptsd-daemon-options.nix
  ];

  nixpkgs.overlays = [(self: super: {
  	libinput = super.callPackage ./libinput/libinput-1.15.0.nix {};
    	surface-control = super.callPackage ./control/surface-control.nix {};
	surface_firmware = super.callPackage ./firmware/surface-firmware.nix {};
	iptsd = super.callPackage ./daemon/iptsd/surface-iptsd-daemon.nix {};
  })];
  
  hardware.firmware = [ pkgs.surface_firmware ];
  services.udev.packages = [ pkgs.surface_firmware ];
  services.iptsd.enable = true;
}
