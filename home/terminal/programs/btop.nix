{
  pkgs,
  isLaptop,
  ...
}: {
  programs = {
    btop = {
      enable = false;
    };
  };
  home.packages = with pkgs; [
    (
      if isLaptop
      then btop-cuda
      else btop-rocm
    )
  ];
}
