{ lib, ... }: {
  enable = true;
  initExtra = lib.mkBefore ''
    bindkey -e
    bindkey -r "^V"
  '';
  shellAliases = {
    # Codium
    code = "codium";

    # Git Aliases
    gcm = "git commit -m";
    gb = "git branch";
    glol = "git log --oneline";
    gconf = "git config";
    ginit = "git init";
    gaa = "git add .";
    gs = "git status";
    gpull = "git pull";
    gres = "git reset";
    grev = "git revert";
    gt = "git tag";
    gclone = "git clone";
    gch = "git checkout";
    gfetch = "git fetch";
    gadd = "git add -i";
    gbD = "git branch -D";
    gsh = "git show";
    gpush = "git push --force-with-lease";
    glolpretty = "git log --graph --decorate --oneline";
    gcomm = "git commit";
    gsw = "git switch";
    gst = "git stash";
    gdiff = "git diff";

    # Docker Aliases
    dockerNuke = "docker system prune -a --volumes";
    dockerLogs = "docker compose logs -f";

    # Gnome
    # Watch Gnome Changes
    watch = "dconf watch /";

    # Kubernetes
    kunset = "kubect config unset current-context";
    ka = "k apply -f";
    kc = "k config";
    kcc = "k config current-context";
    kcg = "k config get-contexts";
    kd = "k describe";
    ke = "k explain --recursive";

    # Nix
    # Update Lock File
    flakeLock = "nix flake lock --recreate-lock-file";
    flakeLint = "nix flake check";
    nixRunExpr = "nix-instantiate --eval --expr";
    nixBuildImage = "nix build -L .#image";
    nixRepl = "nix repl";

    # kubernetes Aliases
    kubeUnset = "kubectl config unset current-context";
  };
}
