-- Open with nvim, Automator App's applescript

-- This is the entrypoint of the script. The input argument
-- contains the file that you tried to open with this application.
on run {input}
  if length of input is equal to 1 then
    my openFile(input)
  else
    -- If no input was provided, this script will simply open a
    -- terminal with Vim
    my justOpen()
  end if
end run

-- This function gets the path of the file from the MacOS system
-- and creates the commands to execute in the shell to open the
-- file in Vim
on openFile(input)
  set the_file to quoted form of POSIX path of input
  tell application "System Events"
    set the_path to POSIX path of (container of (item 1 of input))
  end tell

  set cwd to "cd " & the_path
  set cmd to "nvim " & the_file
  my launchVim(cwd, cmd)
end openFile

-- This function is called when no arguments were provided and we
-- should just open Vim
on justOpen()
  set cwd to "cd"
  set cmd to "nvim"
  my launchVim(cwd, cmd)
end justOpen

on launchVim(cwd, cmd)
	tell application "System Events" to set terminalIsRunning to exists application process "kitty"

	tell application "kitty"
		activate
		if terminalIsRunning is true then
			tell application "System Events"
				tell process "kitty" to keystroke "t" using command down
				delay 1.5
				keystroke cwd
				keystroke return
				keystroke cmd
				keystroke return
			end tell
		else
			tell application "System Events"
				tell process "kitty" to keystroke "t" using command down
				delay 1.5
				keystroke cwd
				keystroke return
				keystroke cmd
				keystroke return
			end tell
		end if
	end tell
end launchVim

