{
  defaultSopsFile = "/home/randomindie/.sops/secrets.yaml";
  defaultSopsFormat = "yaml";
  age = {
    keyFile = "/home/randomindie/.config/sops/age/keys.txt";
    generateKey = true;
  };
  validateSopsFiles = false;
  secrets = {
    randomindie.neededForUsers = true;
    "github/ssh" = {
      owner = "randomindie";
    };
  };
}
