{ config, lib, pkgs, ... }:

let
  cfg = config.services.myctrl;
in
{
  options.services.myctrl = {
    enable = lib.mkEnableOption "myctrl system service";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ./../default.nix {};
      description = "Package providing the myctrl binary.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.myctrl = {
      description = "My control service";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${cfg.package}/bin/myctrl";
        Restart = "always";
        RestartSec = "1s";
      };
    };
  };
}