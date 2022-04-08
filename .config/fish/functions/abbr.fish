function abbr --description 'Manage abbreviations'
    set -l options --stop-nonopt --exclusive 'a,r,e,l,s,q' --exclusive 'g,U'
    set -a options h/help a/add r/rename e/erase l/list s/show q/query
    set -a options g/global U/universal

    argparse -n abbr $options -- $argv
    or return

    if set -q _flag_help
        __fish_print_help abbr
        return 0
    end

    # If run with no options, treat it like --add if we have arguments, or
    # --show if we do not have any arguments.
    set -l _flag_add
    set -l _flag_show
    if not set -q _flag_add[1]
        and not set -q _flag_rename[1]
        and not set -q _flag_erase[1]
        and not set -q _flag_list[1]
        and not set -q _flag_show[1]
        and not set -q _flag_query[1]
        if set -q argv[1]
            set _flag_add --add
        else
            set _flag_show --show
        end
    end

    set -l abbr_scope
    if set -q _flag_global
        set abbr_scope --global
    else if set -q _flag_universal
        set abbr_scope --universal
    end

    if set -q _flag_add[1]
        __fish_abbr_add $argv
        return
    else if set -q _flag_erase[1]
        set -q argv[1]; or return 1
        __fish_abbr_erase $argv
        return
    else if set -q _flag_rename[1]
        __fish_abbr_rename $argv
        return
    else if set -q _flag_list[1]
        __fish_abbr_list $argv
        return
    else if set -q _flag_show[1]
        __fish_abbr_show $argv
        return
    else if set -q _flag_query[1]
        # "--query": Check if abbrs exist.
        # If we don't have an argument, it's an automatic failure.
        set -q argv[1]; or return 1
        set -l escaped _fish_abbr_(string escape --style=var -- $argv)
        # We return 0 if any arg exists, whereas `set -q` returns the number of undefined arguments.
        # But we should be consistent with `type -q` and `command -q`.
        for var in $escaped
            set -q $escaped; and return 0
        end
        return 1
    else
        printf ( _ "%s: Could not figure out what to do!\n" ) abbr >&2
        return 127
    end
end
