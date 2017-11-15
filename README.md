# Dotfiles - using Homeshick




## TODO

* Document some cool features (FZY FZF z fish)
* Steal more tricks from:
   * https://github.com/nvie/dotfiles/blob/master/.config/fish/config.fish
   * https://github.com/gf3/dotfiles/blob/master/.config/fish/config.fish

More TODOs in `emacs/personal/README.md`


## Keyboard mapping

This maps `CAPS` to an extra `CTRL` and setup up the `RightALT` as the compose key
(allowing: `RightALT` `"` `e` -> `ë`). This works also in console screens.

    sudo bash -c "cat > /etc/default/keyboard" << EOL
    # KEYBOARD CONFIGURATION FILE
    # Consult the keyboard(5) manual page.
    XKBMODEL="pc105"
    XKBLAYOUT="us"
    XKBVARIANT="euro"
    XKBOPTIONS="compose:ralt,ctrl:nocaps"
    BACKSPACE="guess"
    EOL
    sudo dpkg-reconfigure keyboard-configuration

Answer the questions on you keyboard type. On my XPS13 I use "Generic 104 PC", "English (US)" and "(euro on 5)".


## Install packages (some needed for the following steps)

Basic work:

    sudo apt-get install -y git direnv
    sudo apt-get install -y aspell-nl idutch spell ispell myspell-nl wdutch
    sudo apt-get install -y openssh-server
    sudo apt-get install -y python-software-properties  # some tools for apt

Programming (Emacs is a separate story):

    sudo apt-get install -y build-essential
    sudo apt-get install -y zlib1g-dev libssl-dev libreadline-dev libyaml-dev \
                            libxml2-dev libxslt1-dev libcurl4-openssl-dev \
                            libffi-dev
    sudo apt-get install -y sqlite3 libsqlite3-dev
    sudo apt-get install -y postgresql libpq-dev
    sudo apt-get install -y mysql-server mysql-client libmysqlclient-dev

GUI stuff:

    sudo apt-get install -y inkscape gimp
    sudo apt-get install -y kate kompare ktorrent
    sudo apt-get install -y plasma-applet-redshift-control

## Assume identity

Get the keypair used to access your Github account, and drop 'm into: `~/.ssh/`


## Install Homeshick

    git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick

From Bash, add the Homeshick script to both Bash and (soon to be installed) Fish:

    # for Bash
    printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc
    printf '\nsource "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"' >> $HOME/.bashrc
    source $HOME/.bashrc

    # for Fish
    mkdir -p "$HOME/.config/fish" 
    echo \n'source "$HOME/.homesick/repos/homeshick/homeshick.fish"' >> "$HOME/.config/fish/config.fish"
    echo \n'source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"' >> "$HOME/.config/fish/config.fish"

Download the dotfiles:

    homeshick clone https://github.com/cies/dotfiles.git
    # homeshick cd dotfiles
    # git submodule init
    # git submodule update
    homeshick symlink dotfiles


## Fish shell

    sudo apt-add-repository ppa:fish-shell/release-2
    sudo apt-get update
    sudo apt-get install fish
    
Additional tools needed by Fish' configuration...

Install Fisherman (a package manager for Fish)

    curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

Install FZF system tool

    __fzf_install

Install FZY system tool
    
    cd /tmp
    wget https://github.com/jhawthorn/fzy/releases/download/0.9/fzy_0.9-1_amd64.deb
    sudo dpkg -i fzy_0.9-1_amd64.deb
    cd -

Install Fish packages as per `.config/fish/fishfile`

    fisher

Set Fish to be your default shell
    
    chsh -s /usr/bin/zsh $USER

    
    
## Packages that need a special repo (PPA) to work

Emacs latest stable (or install as above):

    sudo add-apt-repository ppa:kelleyk/emacs
    sudo apt update
    sudo apt install emacs25
    mv ~/.emacs.d ~/.emacs.d.bak
    mv ~/.emacs ~/.emacs.bak
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d


## How I'm tuning KDE

* kill busy cursor
* set dim inactive windows
* set dim when authing for root
* switch to the old launcher menu
* add system load viewer applet to panel
* add redshift control applet to panel


## Fonts

    sudo apt install ttf-mscorefonts-installer
    ~/bin/install_adobe_scp

--------------
    
    
    
## Haskell (using `stack`)

    sudo apt-key adv --keyserver keyserver.ubuntu.com \
      --recv-keys 575159689BEFB442
    echo 'deb    http://download.fpcomplete.com/ubuntu wily main' | \
      sudo tee /etc/apt/sources.list.d/fpco.list
    sudo apt-get update && sudo apt-get install stack -y





## Fix annoying "perl: warning: Setting locale failed."

Seems to be fixed in Ubuntu as of 17.10...

    sudo locale-gen en_US en_US.UTF-8 nl_NL nl_NL.UTF-8
    sudo dpkg-reconfigure locales
