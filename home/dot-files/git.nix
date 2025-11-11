{ pkgs, ... }: {
  enable = true;
  settings = {
    user.name = "cshirley14";
    user.email = "47926057+cShirley14@users.noreply.github.com";
    commit.gpgsign = true;
    gpg.format = "ssh";
    gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    user.signingkey = "~/.ssh/id_ed25519.pub";

    core = {
      editor = "vim";
      pager = "${pkgs.delta}/bin/delta";
    };
    branch = {
      autoSetupMerge = "inherit";
      autoSetupRebase = "always";
    };
    delta = {
      line-numbers = true;
      navigate = true;
    };
    diff = {
      colorMoved = "default";
    };
    fetch = {
      prune = true;
    };
    interactive = {
      diffFilter = "${pkgs.delta}/bin/delta --color-only";
    };
    merge = {
      conflictstyle = "diff3";
    };
    pull = {
      rebase = true;
    };
    push = {
      autoSetupRemote = true;
      default = "current";
    };
    rebase = {
      autostash = true;
      autosquash = true;
    };
  };
}
