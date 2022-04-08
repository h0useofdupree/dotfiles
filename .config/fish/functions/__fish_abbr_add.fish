function __fish_abbr_add --no-scope-shadowing
    if not set -q argv[2]
        printf ( _ "%s %s: Requires at least two arguments\n" ) abbr --add >&2
        return 1
    end

    # Because of the way abbreviations are expanded there can't be any spaces in the key.
    set -l abbr_name $argv[1]
    set -l escaped_abbr_name (string escape -- $abbr_name)
    if string match -q "* *" -- $abbr_name
        set -l msg ( _ "%s %s: Abbreviation %s cannot have spaces in the word\n" )
        printf $msg abbr --add $escaped_abbr_name >&2
        return 1
    end

    set -l abbr_val "$argv[2..-1]"
    set -l abbr_var_name _fish_abbr_(string escape --style=var -- $abbr_name)

    if not set -q $abbr_var_name
        # We default to the universal scope if the user didn't explicitly specify a scope and the
        # abbreviation isn't already defined.
        set -q abbr_scope[1]
        or set abbr_scope --universal
    end
    true # make sure the next `set` command doesn't leak the previous status
    set $abbr_scope $abbr_var_name $abbr_val
end
