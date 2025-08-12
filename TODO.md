# TODO

## OpenRGB

- Write a script that gets colors from the wallpaper and applies them

> [!IMPORTANT]
> Make sure the "this device has no direct mode" warning isn't important

## Styling

- Blur Hyprlock
- Give Hyprlock a new layout/style

## Caelestia

- [x] research app unit and try to use uwsm app for launcher instead

### linx

> [!IMPORTANT]
> Powersaving with:

```nix
let
  script = ''
    echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
    echo 1 > /sys/module/snd_hda_intel/parameters/power_save
    echo 0 > /proc/sys/kernel/nmi_watchdog

    for i in /sys/bus/pci/devices/*; do
      echo auto > "$i/power/control"
    done
  '';
in {
  systemd.services.powersave = {
    enable = true;

    description = "Apply power saving tweaks";
    wantedBy = ["multi-user.target"];

    inherit script;
  };
}
```

