function patchset
    grep patchset .branch_info | cut -d\= -f2
end
