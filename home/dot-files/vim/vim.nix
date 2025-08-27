{ pkgs, ... }: {
  enable = true;
  plugins = with pkgs.vimPlugins; [
    ale
    nerdtree
    molokai
    dracula-vim
  ];
  settings = {
    ignorecase = true;
    smartcase = true;
    tabstop = 2;
    expandtab = true;
    shiftwidth = 2;
    number = true;
  };
  extraConfig = builtins.readFile ./vimrc;
}
