{
    programs.nh = {
        enable = true;

        # Weekly cleanup
        clean = {
            enable = true;
            extraArgs = "--keep-since 30d";
        };
    };
}
