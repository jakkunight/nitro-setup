_: {
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    loadModels = [
      "deepseek-r1:8b"
      "deepseek-r1:14b"
      "deepseek-r1:32b"
    ];
  };
}
