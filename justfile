# List recipes
default:
    @just --list

HOME := env_var('HOME')
source := justfile_directory()
HOME_CONFIG := env_var_or_default('XDG_CONFIG_HOME', HOME + '/.config')
target := HOME_CONFIG + '/doom'
rsync_opts := "-Prlucv --delete-delay"

# Install Doom (expects ~/.config/emacs/bin/doom to be in PATH)
install:
    git clone --depth 1 https://github.com/doomemacs/doomemacs {{HOME_CONFIG}}/emacs
    doom install

# Deploy Doom config (expects ~/.config/emacs/bin/doom to be in PATH)
deploy:
    rm -rf {{HOME}}/.emacs.d
    rsync {{rsync_opts}} {{source}}/ {{target}}/
    doom sync

# Update plugins and sync config with Doom Emacs
update:
    doom upgrade
    doom sync

# Show differences between source and destination
diff:
    -diff -rq --exclude='.git' {{source}} {{target}}

# Undeploy Doom configuration
undeploy:
    rm -rf {{target}}

# Uninstall
uninstall:
    rm -rf {{HOME_CONFIG}}/emacs
