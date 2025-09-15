{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    defaultProfiles = ["gpu-hq" "hdr"];
    scripts = [pkgs.mpvScripts.mpris];

    profiles = {
      hdr = {
        vo = "gpu-next";
        gpu-api = "vulkan";
        target-colorspace-hint = true;
      };
    };
  };
}
