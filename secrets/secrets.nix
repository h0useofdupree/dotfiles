let
  h0useofdupree = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1JYHp/ZXHErtQVer2eE393NoJgOB6LvVJ+x/IxayS9 joel.riekemann@gmail.com";

  nixus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINFXgN3Ckv//Fk+YALU5f5/bkc5ThavWvLdEqjwxgFgS root@nixus";
  linx = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOUt3ZeBEajsvYdWePId2leizebVy+awgNaZPcrIWngi root@nixos";
  hosts = [nixus linx];
in {
  "speakerctl-devices.age".publicKeys = [h0useofdupree nixus];
  "weatherapi-key.age".publicKeys = [h0useofdupree] ++ hosts;
}
