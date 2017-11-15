set LS_COLORS dxfxcxdxbxegedabagacad

alias df 'command df -m'
alias j jobs
alias l ls
alias ll 'ls -la'
alias ls 'command ls -FG'
alias su 'command su -m'

function lsd -d 'List only directories (in the current dir)'
    command ls -d */ | sed -Ee 's,/+$,,'
end

# Colorized cat (will guess file type based on contents)
alias ccat 'pygmentize -g'

alias g git
alias c clear
alias v vim
alias x 'tig HEAD'
alias notes 'ag "TODO|HACK|FIXME|OPTIMIZE"'

alias gti git

function git-search
    git log -S"$argv" --pretty=format:%H | map git show
end

alias json 'prettify-json'
alias map 'xargs -n1'
alias collapse "sed -e 's/  */ /g'"
alias cuts 'cut -d\ '

function p -d "Start the best Python shell that is available"
    set -l cmd

    if test -f manage.py
        if pip freeze ^/dev/null | grep -iq 'django-extensions'
            set cmd (which python) manage.py shell_plus
        else
            if pip freeze ^/dev/null | grep -iq 'flask-script'
                # do nothing, use manage.py, fall through
                set -e cmd
            else
                set cmd (which python) manage.py shell
            end
        end
    end

    if test -z $cmd
        set -l interpreters (which bpython ^/dev/null; which ipython ^/dev/null; which python ^/dev/null)

        if test -z "$interpreters"
            set_color red
            echo "No python interpreters found on the PATH."
            set_color normal
            return 127
        end

        # Try to find the first interpreter within the current virtualenv
        # Rationale: it's more important to start a Python interpreter in the
        # current virtualenv than it is to start an _IPython_ interpreter (for
        # example, when the current virtualenv has no ipython installed, but such
        # would be installed system-wide).
        for interp in $interpreters
            #echo '-' $interp
            #echo '-' (dirname (dirname $interp))
            if test (dirname (dirname $interp)) = "$VIRTUAL_ENV"
                set cmd $interp
                break
            end
        end

        # If they all fall outside the virtualenv, pick the first match
        # (preferring ipython over python)
        if test -z "$cmd"
            set cmd $interpreters[1]
        end
    end

    # Run the command
    printf "Using "; set_color green; echo $cmd; set_color normal
    eval $cmd $argv
end

alias pm 'python manage.py'
alias pmm 'python manage.py migrate'
alias pmmm 'python manage.py makemigrations'
alias pms 'python manage.py shell_plus'
alias pmr 'python manage.py runserver_plus 0.0.0.0:8000'

alias cd.. 'cd ..'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

alias md 'mkdir -p'

function wtf -d "Print which and --version output for the given command"
    for arg in $argv
        echo $arg: (which $arg)
        echo $arg: (sh -c "$arg --version")
    end
end
