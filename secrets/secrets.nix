let
  h0useofdupree = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC1JYHp/ZXHErtQVer2eE393NoJgOB6LvVJ+x/IxayS9 joel.riekemann@gmail.com";
  nixus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINFXgN3Ckv//Fk+YALU5f5/bkc5ThavWvLdEqjwxgFgS root@nixus";
in {
  "speakerctl.age".publicKeys = [h0useofdupree nixus];
}
