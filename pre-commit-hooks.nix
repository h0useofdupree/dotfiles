{inputs, ...}: {
  imports = [inputs.pre-commit-hooks.flakeModule];

  perSystem.pre-commit = {
    settings.excludes = ["flake.lock"];

    settings.hooks = {
      alejandra.enable = true;
      prettier = {
        enable = true;
        excludes = [".js" ".md" ".ts"];
      };
      flake-checker.enable = true;
      black.enable = true;
      shellcheck.enable = true;
    };
  };
}
