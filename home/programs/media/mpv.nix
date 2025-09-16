{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    defaultProfiles = ["gpu-hq" "hdr"];
    scripts = [pkgs.mpvScripts.mpris pkgs.mpvScripts.dynamic-crop pkgs.mpvScripts.mpv-osc-modern];

    profiles = {
      hdr = {
        vo = "gpu-next";
        gpu-api = "vulkan";
        target-colorspace-hint = true;
      };
    };
    config = {
      save-position-on-quit = true;
      resume-playback = true;
      keep-open = "yes";
      osc = "yes";
    };
  };
}
