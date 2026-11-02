# /etc/nixos/modules/home/development.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    age
    cryptomator-cli
    docker-credential-helpers
    golangci-lint
    kubetui
    nodejs
    php
    rustc
    rustfmt
    rust-analyzer
    sops
    ssh-to-age

    # from llm-agents
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2-desktop
  ];

  programs.cargo.enable = true;

  programs.docker-cli = {
    enable = true;
    settings = {
      credsStore = "secretservice";
    };
  };

  programs.go = {
    enable = true;
  };
  programs.npm.enable = true;
  programs.yarn.enable = true;

  services.podman = {
    enable = true;
    settings.containers = {
      compose_providers = [
        "podman-compose"
      ];
      compose_warning_logs = false;
    };
  };
}
