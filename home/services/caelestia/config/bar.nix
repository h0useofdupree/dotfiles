{isLaptop}: {
  bar = {
    # BUG: Disabling logo breaks activeWindow text. Other entries might affect this too.
    entries = [
      {
        id = "logo";
        enabled = true;
      }
      {
        id = "workspaces";
        enabled = true;
      }
      {
        id = "spacer";
        enabled = true;
      }
      {
        id = "activeWindow";
        enabled = true;
      }
      {
        id = "spacer";
        enabled = true;
      }
      {
        id = "clock";
        enabled = true;
      }
      {
        id = "tray";
        enabled = true;
      }
      {
        id = "statusIcons";
        enabled = true;
      }
      {
        id = "idleInhibitor";
        enabled = true;
      }
      {
        id = "power";
        enabled = true;
      }
    ];
    activeWindow = {
      compact = true;
      inverted = true;
      showIcon = true;
    };
    clock = {
      showIcon = false;
      showDate = true;
      background = true;
    };
    dragThreshold = 20;
    persistent = true;
    showOnHover = true;
    workspaces = {
      activeIndicator = true;
      activeLabel = "󰬸 ";
      occupiedLabel = "󰺕 ";
      label = "  ";
      specialWorkspaceIcons = [
        {
          name = "special";
          icon = "󰍶";
        }
      ];
      activeTrail = true;
      occupiedBg = true;
      perMonitorWorkspaces = true;
      showWindows = true;
      shown = 5;
    };
    status = {
      showAudio = true;
      showBattery = isLaptop;
      showBluetooth = true;
      showKbLayout = false;
      showMicrophone = false;
      showNetwork = true;
      showWifi = isLaptop;
      showLockStatus = true;
    };
    tray = {
      background = true;
      recolour = true;
      compact = true;
    };
  };
}
