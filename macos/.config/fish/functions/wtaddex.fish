function wtaddex
    set -l usage "usage: wt-add-ex [NEW_BRANCH] [PATH] COMMIT-ISH"
    wtadd $argv 2>/dev/null
    
    set -l last_status $status
    if test $last_status -ne 0
        echo $usage
        return $last_status
    end

    if test -d $argv[1]
        cd $argv[1]
    end
    vscodeaddsett
end