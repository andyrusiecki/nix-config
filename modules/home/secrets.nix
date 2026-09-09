{ config, pkgs, inputs, ... }:

let
  sessionEnvPath = config.sops.secrets.session_env.path;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = "${inputs.my-secrets}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      session_env = {
        sopsFile = "${inputs.my-secrets}/secrets.env";
        format = "binary";
        mode = "0600";
      };
    #   "private_keys/${config.home.username}" = {
    #     path = "${config.configDir.homeDirectory}/.ssh/id_ed25519";
    #   };
    };
  };

  # Adding environment variables
  # - Systemd User Environment
  systemd.user.services.import-sops-session-vars = {
    Unit = {
      Description = "Import decrypted secrets.env to systemd and DBus";
      After = [ "sops-nix.service" ];
      Requires = [ "sops-nix.service" ];
      WantedBy = [ "graphic-session.target" "default.target" ];
    };

    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      EnvironmentFile = "-${sessionEnvPath}";
      ExecStart = pkgs.writeShellScript "import-sops-env" ''
        if [ -s "${sessionEnvPath}" ]; then
          systemctl --user import-environment
          dbus-update-activation-environment --systemd --all
        fi
      '';
    };
  };

  # - Terminal Environments
  programs.bash.initExtra = ''
    if [ -s "${sessionEnvPath}" ]; then
      set -a
      source "${sessionEnvPath}"
      set +a
    fi
  '';

  programs.zsh.initExtra = ''
    if [ -s "${sessionEnvPath}" ]; then
      set -a
      source "${sessionEnvPath}"
      set +a
    fi
  '';

  programs.fish.loginShellInit = ''
    if test -s "${sessionEnvPath}"
      cat "${sessionEnvPath}" | grep -v '^#' | while read line
        set -l kv (string split -m 1 '=' $line)
        set -gx $kv[1] (string trim -c '"' $kv[2])
      end
    end
  '';
}
