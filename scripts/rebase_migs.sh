# #!/usr/bin/env bash

# usage() {
#     echo "Usage"
# }

# while getopts "b:d:" o; do
#     case "${o}" in
#         b)
#             BASE="${OPTARG}"
#             ;;
#         d)
#             DEST="${OPTARG}"
#             ;;
#         *)
#             usage
#             return;
#             ;;
#     esac
# done

# SCRIPTPATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
# readonly DEST=${DEST:-"$( git curr-branch )"}
# readonly BASE=${BASE:-"master"}

# echo "PWD: $( pwd -P )"
# echo "BASE: ${BASE}"
# echo "DEST: ${DEST}"
# echo "SCRIPTPATH: $SCRIPTPATH"

# cd "${SCRIPTPATH}"

# echo "python -m rebase -b $BASE -d $DEST"

# cd -
