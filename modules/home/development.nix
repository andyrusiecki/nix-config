# /etc/nixos/modules/home/development.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    golangci-lint
    nodejs
    opencode-desktop
    rustc
    rustfmt
    rust-analyzer
  ];

  programs.cargo.enable = true;
  programs.claude-code.enable = true;
  programs.go = {
    enable = true;
    # TODO: GOPRIVATE
  };
  programs.npm.enable = true;
  programs.opencode.enable = true;
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
