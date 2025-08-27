{ pkgs, vscodeExtensions }: {
  profiles.default.extensions = with vscodeExtensions.vscode-marketplace; [
    amazonwebservices.amazon-q-vscode
    astro-build.astro-vscode
    eamodio.gitlens
    editorconfig.editorconfig
    esbenp.prettier-vscode
    gruntfuggly.todo-tree
    hashicorp.terraform
    jnoortheen.nix-ide
    ms-python.python
    mads-hartmann.bash-ide-vscode
    mkhl.shfmt
    naumovs.color-highlight
    oderwat.indent-rainbow
    redhat.java
    redhat.vscode-yaml
    timonwong.shellcheck
    vscode-icons-team.vscode-icons
    vscodevim.vim
    zhuangtongfa.material-theme
  ];

  package = pkgs.vscodium;

  enable = true;

  # Prevents VSCodium from add/remove/update extensions
  mutableExtensionsDir = false;

  profiles.default.userSettings = {
    
    "amazonQ.telemetry" = false;
    "amazonQ.shareContentWithAWS" = false;
    "amazonQ.suppressPrompts.amazonQChatDisclaimer" = true;

    # 👩🏽‍💻 Terminal
    "terminal.integrated.fontFamily" = "'Cascadia Code', 'Fira Code', 'Droid Sans Mono', 'monospace'";
    "terminal.external.linuxExec" = "terminator";
    "terminal.integrated.profiles.linux" = {
      "zsh profile" = {
        "path" = "zsh";
        "args" = [ "-l" ];
      };
    };
    "terminal.integrated.defaultProfile.linux" = "zsh profile";

    # Editor
    "editor.fontFamily" = "'Cascadia Code', 'Fira Code', 'Droid Sans Mono', 'monospace'";
    "editor.fontLigatures" = true;
    "editor.rulers" = [ 80 ];
    "editor.tabSize" = 2;
    "editor.detectIndentation" = false;
    "editor.minimap.autohide" = true;

    # Exploorer
    "explorer.compactFolders" = false;

    # Workbench
    "workbench.colorTheme" = "One Dark Pro Darker";
    "workbench.iconTheme" = "vscode-icons";
    "workbench.colorCustomizations" = {
      "editorRuler.foreground" = "#00ff37";
    };
    "workbench.editor.wrapTabs" = true;

    # Nix
    "nix.formattterPath" = "nil";
    "nix.enableLanugageServer" = true;
    "nix.serverPath" = "nil";
    "nix.serverSettings" = {
      "nil" = {
        "formatting" = {
          "command" = [ "nixpkgs-fmt" ];
        };
      };
    };

    # Terraform
    "terraform.languageServer.path" = "/run/current-system/sw/bin/terraform-ls";

    # RedHat
    "redhat.telemetry.enabled" = false;
    "[yaml]" = {
      "editor.defaultFormater" = "redhat.vscode-yaml";
    };
    "java.jdt.ls.java.home" = "${pkgs.jdk}";
    "java.configuration.updateBuildConfiguration" = "automatic";

    # Yaml Schemas
    # Where to force apply yaml formatting
    # yaml.schemas { "https://json.schemastore.org/yamllint.json" = []; };

    #JSON
    "[json]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };
  };

  profiles.default.keybindings = [
    {
      "key" = "shift+enter";
      "command" = "cursorRight";
      "when" = "textInputFocus";
    }
    {
      "key" = "ctrl+shift+right";
      "command" = "workbench.action.moveEditorToRightGroup";
    }
    {
      "key" = "ctrl+shift+left";
      "command" = "workbench.action.moveEditorToLeftGroup";
    }
    {
      "key" = "ctrl+shift+down";
      "command" = "workbench.action.terminal.moveToTerminalPanel";
    }
    {
      "key" = "ctrl+shift+up";
      "command" = "workbench.action.terminal.moveToEditor";
    }
    {
      "key" = "shift+alt+f";
      "command" = "actions.find";
      "when" = "editorFocus || editorIsOpen";
    }
    {
      "key" = "ctrl+f";
      "command" = "-actions.find";
      "when" = "editorFocus || editorIsOpen";
    }
    {
      "key" = "shift+alt+f";
      "command" = "workbench.action.terminal.focusFind";
      "when" = "terminalFindFocused && terminalHasBeenCreated || terminalFindFocused && terminalProcessSupported || terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
    }
    {
      "key" = "ctrl+alt+f";
      "command" = "workbench.action.terminal.focusFind";
      "when" = "terminalFindFocused && terminalHasBeenCreated || terminalFindFocused && terminalProcessSupported || terminalFocusInAny && terminalHasBeenCreated || terminalFocusInAny && terminalProcessSupported";
    }
    {
      "key" = "ctrl+f";
      "command" = "-workbench.action.terminal.focusFind";
      "when" = "terminalFindFocused && terminalHasBeenCreated || terminalFindFocused && terminalProcessSupported || terminalFocusInAny && terminalHasBeenCreated || terminalFocusInAny && terminalProcessSupported";
    }
  ];
}
