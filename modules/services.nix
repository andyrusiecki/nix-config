{ config, pkgs, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.system-config-printer.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Avahi
  services.avahi.enable = true;

  # Tailscale
  services.tailscale.enable = true;

  # Flatpak
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # fprintd (later move to framework config)
  services.fprintd.enable = true;

  # fwupd
  services.fwupd.enable = true;

  # location
  services.geoclue2.enable = true; # not sure if needed
  location.provider = "geoclue2";

  # ollama
  services.ollama.enable = true;

  # tuned
  services.tuned.enable = true;
  services.tuned.ppdSupport = true;

  # udev
  services.udev.extraRules = "";
  # Enable tz update service
  # services.tzupdate.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
}
