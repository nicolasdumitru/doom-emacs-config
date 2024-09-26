# List recipes
default:
    @just --list

source := justfile_directory()
target := env_var_or_default('XDG_CONFIG_HOME', env_var('HOME') + '/.config') + '/doom'
rsync_opts := "-Prlucv --delete-delay"

# Install Doom configuration files
install:
    rsync {{rsync_opts}} {{source}}/ {{target}}/
    doom sync

# Update plugins and sync config with Doom Emacs
update:
    doom upgrade
    doom sync

# Show differences between source and destination
diff:
    -diff -rq --exclude='.git' {{source}} {{target}}

# Uninstall Doom configuration
uninstall:
    rm -rf {{target}}
