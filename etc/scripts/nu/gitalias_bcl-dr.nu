git branch --merged | lines | where ($it != "* master" && $it != "* main") | each {|br| echo ($br | str trim) } | str trim

