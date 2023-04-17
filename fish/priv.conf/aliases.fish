# source "$__fish_config_dir/priv.conf.d/envs.fish"

# :SHORTHAND COMMANDS
abbr -a be -- "cd $BE_DIR"
abbr -a mig -- "cd $MIGRATIONS_DIR"
abbr -a q2c -- "cd $Q2C_DIR"
abbr -a fe -- "cd $FE_DIR"
abbr -a soa -- "cd $SOA_DIR"
abbr -a sql -- "cd $SQL_DIR"
abbr -a dev -- "cd $PROJECTS_DIR/dev"
abbr -a howto -- "cd $PROJECTS_DIR/howto"
abbr -a bels -- "cd $BE_DIR; wt ls"
abbr -a migls -- "cd $MIGRATIONS_DIR; wt ls"
abbr -a q2cls -- "cd $Q2C_DIR; wt ls"
abbr -a fels -- "cd $FE_DIR; wt ls"
abbr -a soals -- "cd $SOA_DIR; wt ls"

# OPEN WITH EDITOR
alias ed-be="edproj -n ed-be -p $BE_DIR"
alias ed-mig="edproj -n ed-mig -p $MIGRATIONS_DIR"
alias ed-soa="edproj -n ed-soa -p $SOA_DIR"
alias ed-sql="edproj -n ed-sql -p $SQL_DIR"
alias ed-dev="edproj -n ed-dev -p $PROJECTS_DIR/dev"
alias ed-pysand="edproj -n ed-pysand -p $PROJECTS_DIR/pysandbox"
alias ed-howto="edproj -n ed-howto -p $PROJECTS_DIR/howto"


# :FUNCTIONS
abbr -a dbreset-mig -- 'run_dbreset_be'
abbr -a dbreset-be -- 'run_dbreset_be'
abbr -a dbreset-soa -- 'run_dbreset_soa'

abbr -a cdtests -- 'cd ./tests/integration/src'

abbr -a soa-pythonpath -- 'set -gx PYTHONPATH $PYTHONPATH (pwd)/src'
abbr -a soa-source-cfg -- 'envsource ./configs/envs/local.env'
abbr -a soa-source-all -- 'set -gx PYTHONPATH $PYTHONPATH (pwd)/src && envsource ./configs/envs/local.env'

# :SCRIPTS
abbr -a autorebase-mig -- 'python $SCRIPTS_DIR/autorebase_migrations_be.py'
