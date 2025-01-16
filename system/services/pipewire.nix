{lib, ...}: {
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;

    # NOTE: Uncomment to try if this disables all webcams or just changes the way they get recognized.
    # wireplumber.extraConfig."wireplumber.profiles".main."monitor.libcamera" = "disabled";
  };

  #hardware.pulseaudio.enable = lib.mkForce false;
}
