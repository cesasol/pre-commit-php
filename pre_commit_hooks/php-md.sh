#!/usr/bin/env bash

# Bash PHP MD for Pre-commits
#
# Exit 0 if no errors found
# Exit 1 if errors were found
#
# Requires
# - php

# Plugin title
title="PHP Mess Detector"

# Possible command names of this tool
local_command="phpmd.phar"
vendor_command="vendor/bin/phpmd"
global_command="phpmd"

# Print a welcome and locate the exec for this tool
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/helpers/colors.sh
source $DIR/helpers/formatters.sh
source $DIR/helpers/welcome.sh
source $DIR/helpers/locate.sh

# Loop through the list of paths to run PHP MD against

phpmd_files_to_check="${@:2}"
phpmd_args=$1
# Without this escape field, the parameters would break if there was a comma in it
phpmd_command="${exec_command} ${phpmd_files_to_check// /,} ansi phpmd.xml"

echo -e "${bldwht}Running command ${txtgrn} $phpmd_command${txtrst}"
command_result=`eval $phpmd_command`

if [[ $command_result =~ VIOLATION ]]
then
    hr
    echo -en "${bldmag}Errors detected by PHP Code Beautifier and Fixer ... ${txtrst} \n"
    hr
    echo "$command_result"
    exit 1
fi

exit 0
