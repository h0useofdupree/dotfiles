{pkgs, ...}: {
  users.users.h0useofdupree = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = [
      "input"
      "libvirtd"
      "networkmanager"
      "video"
      "wheel"
      "optical"
    ];
  };
}
