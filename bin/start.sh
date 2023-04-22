#! /bin/bash

################################################################################
##
##  Start process script for tickerplant and related processes
##
##  sh bin/start.sh <PROCESS>
##
##	i.e. sh bin/start.sh ALL (-i for interactive/debug mode, must be
##                                individual process and not "ALL")
##                      
##  Parameters:
##      - [PROCESS]: Process to start, if "ALL" will start all process in the 
##      	in the proper order
##
##  Options:
##      - [PROCESS] -> "ALL","TICK","RDB1","RDB2","FEED","CEP"
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

# Reading in process
PROCESS=$1

# Defining start commands
if $interactive; then
        START_TICK="${QEXEC} ${PROC_TICK} sym ${DIR_LOGS_REP} -p ${PORT_TICK} -libCommon ${LIB_COMMON} -libU ${LIB_U} -dirTick ${DIR_TICK}"
        START_RDB1="${QEXEC} ${PROC_RDB1} -p ${PORT_RDB1} -tp ${PORT_TICK} -hdbp ${PORT_HDB} -libCommon ${LIB_COMMON} -libR ${LIB_R} -dirHDB ${DIR_HDB}"
        START_RDB2="${QEXEC} ${PROC_RDB2} -p ${PORT_RDB2} -tp ${PORT_TICK} -hdbp ${PORT_HDB} -libCommon ${LIB_COMMON} -libR ${LIB_R} -dirHDB ${DIR_HDB}"
        START_RDB_CSV="${QEXEC} ${PROC_RDB_CSV} -p ${PORT_RDB_CSV} -tp ${PORT_TICK} -hdbp ${PORT_HDB} -libCommon ${LIB_COMMON} -libR ${LIB_R} -dirHDB ${DIR_HDB}"
        START_FEED="${QEXEC} ${PROC_FEED} -p ${PORT_FEED} -tp ${PORT_TICK} -libCommon ${LIB_COMMON}"
        START_CEP="${QEXEC} ${PROC_CEP} -p ${PORT_CEP} -tp ${PORT_TICK} -hdbp ${PORT_HDB} -libCommon ${LIB_COMMON} -libR ${LIB_R} -dirHDB ${DIR_HDB}"
else
        START_TICK="${QEXEC} ${PROC_TICK} sym ${DIR_LOGS_REP} -p ${PORT_TICK} -libCommon ${LIB_COMMON} -libU ${LIB_U} -dirTick ${DIR_TICK} </dev/null >> ${DIR_LOGS_PROC}/tick.log 2>&1 &"
        START_RDB1="${QEXEC} ${PROC_RDB1} -p ${PORT_RDB1} -tp ${PORT_TICK} -hdbp ${PORT_HDB} -libCommon ${LIB_COMMON} -libR ${LIB_R} -dirHDB ${DIR_HDB} </dev/null >> ${DIR_LOGS_PROC}/rdb1.log 2>&1 &"
        START_RDB2="${QEXEC} ${PROC_RDB2} -p ${PORT_RDB2} -tp ${PORT_TICK} -hdbp ${PORT_HDB} -libCommon ${LIB_COMMON} -libR ${LIB_R} -dirHDB ${DIR_HDB} </dev/null >> ${DIR_LOGS_PROC}/rdb2.log 2>&1 &"
        START_RDB_CSV="${QEXEC} ${PROC_RDB_CSV} -p ${PORT_RDB_CSV} -tp ${PORT_TICK} -hdbp ${PORT_HDB} -libCommon ${LIB_COMMON} -libR ${LIB_R} -dirHDB ${DIR_HDB} </dev/null >> ${DIR_LOGS_PROC}/rdb_csv.log 2>&1 &"
        START_FEED="${QEXEC} ${PROC_FEED} -p ${PORT_FEED} -tp ${PORT_TICK} -libCommon ${LIB_COMMON} </dev/null >> ${DIR_LOGS_PROC}/feed.log 2>&1 &"
        START_CEP="${QEXEC} ${PROC_CEP} -p ${PORT_CEP} -tp ${PORT_TICK} -hdbp ${PORT_HDB} -libCommon ${LIB_COMMON} -libR ${LIB_R} -dirHDB ${DIR_HDB} </dev/null >> ${DIR_LOGS_PROC}/cep.log 2>&1 &"
fi

# Starting process
echo ""
case $PROCESS in
	ALL)
        echo "Starting tick process"
        eval $START_TICK
        echo "Starting rdb1 process"
        eval $START_RDB1
        echo "Starting rdb2 process"
        eval $START_RDB2
        echo "Starting rdbCsv process"
        eval $START_RDB_CSV
        echo "Starting feed process"
        eval $START_FEED
        echo "Starting realtime engine process"
        eval $START_CEP;;
	TICK)
        echo "Starting tick process"
        eval $START_TICK;;
	RDB1)
        echo "Starting rdb1 process"
        eval $START_RDB1;;
	RDB2)
        echo "Starting rdb2 process"
        eval $START_RDB2;;
	RDB_CSV)
        echo "Starting rdbCsv process"
        eval $START_RDB_CSV;;
	FEED)
        echo "Starting feed process"
        eval $START_FEED;;
	CEP)
        echo "Starting realtime engine process"
        eval $START_CEP
esac
echo ""
