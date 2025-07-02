{config, ...}: {
  speakerctl = {
    enable = true;
    devicesFile = config.age.secrets.speakerctl-devices.path;
  };
}
