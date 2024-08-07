{
  completion = {
    keymap = [
      { desc = "Cancel completion"              ; on = [ "<C-q>" ]  ; run = "close"                                    ; }
      { desc = "Submit the completion"          ; on = [ "<Tab>" ]  ; run = "close --submit"                           ; }
      { desc = "Submit the completion and input"; on = [ "<Enter>" ]; run = [ "close --submit" "close_input --submit" ]; }
      { desc = "Move cursor up"                 ; on = [ "<A-k>" ]  ; run = "arrow -1"                                 ; }
      { desc = "Move cursor down"               ; on = [ "<A-j>" ]  ; run = "arrow 1"                                  ; }
      { desc = "Move cursor up"                 ; on = [ "<Up>" ]   ; run = "arrow -1"                                 ; }
      { desc = "Move cursor down"               ; on = [ "<Down>" ] ; run = "arrow 1"                                  ; }
      { desc = "Open help"                      ; on = [ "~" ]      ; run = "help"                                     ; }
    ];
  };
  help = {
    keymap = [
      { desc = "Clear the filter, or hide the help"; on = [ "<Esc>" ]   ; run = "escape"  ; }
      { desc = "Exit the process"                  ; on = [ "q" ]       ; run = "close"   ; }
      { desc = "Hide the help"                     ; on = [ "<C-q>" ]   ; run = "close"   ; }
      { desc = "Move cursor up"                    ; on = [ "<Up>" ]    ; run = "arrow -1"; }
      { desc = "Move cursor down"                  ; on = [ "<Down>" ]  ; run = "arrow 1" ; }
      { desc = "Move cursor up 5 lines"            ; on = [ "<S-Up>" ]  ; run = "arrow -5"; }
      { desc = "Move cursor down 5 lines"          ; on = [ "<S-Down>" ]; run = "arrow 5" ; }
      # { desc = "Apply a filter for the help items" ; on = [ "/" ]       ; run = "filter"  ; }
    ];
  };
  input = {
    keymap = [
      { desc = "Cancel input"                                          ; on = [ "<C-q>" ]      ; run = "close"                                   ; }
      { desc = "Submit the input"                                      ; on = [ "<Enter>" ]    ; run = "close --submit"                          ; }
      { desc = "Go back the normal mode, or cancel input"              ; on = [ "<Esc>" ]      ; run = "escape"                                  ; }
      { desc = "Enter insert mode"                                     ; on = [ "i" ]          ; run = "insert"                                  ; }
      { desc = "Enter append mode"                                     ; on = [ "a" ]          ; run = "insert --append"                         ; }
      { desc = "Move to the BOL, and enter insert mode"                ; on = [ "I" ]          ; run = [ "move -999" "insert" ]                  ; }
      { desc = "Move to the EOL, and enter append mode"                ; on = [ "A" ]          ; run = [ "move 999" "insert --append" ]          ; }
      { desc = "Enter visual mode"                                     ; on = [ "v" ]          ; run = "visual"                                  ; }
      { desc = "Enter visual mode and select all"                      ; on = [ "V" ]          ; run = [ "move -999" "visual" "move 999" ]       ; }
      { desc = "Move back a character"                                 ; on = [ "<Left>" ]     ; run = "move -1"                                 ; }
      { desc = "Move forward a character"                              ; on = [ "<Right>" ]    ; run = "move 1"                                  ; }
      { desc = "Move back a character"                                 ; on = [ "<C-b>" ]      ; run = "move -1"                                 ; }
      { desc = "Move forward a character"                              ; on = [ "<C-f>" ]      ; run = "move 1"                                  ; }
      { desc = "Move back to the start of the current or previous word"; on = [ "b" ]          ; run = "backward"                                ; }
      { desc = "Move forward to the start of the next word"            ; on = [ "w" ]          ; run = "forward"                                 ; }
      { desc = "Move forward to the end of the current or next word"   ; on = [ "e" ]          ; run = "forward --end-of-word"                   ; }
      { desc = "Move back to the start of the current or previous word"; on = [ "<A-b>" ]      ; run = "backward"                                ; }
      { desc = "Move forward to the end of the current or next word"   ; on = [ "<A-f>" ]      ; run = "forward --end-of-word"                   ; }
      { desc = "Move to the BOL"                                       ; on = [ "0" ]          ; run = "move -999"                               ; }
      { desc = "Move to the EOL"                                       ; on = [ "$" ]          ; run = "move 999"                                ; }
      { desc = "Move to the BOL"                                       ; on = [ "<C-a>" ]      ; run = "move -999"                               ; }
      { desc = "Move to the EOL"                                       ; on = [ "<C-e>" ]      ; run = "move 999"                                ; }
      { desc = "Delete the character before the cursor"                ; on = [ "<Backspace>" ]; run = "backspace"                               ; }
      { desc = "Delete the character before the cursor"                ; on = [ "<C-h>" ]      ; run = "backspace"                               ; }
      { desc = "Kill backwards to the BOL"                             ; on = [ "<C-u>" ]      ; run = "kill bol"                                ; }
      { desc = "Kill forwards to the EOL"                              ; on = [ "<C-k>" ]      ; run = "kill eol"                                ; }
      { desc = "Kill backwards to the start of the current word"       ; on = [ "<C-w>" ]      ; run = "kill backward"                           ; }
      { desc = "Kill forwards to the end of the current word"          ; on = [ "<A-d>" ]      ; run = "kill forward"                            ; }
      { desc = "Cut the selected characters"                           ; on = [ "d" ]          ; run = "delete --cut"                            ; }
      { desc = "Cut until the EOL"                                     ; on = [ "D" ]          ; run = [ "delete --cut" "move 999" ]             ; }
      { desc = "Cut the selected characters, and enter insert mode"    ; on = [ "c" ]          ; run = "delete --cut --insert"                   ; }
      { desc = "Cut until the EOL, and enter insert mode"              ; on = [ "C" ]          ; run = [ "delete --cut --insert" "move 999" ]    ; }
      { desc = "Cut the current character"                             ; on = [ "x" ]          ; run = [ "delete --cut" "move 1 --in-operating" ]; }
      { desc = "Copy the selected characters"                          ; on = [ "y" ]          ; run = "yank"                                    ; }
      { desc = "Paste the copied characters after the cursor"          ; on = [ "p" ]          ; run = "paste"                                   ; }
      { desc = "Paste the copied characters before the cursor"         ; on = [ "P" ]          ; run = "paste --before"                          ; }
      { desc = "Undo the last operation"                               ; on = [ "u" ]          ; run = "undo"                                    ; }
      { desc = "Redo the last operation"                               ; on = [ "<C-r>" ]      ; run = "redo"                                    ; }
      { desc = "Open help"                                             ; on = [ "~" ]          ; run = "help"                                    ; }
    ];
  };
  manager = {
    keymap = [
      { desc = "Exit visual mode, clear selected, or cancel search"           ; on = [ "<Esc>" ]       ; run = "escape"                                             ; }
      { desc = "Exit the process"                                             ; on = [ "q" ]           ; run = "quit"                                               ; }
      { desc = "Exit the process without writing cwd-file"                    ; on = [ "Q" ]           ; run = "quit --no-cwd-file"                                 ; }
      { desc = "Close the current tab, or quit if it is last tab"             ; on = [ "<C-q>" ]       ; run = "close"                                              ; }
      { desc = "Suspend the process"                                          ; on = [ "<C-z>" ]       ; run = "suspend"                                            ; }
      { desc = "Move cursor up 5 lines"                                       ; on = [ "<S-Up>" ]      ; run = "arrow -5"                                           ; }
      { desc = "Move cursor down 5 lines"                                     ; on = [ "<S-Down>" ]    ; run = "arrow 5"                                            ; }
      { desc = "Move cursor up halfpage"                                      ; on = [ "<C-u>" ]       ; run = "arrow -50%"                                         ; }
      { desc = "Move cursor down half page"                                   ; on = [ "<C-d>" ]       ; run = "arrow 50%"                                          ; }
      { desc = "Move cursor up one page"                                      ; on = [ "<C-b>" ]       ; run = "arrow -100%"                                        ; }
      { desc = "Move cursor down one page"                                    ; on = [ "<C-f>" ]       ; run = "arrow 100%"                                         ; }
      { desc = "Move cursor up half page"                                     ; on = [ "<C-PageUp>" ]  ; run = "arrow -50%"                                         ; }
      { desc = "Move cursor down half page"                                   ; on = [ "<C-PageDown>" ]; run = "arrow 50%"                                          ; }
      { desc = "Move cursor up one page"                                      ; on = [ "<PageUp>" ]    ; run = "arrow -100%"                                        ; }
      { desc = "Move cursor down one page"                                    ; on = [ "<PageDown>" ]  ; run = "arrow 100%"                                         ; }
      { desc = "Seek up 5 units in the preview"                               ; on = [ "<A-k>" ]       ; run = "seek -5"                                            ; }
      { desc = "Seek down 5 units in the preview"                             ; on = [ "<A-j>" ]       ; run = "seek 5"                                             ; }
      { desc = "Seek up 5 units in the preview"                               ; on = [ "<A-PageUp>" ]  ; run = "seek -5"                                            ; }
      { desc = "Seek down 5 units in the preview"                             ; on = [ "<A-PageDown>" ]; run = "seek 5"                                             ; }
      { desc = "Move cursor up"                                               ; on = [ "<Up>" ]        ; run = "arrow -1"                                           ; }
      { desc = "Move cursor down"                                             ; on = [ "<Down>" ]      ; run = "arrow 1"                                            ; }
      { desc = "Go back to the parent directory"                              ; on = [ "<Left>" ]      ; run = "leave"                                              ; }
      { desc = "Enter the child directory"                                    ; on = [ "<Right>" ]     ; run = "enter"                                              ; }
      { desc = "Move cursor to the top"                                       ; on = [ "g" "g" ]       ; run = "arrow -99999999"                                    ; }
      { desc = "Move cursor to the bottom"                                    ; on = [ "G" ]           ; run = "arrow 99999999"                                     ; }
      { desc = "Toggle the current selection state"                           ; on = [ "<Space>" ]     ; run = [ "select --state=none" "arrow 1" ]                  ; }
      { desc = "Enter visual mode (selection mode)"                           ; on = [ "v" ]           ; run = "visual_mode"                                        ; }
      { desc = "Enter visual mode (unset mode)"                               ; on = [ "V" ]           ; run = "visual_mode --unset"                                ; }
      { desc = "Select all files"                                             ; on = [ "<C-a>" ]       ; run = "select_all --state=true"                            ; }
      { desc = "Inverse selection of all files"                               ; on = [ "<C-r>" ]       ; run = "select_all --state=none"                            ; }
      { desc = "Open the selected files"                                      ; on = [ "o" ]           ; run = "open"                                               ; }
      { desc = "Open the selected files interactively"                        ; on = [ "O" ]           ; run = "open --interactive"                                 ; }
      { desc = "Open the selected files"                                      ; on = [ "<Enter>" ]     ; run = "open"                                               ; }
      { desc = "Open the selected files interactively"                        ; on = [ "<C-Enter>" ]   ; run = "open --interactive"                                 ; }
      { desc = "Copy the selected files"                                      ; on = [ "y" ]           ; run = [ "yank" "escape --visual --select" ]                ; }
      { desc = "Cancel the yank status of files"                              ; on = [ "Y" ]           ; run = [ "unyank" "escape --visual --select" ]              ; }
      { desc = "Cut the selected files"                                       ; on = [ "x" ]           ; run = [ "yank --cut" "escape --visual --select" ]          ; }
      { desc = "Paste the files"                                              ; on = [ "p" ]           ; run = "paste"                                              ; }
      { desc = "Paste the files (overwrite if the destination exists)"        ; on = [ "P" ]           ; run = "paste --force"                                      ; }
      { desc = "Symlink the absolute path of files"                           ; on = [ "-" ]           ; run = "link"                                               ; }
      { desc = "Symlink the relative path of files"                           ; on = [ "_" ]           ; run = "link --relative"                                    ; }
      { desc = "Move the files to the trash"                                  ; on = [ "d" ]           ; run = [ "remove" "escape --visual --select" ]              ; }
      { desc = "Permanently delete the files"                                 ; on = [ "D" ]           ; run = [ "remove --permanently" "escape --visual --select" ]; }
      { desc = "Create a file or directory (ends with / for directories)"     ; on = [ "a" ]           ; run = "create"                                             ; }
      { desc = "Rename a file ordirectory"                                    ; on = [ "r" ]           ; run = "rename --cursor=before_ext"                         ; }
      { desc = "Run a shell command"                                          ; on = [ ";" ]           ; run = "shell --interactive"                                ; }
      { desc = "Run a shell command (block the UI until the command finishes)"; on = [ ":" ]           ; run = "shell --interactive --block"                        ; }
      { desc = "Toggle the visibility of hidden files"                        ; on = [ "." ]           ; run = "hidden toggle"                                      ; }
      { desc = "Search files by name using fd"                                ; on = [ "s" ]           ; run = "search fd"                                          ; }
      { desc = "Search files by content using ripgrep"                        ; on = [ "S" ]           ; run = "search rg"                                          ; }
      { desc = "Cancel the ongoing search"                                    ; on = [ "<C-s>" ]       ; run = "search none"                                        ; }
      { desc = "Jump to a directory using zoxide"                             ; on = [ "z" ]           ; run = "jump zoxide"                                        ; }
      { desc = "Jump to a directory, or reveal a file using fzf"              ; on = [ "Z" ]           ; run = "jump fzf"                                           ; }
      { desc = "Set linemode to size"                                         ; on = [ "m" "s" ]       ; run = "linemode size"                                      ; }
      { desc = "Set linemode to permissions"                                  ; on = [ "m" "p" ]       ; run = "linemode permissions"                               ; }
      { desc = "Set linemode to mtime"                                        ; on = [ "m" "m" ]       ; run = "linemode mtime"                                     ; }
      { desc = "Set linemode to none"                                         ; on = [ "m" "n" ]       ; run = "linemode none"                                      ; }
      { desc = "Copy the absolute path"                                       ; on = [ "c" "c" ]       ; run = "copy path"                                          ; }
      { desc = "Copy the path of the parent directory"                        ; on = [ "c" "d" ]       ; run = "copy dirname"                                       ; }
      { desc = "Copy the name of the file"                                    ; on = [ "c" "f" ]       ; run = "copy filename"                                      ; }
      { desc = "Copy the name of the file without the extension"              ; on = [ "c" "n" ]       ; run = "copy name_without_ext"                              ; }
      { desc = "Filter the files"                                             ; on = [ "f" ]           ; run = "filter --smart"                                     ; }
      { desc = "Find next file"                                               ; on = [ "/" ]           ; run = "find --smart"                                       ; }
      { desc = "Find previous file"                                           ; on = [ "?" ]           ; run = "find --previous --smart"                            ; }
      { desc = "Go to next found file"                                        ; on = [ "n" ]           ; run = "find_arrow"                                         ; }
      { desc = "Go to previous found file"                                    ; on = [ "N" ]           ; run = "find_arrow --previous"                              ; }
      { desc = "Sort by modified time"                                        ; on = [ "," "m" ]       ; run = "sort modified --dir-first"                          ; }
      { desc = "Sort by modified time (reverse)"                              ; on = [ "," "M" ]       ; run = "sort modified --reverse --dir-first"                ; }
      { desc = "Sort by created time"                                         ; on = [ "," "c" ]       ; run = "sort created --dir-first"                           ; }
      { desc = "Sort by created time (reverse)"                               ; on = [ "," "C" ]       ; run = "sort created --reverse --dir-first"                 ; }
      { desc = "Sort by extension"                                            ; on = [ "," "e" ]       ; run = "sort extension --dir-first"                         ; }
      { desc = "Sort by extension (reverse)"                                  ; on = [ "," "E" ]       ; run = "sort extension --reverse --dir-first"               ; }
      { desc = "Sort alphabetically"                                          ; on = [ "," "a" ]       ; run = "sort alphabetical --dir-first"                      ; }
      { desc = "Sort alphabetically (reverse)"                                ; on = [ "," "A" ]       ; run = "sort alphabetical --reverse --dir-first"            ; }
      { desc = "Sort naturally"                                               ; on = [ "," "n" ]       ; run = "sort natural --dir-first"                           ; }
      { desc = "Sort naturally (reverse)"                                     ; on = [ "," "N" ]       ; run = "sort natural --reverse --dir-first"                 ; }
      { desc = "Sort by size"                                                 ; on = [ "," "s" ]       ; run = "sort size --dir-first"                              ; }
      { desc = "Sort by size (reverse)"                                       ; on = [ "," "S" ]       ; run = "sort size --reverse --dir-first"                    ; }
      { desc = "Create a new tab using the current path"                      ; on = [ "t" ]           ; run = "tab_create --current"                               ; }
      { desc = "Switch to the first tab"                                      ; on = [ "1" ]           ; run = "tab_switch 0"                                       ; }
      { desc = "Switch to the second tab"                                     ; on = [ "2" ]           ; run = "tab_switch 1"                                       ; }
      { desc = "Switch to the third tab"                                      ; on = [ "3" ]           ; run = "tab_switch 2"                                       ; }
      { desc = "Switch to the fourth tab"                                     ; on = [ "4" ]           ; run = "tab_switch 3"                                       ; }
      { desc = "Switch to the fifth tab"                                      ; on = [ "5" ]           ; run = "tab_switch 4"                                       ; }
      { desc = "Switch to the sixth tab"                                      ; on = [ "6" ]           ; run = "tab_switch 5"                                       ; }
      { desc = "Switch to the seventh tab"                                    ; on = [ "7" ]           ; run = "tab_switch 6"                                       ; }
      { desc = "Switch to the eighth tab"                                     ; on = [ "8" ]           ; run = "tab_switch 7"                                       ; }
      { desc = "Switch to the ninth tab"                                      ; on = [ "9" ]           ; run = "tab_switch 8"                                       ; }
      { desc = "Switch to the previous tab"                                   ; on = [ "[" ]           ; run = "tab_switch -1 --relative"                           ; }
      { desc = "Switch to the next tab"                                       ; on = [ "]" ]           ; run = "tab_switch 1 --relative"                            ; }
      { desc = "Swap the current tab with the previous tab"                   ; on = [ "{" ]           ; run = "tab_swap -1"                                        ; }
      { desc = "Swap the current tab with the next tab"                       ; on = [ "}" ]           ; run = "tab_swap 1"                                         ; }
      { desc = "Show the tasks manager"                                       ; on = [ "w" ]           ; run = "tasks_show"                                         ; }
      { desc = "Go to the home directory"                                     ; on = [ "g" "h" ]       ; run = "cd ~"                                               ; }
      { desc = "Go to the config directory"                                   ; on = [ "g" "c" ]       ; run = "cd ~/.config"                                       ; }
      { desc = "Go to the downloads directory"                                ; on = [ "g" "d" ]       ; run = "cd ~/Downloads"                                     ; }
      { desc = "Go to the temporary directory"                                ; on = [ "g" "t" ]       ; run = "cd /tmp"                                            ; }
      { desc = "Go to a directory interactively"                              ; on = [ "g" "<Space>" ] ; run = "cd --interactive"                                   ; }
      { desc = "Open help"                                                    ; on = [ "~" ]           ; run = "help"                                               ; }
    ];
    prepend_keymap = [
      { desc = "Enter the child directory, or open the file"; on = [ "<Right>" ]; run = "plugin --sync smart-enter"         ; }
      { desc = "Open shell here"                            ; on = [ "<C-s>" ]  ; run = "shell \"$SHELL\" --block --confirm"; }
      { desc = "diff selected file with hovered file"       ; on = [ "<C-d>"]   ; run = "plugin diff"                       ; }
      { desc = "chmod on selected files"                    ; on = [ "c","m"]   ; run = "plugin chmod"                      ; }
      { desc = "Maximize or restore preview"                ; on = [ "T" ]      ; run = "plugin --sync max-preview"         ; }
      { desc = "Smart filter"                               ; on = [ "/" ]      ; run = "plugin smart-filter"               ; }
    ];
    keymap = [
      { desc = "Cancel selection"        ; on = [ "<C-q>" ]   ; run = "close"         ; }
      { desc = "Cancel selection"        ; on = [ "<Esc>" ]   ; run = "close"         ; }
      { desc = "Submit the selection"    ; on = [ "<Enter>" ] ; run = "close --submit"; }
      { desc = "Move cursor up"          ; on = [ "<Up>" ]    ; run = "arrow -1"      ; }
      { desc = "Move cursor down"        ; on = [ "<Down>" ]  ; run = "arrow 1"       ; }
      { desc = "Move cursor up 5 lines"  ; on = [ "<S-Up>" ]  ; run = "arrow -5"      ; }
      { desc = "Move cursor down 5 lines"; on = [ "<S-Down>" ]; run = "arrow 5"       ; }
      { desc = "Open help"               ; on = [ "~" ]       ; run = "help"          ; }
    ];
  };
  tasks = {
    keymap = [
      { desc = "Hide the task manager"; on = [ "<Esc>" ]  ; run = "close"   ; }
      { desc = "Hide the task manager"; on = [ "<C-q>" ]  ; run = "close"   ; }
      { desc = "Hide the task manager"; on = [ "w" ]      ; run = "close"   ; }
      { desc = "Move cursor up"       ; on = [ "<Up>" ]   ; run = "arrow -1"; }
      { desc = "Move cursor down"     ; on = [ "<Down>" ] ; run = "arrow 1" ; }
      { desc = "Inspect the task"     ; on = [ "<Enter>" ]; run = "inspect" ; }
      { desc = "Cancel the task"      ; on = [ "x" ]      ; run = "cancel"  ; }
      { desc = "Open help"            ; on = [ "~" ]      ; run = "help"    ; }
    ];
  };
}