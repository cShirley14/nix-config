{ pkgs, ... }: {
  enable = true;
  userName = "cshirley14";
  userEmail = "47926057+cShirley14@users.noreply.github.com";
  extraConfig = {
    commit.gpgsign = true;
    gpg.format = "ssh";
    gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    user.signingkey = "~/.ssh/id_ed25519.pub";

    core.editor = "vim";
    branch = {
      autoSetupMerge = "inherit";
      autoSetupRebase = "always";
    };
    core = {
      pager = "${pkgs.delta}/bin/delta";
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
