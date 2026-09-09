# /etc/nixos/modules/home/shells.nix
{ config, pkgs, ... }:

let
  shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";

    "cat" = "bat";
    "cd" = "z";
  };
in {
  # shells
  programs.bash = {
    enable = true;
    shellAliases = shellAliases;
  };

  programs.fish = {
    enable = true;
    shellAliases = shellAliases;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.zsh = {
    enable = true;
    shellAliases = shellAliases;

    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;
  };

  # tools
  home.packages = with pkgs; [
    chezmoi
    dust
    gnumake
    hugo
    kubectl
    mkcert
    nss
    podman-compose
    unrar
    wl-clipboard
    yq
  ];

  programs.awscli.enable = true;
  programs.bat.enable = true;

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.distrobox.enable = true;

  programs.eza = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    colors = "auto";
    git = true;
    icons = "auto";

    extraOptions = [
      "--long"
      "--header"
      "--level=2"
    ];
  };

  programs.fastfetch.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;

  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "ssh";

      prompt = "enabled";

      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      alias = {
        br = "branch";
        ci = "commit";
        co = "checkout";
        st = "status";
        last = "log -1 HEAD";
        unstage = "reset HEAD --";
      };
    };

    # TODO: signing, includes
  };

  programs.grep.enable = true;
  programs.jq.enable = true;

  programs.kubecolor = {
    enable = true;
    enableAlias = true;
  };

  programs.less.enable = true;
  programs.ripgrep.enable = true;

  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    presets = [
      "nerd-font-symbols"
    ];

    settings = {
      aws.disabled = true;
      gcloud.disabled = true;

      git_commit = {
        only_detached = false;
        tag_disabled = false;
      };

      git_status = {
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
      };

      kubernetes = {
        disabled = false;
        detect_folders = [
          "k8s"
        ];
      };
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ${config.home.homeDirectory}/.1password/agent.sock
    '';
  };

  programs.zoxide = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
}
