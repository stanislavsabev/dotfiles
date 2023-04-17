# PRIVATE FISH CONFIG FOR THIS SYSTEM
source $__fish_config_dir/priv.conf.d/envs.fish
source $__fish_config_dir/priv.conf.d/aliases.fish

for file in $__fish_config_dir/priv.conf.d/functions/*.fish
    source $file
end