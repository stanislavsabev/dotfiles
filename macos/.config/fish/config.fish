set -U fish_greeting

# ::env
set -gx HISTIGNORE " *"
set -gx HISTCONTROL ignoreboth:erasedups
set -gx COLORTERM truecolor

# Title options
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path yes


if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U status_ok 0
    set -U status_failed 1
    set -U status_failed 1
    set -U invalid_arguments 121
    set -U invalid_command_name 123
    set -U no_matches_found 124
    set -U could_not_execute_command 125
    set -U file_not_executable 126
    set -U function_builtin_or_command_not_located 127
end
