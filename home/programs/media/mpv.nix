{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    defaultProfiles = ["gpu-hq" "hdr"];
    scripts = [pkgs.mpvScripts.mpris pkgs.mpvScripts.dynamic-crop];

    profiles = {
      hdr = {
        vo = "gpu-next";
        gpu-api = "vulkan";
        target-colorspace-hint = true;
      };
    };
  };
}
