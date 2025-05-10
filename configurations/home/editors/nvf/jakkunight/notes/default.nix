_: {
  programs.nvf.settings.vim = {
    notes = {
      # Obsidian:
      obsidian = {
        enable = true;
        setupOpts = {
          workspaces = [
            {
              name = "Notes";
              path = "~/Documents/nvim-obsidian";
              strict = true;
            }
          ];
          completion.nvim-cmp = true;
          daily_notes = {
            date_format = "%A-%d-%m-%Y";
            folder = "notes";
          };
          mappings = {};
        };
      };
      # TODO-Comments:
      todo-comments.enable = true;
    };

    # Obsidian keymaps:
    keymaps = [
      {
        key = "<leader>on";
        mode = ["n"];
        action = ":ObsidianNew ";
        desc = "Create a new note";
      }
      {
        key = "<leader>oo";
        mode = ["n"];
        action = ":ObsidianOpen ";
        desc = "Open a note";
      }
      {
        key = "<leader>oq";
        mode = ["n"];
        action = ":ObsidianQuickSwitch<cr>";
        desc = "Switch to another note";
      }
      {
        key = "<leader>ot";
        mode = ["n"];
        action = ":ObsidianTags ";
        desc = "Get the occurences for the given tags";
      }
      {
        key = "<leader>odt";
        mode = ["n"];
        action = ":ObsidianToday<cr>";
        desc = "Create a new note for today";
      }
      {
        key = "<leader>odp";
        mode = ["n"];
        action = ":ObsidianToday -1<cr>";
        desc = "Create a new note for yesterday";
      }
      {
        key = "<leader>odn";
        mode = ["n"];
        action = ":ObsidianToday +1<cr>";
        desc = "Create a new note for tomorrow";
      }
      {
        key = "<leader>os";
        mode = ["n"];
        action = ":ObsidianSearch ";
        desc = "Search or create notes based on a regex";
      }
      {
        key = "<leader>ol";
        mode = ["n"];
        action = ":ObsidianLink ";
        desc = "Link selected text to a note, ID, or alias";
      }
      {
        key = "<leader>oln";
        mode = ["n"];
        action = ":ObsidianLinkNew ";
        desc = "Link Link selected text to a new note";
      }
      {
        key = "<leader>or";
        mode = ["n"];
        action = ":ObsidianRename ";
        desc = "Rename the current note and all its backlinks";
      }
      {
        key = "<leader>oi";
        mode = ["n"];
        action = ":ObsidianTOC<cr>";
        desc = "Create a TOC for the current note";
      }
      {
        key = "<leader>oc";
        mode = ["n"];
        action = ":ObsidianToggleCheckbox<cr>";
        desc = "Cycle through checkbox options";
      }
    ];
  };
}
