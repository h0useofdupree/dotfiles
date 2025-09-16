{
  programs.aria2 = {
    enable = true;
    settings = {
      ## === General ===
      continue = true; # Always resume downloads if possible
      max-tries = 0; # Retry forever
      retry-wait = 30; # Wait 30s between retries
      timeout = 60; # Connection timeout
      max-file-not-found = 0; # Keep retrying on 404/503 instead of giving up

      ## === Connections ===
      split = 8; # Split each file into 8 segments
      max-connection-per-server = 8; # Up to 8 connections per server
      min-split-size = "1M"; # Smallest piece size before splitting further

      ## === Performance ===
      disk-cache = "64M"; # Cache to reduce disk writes
      enable-mmap = true; # Use mmap to speed disk I/O
      file-allocation = "falloc"; # Pre-allocate space efficiently

      ## === User Experience ===
      summary-interval = 0; # Disable 60s summary spam (0 = no summary)
      console-log-level = "warn"; # Less noisy (warn/error only)
      check-integrity = false; # Faster start, skip hash check unless needed

      ## === Misc ===
      allow-overwrite = false; # Never overwrite finished files
      auto-file-renaming = true; # Rename duplicates instead of overwriting
    };
  };
}
