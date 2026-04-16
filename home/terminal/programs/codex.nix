# TODO: Update
{
  programs.codex = {
    enable = true;
    settings = {
      model_provider = "openai";
      model = "gpt-5.4";

      approval_policy = "untrusted";
      sandbox_mode = "workspace-write";

      model_providers = {
        oss = {
          name = "Ollama local";
          baseURL = "http://localhost:11434/v1";
        };
      };
      profiles = {
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
