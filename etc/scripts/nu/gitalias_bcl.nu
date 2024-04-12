git branch --merged | lines | where ($it != "* master" && $it != "* main") | each {|br| git branch -D ($br | str trim) } | str trim

