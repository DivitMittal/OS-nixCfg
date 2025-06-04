{
  mgr = {
    keymap = [
      {
        desc = "Exit visual mode, clear selected, or cancel search";
        on = ["<Esc>"];
        run = "escape";
      }
      {
        desc = "Exit the process";
        on = ["q"];
        run = "quit";
      }
      {
        desc = "Exit the process without writing cwd-file";
        on = ["Q"];
        run = "quit --no-cwd-file";
      }
      {
        desc = "Close the current tab, or quit if it is last tab";
        on = ["<C-w>"];
        run = "close";
      }
      {
        desc = "Suspend the process";
        on = ["<C-z>"];
        run = "suspend";
      }
      # Hopping
      {
        desc = "Move cursor up";
        on = ["<Up>"];
        run = "arrow -1";
      }
      {
        desc = "Move cursor down";
        on = ["<Down>"];
        run = "arrow 1";
      }
      {
        desc = "Move cursor up one page";
        on = ["<PageUp>"];
        run = "arrow -100%";
      }
      {
        desc = "Move cursor down one page";
        on = ["<PageDown>"];
        run = "arrow 100%";
      }
      {
        desc = "Seek up 5 units in the preview";
        on = ["<A-Up>"];
        run = "seek -5";
      }
      {
        desc = "Seek down 5 units in the preview";
        on = ["<A-Down>"];
        run = "seek 5";
      }
      {
        desc = "Go back to the parent directory";
        on = ["<Left>"];
        run = "leave";
      }
      {
        desc = "Enter the child directory";
        on = ["<Right>"];
        run = "enter";
      }
      {
        desc = "Move cursor to the top";
        on = ["g" "g"];
        run = "arrow top";
      }
      {
        desc = "Move cursor to the bottom";
        on = ["G"];
        run = "arrow bot";
      }
      {
        desc = "Toggle the current selection state";
        on = ["<Space>"];
        run = ["toggle --state=none" "arrow 1"];
      }
      {
        desc = "Enter visual mode (selection mode)";
        on = ["V"];
        run = "visual_mode";
      }
      {
        desc = "Select all files";
        on = ["<C-a>"];
        run = "toggle_all --state=true";
      }
      {
        desc = "Inverse selection of all files";
        on = ["<C-r>"];
        run = "toggle_all --state=none";
      }
      {
        desc = "Open the selected files";
        on = ["o"];
        run = "open";
      }
      {
        desc = "Open the selected files";
        on = ["<Enter>"];
        run = "open";
      }
      {
        desc = "Open the selected files interactively";
        on = ["O"];
        run = "open --interactive";
      }
      {
        desc = "Copy the selected files";
        on = ["y"];
        run = ["yank" "escape --visual --select"];
      }
      {
        desc = "Cut the selected files";
        on = ["x"];
        run = ["yank --cut" "escape --visual --select"];
      }
      {
        desc = "Cancel the yank status of files";
        on = ["X"];
        run = ["unyank" "escape --visual --select"];
      }
      {
        desc = "Paste the files";
        on = ["p"];
        run = "paste";
      }
      {
        desc = "Paste the files (overwrite)";
        on = ["P"];
        run = "paste --force";
      }
      {
        desc = "Move the files to the trash";
        on = ["d"];
        run = ["remove" "escape --visual --select"];
      }
      {
        desc = "Permanently delete the files";
        on = ["D"];
        run = ["remove --permanently" "escape --visual --select"];
      }
      {
        desc = "Create a file or directory(append /)";
        on = ["a"];
        run = "create";
      }
      {
        desc = "Rename a file ordirectory";
        on = ["r"];
        run = "rename --cursor=before_ext";
      }
      {
        desc = "Symlink the absolute path of files";
        on = ["-"];
        run = "link";
      }
      {
        desc = "Symlink the relative path of files";
        on = ["_"];
        run = "link --relative";
      }
      {
        desc = "Hardlink files";
        on = ["<C-->"];
        run = "hardlink";
      }
      {
        desc = "Run a shell command";
        on = [":"];
        run = "shell --interactive";
      }
      {
        desc = "Run a shell command & block UI";
        on = [";"];
        run = "shell --interactive --block";
      }
      {
        desc = "Toggle the visibility of hidden files";
        on = ["."];
        run = "hidden toggle";
      }
      # change linemode
      {
        desc = "Set linemode to size";
        on = ["m" "s"];
        run = "linemode size";
      }
      {
        desc = "Set linemode to permissions";
        on = ["m" "p"];
        run = "linemode permissions";
      }
      {
        desc = "Set linemode to mtime";
        on = ["m" "m"];
        run = "linemode mtime";
      }
      {
        desc = "Set linemode to none";
        on = ["m" "n"];
        run = "linemode none";
      }
      # copy mode
      {
        desc = "Copy the absolute path";
        on = ["c" "c"];
        run = "copy path";
      }
      {
        desc = "Copy the path of the parent directory";
        on = ["c" "d"];
        run = "copy dirname";
      }
      {
        desc = "Copy the name of the file";
        on = ["c" "f"];
        run = "copy filename";
      }
      {
        desc = "Copy the name of the file without the extension";
        on = ["c" "n"];
        run = "copy name_without_ext";
      }
      # Sorting
      {
        desc = "Sort by modified time";
        on = ["b" "m"];
        run = "sort modified --dir-first";
      }
      {
        desc = "Sort by modified time (reverse)";
        on = ["b" "M"];
        run = "sort modified --reverse --dir-first";
      }
      {
        desc = "Sort by created time";
        on = ["b" "c"];
        run = "sort created --dir-first";
      }
      {
        desc = "Sort by created time (reverse)";
        on = ["b" "C"];
        run = "sort created --reverse --dir-first";
      }
      {
        desc = "Sort by extension";
        on = ["b" "e"];
        run = "sort extension --dir-first";
      }
      {
        desc = "Sort by extension (reverse)";
        on = ["b" "E"];
        run = "sort extension --reverse --dir-first";
      }
      {
        desc = "Sort alphabetically";
        on = ["b" "a"];
        run = "sort alphabetical --dir-first";
      }
      {
        desc = "Sort alphabetically (reverse)";
        on = ["b" "A"];
        run = "sort alphabetical --reverse --dir-first";
      }
      {
        desc = "Sort naturally";
        on = ["b" "n"];
        run = "sort natural --dir-first";
      }
      {
        desc = "Sort naturally (reverse)";
        on = ["b" "N"];
        run = "sort natural --reverse --dir-first";
      }
      {
        desc = "Sort by size";
        on = ["b" "s"];
        run = "sort size --dir-first";
      }
      {
        desc = "Sort by size (reverse)";
        on = ["b" "S"];
        run = "sort size --reverse --dir-first";
      }
      # Tabbing
      {
        desc = "Create a new tab using the current path";
        on = ["t" "t"];
        run = "tab_create --current";
      }
      {
        desc = "Close a tab using the current path";
        on = ["t" "c"];
        run = "tab_close --current";
      }
      {
        desc = "Switch to the next tab";
        on = ["t" "n"];
        run = "tab_switch 1 --relative";
      }
      {
        desc = "Switch to the previous tab";
        on = ["t" "p"];
        run = "tab_switch -1 --relative";
      }
      {
        desc = "Switch to the first tab";
        on = ["1"];
        run = "tab_switch 0";
      }
      {
        desc = "Switch to the second tab";
        on = ["2"];
        run = "tab_switch 1";
      }
      {
        desc = "Switch to the third tab";
        on = ["3"];
        run = "tab_switch 2";
      }
      {
        desc = "Switch to the fourth tab";
        on = ["4"];
        run = "tab_switch 3";
      }
      {
        desc = "Switch to the fifth tab";
        on = ["5"];
        run = "tab_switch 4";
      }
      {
        desc = "Switch to the sixth tab";
        on = ["6"];
        run = "tab_switch 5";
      }
      {
        desc = "Switch to the seventh tab";
        on = ["7"];
        run = "tab_switch 6";
      }
      {
        desc = "Switch to the eighth tab";
        on = ["8"];
        run = "tab_switch 7";
      }
      {
        desc = "Switch to the ninth tab";
        on = ["9"];
        run = "tab_switch 8";
      }
      {
        desc = "Swap the current tab with the previous tab";
        on = ["{"];
        run = "tab_swap -1";
      }
      {
        desc = "Swap the current tab with the next tab";
        on = ["}"];
        run = "tab_swap 1";
      }
      # filter
      {
        desc = "Filter the files";
        on = ["f"];
        run = "filter --smart";
      }
      # searching
      {
        desc = "Search files by name using fd";
        on = ["s"];
        run = "search fd";
      }
      {
        desc = "Search files by content using ripgrep";
        on = ["S"];
        run = "search rg";
      }
      {
        desc = "Cancel the ongoing search";
        on = ["<C-s>"];
        run = "search none";
      }
      # find
      {
        desc = "Find next file";
        on = ["/"];
        run = "find --smart";
      }
      {
        desc = "Find previous file";
        on = ["?"];
        run = "find --previous --smart";
      }
      {
        desc = "Go to next found file";
        on = ["n"];
        run = "find_arrow";
      }
      {
        desc = "Go to previous found file";
        on = ["N"];
        run = "find_arrow --previous";
      }
      # goto/change directory
      {
        desc = "Go to the home directory";
        on = ["g" "h"];
        run = "cd ~";
      }
      {
        desc = "Go to the config directory";
        on = ["g" "c"];
        run = "cd ~/.config";
      }
      {
        desc = "Go to the downloads directory";
        on = ["g" "d"];
        run = "cd ~/Downloads";
      }
      {
        desc = "Go to a directory interactively";
        on = ["g" "<Space>"];
        run = "cd --interactive";
      }
      {
        desc = "Jump to a directory using zoxide";
        on = ["g" "z"];
        run = "plugin zoxide";
      }
      {
        desc = "Jump to a directory, or reveal a file using fzf";
        on = ["g" "f"];
        run = "plugin fzf";
      }
      {
        desc = "Show the tasks manager";
        on = ["w"];
        run = "tasks_show";
      }
      {
        desc = "Open help";
        on = ["~"];
        run = "help";
      }
    ];
    prepend_keymap = [
      {
        desc = "Open shell here";
        on = ["!"];
        for = "unix";
        run = "shell \"$SHELL\" --block --confirm";
      }
      {
        desc = "Open shell here";
        on = ["!"];
        for = "windows";
        run = "shell \"pwsh.exe\" --block --confirm";
      }
      {
        desc = "Enter the child directory, or open the file";
        on = ["<Right>"];
        run = "plugin smart-enter";
      }
    ];
    append_keymap = [
      {
        desc = "A mount manager providing disk mount, unmount, and eject functionality";
        on = ["<C-m>"];
        run = "plugin mount";
      }
      {
        desc = "Maximize or restore the preview pane";
        on = ["T"];
        run = "plugin toggle-pane max-preview";
      }
      {
        desc = "Smart filter";
        on = ["F"];
        run = "plugin smart-filter";
      }
      {
        desc = "chmod on selected files";
        on = ["<C-p>"];
        run = "plugin chmod";
      }
      {
        desc = "diff selected file with hovered file";
        on = ["<C-d>"];
        run = "plugin diff";
      }
      {
        desc = "Run Lazygit";
        on = ["g" "l"];
        run = "plugin lazygit";
      }
    ];
  };

  input = {
    keymap = [
      {
        desc = "Go back the normal mode, or cancel input";
        on = ["<Esc>"];
        run = "escape";
      }
      {
        desc = "Submit the input";
        on = ["<Enter>"];
        run = "close --submit";
      }
      # basic vim style editing
      {
        desc = "Enter insert mode";
        on = ["i"];
        run = "insert";
      }
      {
        desc = "Enter append mode";
        on = ["a"];
        run = "insert --append";
      }
      {
        desc = "Move to the BOL, and enter insert mode";
        on = ["I"];
        run = ["move -999" "insert"];
      }
      {
        desc = "Move to the EOL, and enter append mode";
        on = ["A"];
        run = ["move 999" "insert --append"];
      }
      {
        desc = "Enter visual mode";
        on = ["v"];
        run = "visual";
      }
      {
        desc = "Enter visual mode and select all";
        on = ["V"];
        run = ["move -999" "visual" "move 999"];
      }
      {
        desc = "Move back a character";
        on = ["<Left>"];
        run = "move -1";
      }
      {
        desc = "Move forward a character";
        on = ["<Right>"];
        run = "move 1";
      }
      {
        desc = "Move back to the start of the current or previous word";
        on = ["b"];
        run = "backward";
      }
      {
        desc = "Move forward to the start of the next word";
        on = ["w"];
        run = "forward";
      }
      {
        desc = "Move forward to the end of the current or next word";
        on = ["e"];
        run = "forward --end-of-word";
      }
      {
        desc = "Move to the BOL";
        on = ["0"];
        run = "move -999";
      }
      {
        desc = "Move to the EOL";
        on = ["$"];
        run = "move 999";
      }
      {
        desc = "Delete the character before the cursor";
        on = ["<Backspace>"];
        run = "backspace";
      }
      {
        desc = "Cut the selected characters";
        on = ["d"];
        run = "delete --cut";
      }
      {
        desc = "Cut until the EOL";
        on = ["D"];
        run = ["delete --cut" "move 999"];
      }
      {
        desc = "Cut the selected characters, and enter insert mode";
        on = ["c"];
        run = "delete --cut --insert";
      }
      {
        desc = "Cut until the EOL, and enter insert mode";
        on = ["C"];
        run = ["delete --cut --insert" "move 999"];
      }
      {
        desc = "Cut the current character";
        on = ["x"];
        run = ["delete --cut" "move 1 --in-operating"];
      }
      {
        desc = "Copy the selected characters";
        on = ["y"];
        run = "yank";
      }
      {
        desc = "Paste the copied characters after the cursor";
        on = ["p"];
        run = "paste";
      }
      {
        desc = "Paste the copied characters before the cursor";
        on = ["P"];
        run = "paste --before";
      }
      {
        desc = "Undo the last operation";
        on = ["U"];
        run = "undo";
      }
      {
        desc = "Redo the last operation";
        on = ["R"];
        run = "redo";
      }
      {
        desc = "Open help";
        on = ["~"];
        run = "help";
      }
    ];
    append_keymap = [
      {
        desc = "Open help";
        on = ["?"];
        run = "help";
      }
    ];
  };

  completion = {
    keymap = [
      {
        desc = "Cancel completion";
        on = ["<Esc>"];
        run = "close";
      }
      {
        desc = "Submit the completion";
        on = ["<Tab>"];
        run = "close --submit";
      }
      {
        desc = "Submit the completion and input";
        on = ["<Enter>"];
        run = ["close --submit" "close_input --submit"];
      }
      {
        desc = "Move cursor up";
        on = ["<Up>"];
        run = "arrow -1";
      }
      {
        desc = "Move cursor down";
        on = ["<Down>"];
        run = "arrow 1";
      }
      {
        desc = "Open help";
        on = ["~"];
        run = "help";
      }
    ];
    append_keymap = [
      {
        desc = "Open help";
        on = ["?"];
        run = "help";
      }
    ];
  };

  tasks = {
    keymap = [
      {
        desc = "Hide the task manager";
        on = ["<Esc>"];
        run = "close";
      }
      {
        desc = "Hide the task manager";
        on = ["w"];
        run = "close";
      }
      {
        desc = "Move cursor up";
        on = ["<Up>"];
        run = "arrow -1";
      }
      {
        desc = "Move cursor down";
        on = ["<Down>"];
        run = "arrow 1";
      }
      {
        desc = "Inspect the task";
        on = ["<Enter>"];
        run = "inspect";
      }
      {
        desc = "Cancel the task";
        on = ["k"];
        run = "cancel";
      }
      {
        desc = "Open help";
        on = ["~"];
        run = "help";
      }
    ];
    append_keymap = [
      {
        desc = "Open help";
        on = ["?"];
        run = "help";
      }
    ];
  };

  help = {
    keymap = [
      {
        desc = "Clear the filter, or hide the help";
        on = ["<Esc>"];
        run = "escape";
      }
      {
        desc = "Move cursor up";
        on = ["<Up>"];
        run = "arrow -1";
      }
      {
        desc = "Move cursor down";
        on = ["<Down>"];
        run = "arrow 1";
      }
      {
        desc = "Apply a filter for the help items";
        on = ["/"];
        run = "filter";
      }
      {
        desc = "Exit the process";
        on = ["~"];
        run = "close";
      }
    ];
    append_keymap = [
      {
        desc = "Close help";
        on = ["?"];
        run = "close";
      }
    ];
  };
}