#! /bin/bash

################################################################################
##
##  CSV file shell start process for python or java (q called with normal start 
##  script)
##
##  sh eod.sh 
##
##  i.e. sh eod.sh
##
################################################################################

# Sourcing config profile
source ./config/config.profile

# Reading in optional tags
interactive=false
while getopts :i opt; do
    case $opt in 
        i) interactive=true ;;
       \?) echo "Unknown option -$OPTARG"; exit 1;;
    esac
done
shift $(( OPTIND - 1 ))

PROCESS=$1

# Defining start commands
if $interactive; then
    START_EOD="${QEXEC} ${PROC_EOD} -p ${PORT_EOD} -tp ${PORT_TICK} -libCommon ${LIB_COMMON} -libSym ${LIB_SYM} -dirReplay ${DIR_LOGS_REP} -dirHDB ${DIR_HDB}"
else
    START_EOD="${QEXEC} ${PROC_EOD} -p ${PORT_EOD} -tp ${PORT_TICK} -libCommon ${LIB_COMMON} -libSym ${LIB_SYM} -dirReplay ${DIR_LOGS_REP} -dirHDB ${DIR_HDB} </dev/null >> ${DIR_LOGS_PROC}/eod.log 2>&1 &"
fi

# Starting process
echo ""
echo "Starting end of day process"
eval $START_EOD
echo "End of day process complete"
echo ""
