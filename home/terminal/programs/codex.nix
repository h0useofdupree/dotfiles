{
  programs.codex = {
    enable = true;
    settings = {
      model_provider = "oss";
      model = "gtp-oss:20b";
      approval_policy = "untrusted";
      sandbox_mode = "workspace-write";
      model_providers = {
        oss = {
          name = "Ollama local";
          baseURL = "http://localhost:11434/v1";
        };
      };
      profiles = {
        pvo = {
          model_provider = "oss";
          model = "gtp-oss:20b";
          approval_policy = "untrusted";
          sandbox_mode = "workspace-write";
        };
      };
    };
  };
}
