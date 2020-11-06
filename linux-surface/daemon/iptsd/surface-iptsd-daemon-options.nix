{config, lib, pkgs, utils, ... }:

with lib;

let
  cfg = config.services.iptsd;
  configFile = pkgs.writeText "/etc/ipts.conf" ''
    [Device]
    Vendor = 0x045E
    Product = 0x099F

    [Config]
    InvertX = true
    InvertY = true

    Width = 2598
    Height = 1732
  '';
in
{
  options = {
    services.iptsd = {
      enable = mkEnableOption "Surface iptsd Daemon";
    };
  };
  config = mkIf cfg.enable {
    systemd.services.iptsd = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.surface-iptsd-daemon pkgs.utillinux pkgs.bash ];
      script = "iptsd";
    };
    services.udev.packages = [ pkgs.surface-iptsd-daemon ];
    systemd.packages = [ pkgs.surface-iptsd-daemon ];
  };
}
