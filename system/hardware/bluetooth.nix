{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez5-experimental;
    settings = {
      # TODO: Adapt for my controller
      # make Xbox Series X/S controller work
      #General = {
      #    Class = "0x000100";
      #    ControllerMode = "bredr";
      #    FastConnectable = true;
      #    JustWorksRepairing = "always";
      #    Privacy = "device";
      #    # Battery info for Bluetooth devices
      #    Experimental = true;
      #};
    };
  };
}
