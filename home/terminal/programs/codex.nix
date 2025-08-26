{
  programs.codex = {
    enable = true;
    settings = {
      model_provider = "openai";
      model = "gtp-5";

      approval_policy = "untrusted";
      sandbox_mode = "workspace-write";

      model_providers = {
        openai = {
          name = "OpenAI";

          baseURL = "https://api.openai.com/v1";
        };
        oss = {
          name = "Ollama local";
          baseURL = "http://localhost:11434/v1";
        };
      };
      profiles = {
        main = {
          model_provider = "openai";
          model = "gpt-5";
          approval_policy = "untrusted";
          sandbox_mode = "workspace-write";
        };

        local = {
          model_provider = "oss";
          model = "gtp-oss:20b";
          approval_policy = "untrusted";
          sandbox_mode = "workspace-write";
        };
      };
    };
  };
}
