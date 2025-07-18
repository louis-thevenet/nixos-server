{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    profiles.default.enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    # i love immutability, but sometimes I want a one-time extension
    mutableExtensionsDir = true;
    profiles.default.extensions = with pkgs.vscode-extensions;
      [
        arrterian.nix-env-selector
        github.copilot
        jnoortheen.nix-ide
        # vscode-extensions.ms-python.python not working currently
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        ms-vscode.makefile-tools
        rust-lang.rust-analyzer
        pkief.material-icon-theme
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "aw-watcher-vscode";
          publisher = "activitywatch";
          version = "0.5.0";
          sha256 = "sha256-OrdIhgNXpEbLXYVJAx/jpt2c6Qa5jf8FNxqrbu5FfFs=";
        }
      ];

    profiles.default.userSettings = {
      "cmake.configureOnOpen" = true;

      "editor.formatOnSave" = true;

      # Indent
      "editor.detectIndentation" = false;
      "editor.indentSize" = 4;
      "editor.insertSpaces" = true;
      "editor.tabSize" = 4;

      "editor.inlineSuggest.enabled" = true;

      # Font
      "editor.fontLigatures" = true;

      "editor.unicodeHighlight.nonBasicASCII" = false;

      "explorer.confirmDragAndDrop" = false;

      "files.eol" = "\n";
      "files.exclude" = {
        "**/.devenv" = true;
        "**/.direnv" = true;
      };
      "files.insertFinalNewline" = true;
      "files.trimTrailingWhitespace" = true;

      "git.autofetch" = true;
      "git.confirmSync" = false;

      "github.copilot.enable" = {
        "*" = true;
        "plaintext" = true;
        "markdown" = true;
      };

      "workbench.iconTheme" = "material-icon-theme";

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nil}/bin/nil";
      "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
      "nix.serverSettings" = {
        nil = {
          formatting = {
            command = ["${pkgs.alejandra}/bin/alejandra"];
          };
          nix = {
            maxMemoryMB = 4096;
            flake = {
              autoEvalInputs = true;
            };
          };
        };
      };

      "python.analysis.typeCheckingMode" = "strict";

      "rust-analyzer.check.command" = "clippy";
      "rust-analyzer.checkOnSave" = true;
    };
  };
}
