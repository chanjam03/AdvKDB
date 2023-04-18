### ~~~ CONFIGURABLE PARAMETERS ~~~ ###
ROOT="/Users/firstderivative/Desktop"
QHOME="/Users/firstderivative/qhome"
QLIC="/Users/firstderivative/qhome"
QEXEC="/Users/firstderivative/qhome/m64/q"
PYEXEC="python3"
JVEXEC="java"

### ~~~ INTERNAL DIRECTORIES ~~~ ###
DIR_HOME="${ROOT}/AdvKDB"
DIR_Q="${DIR_HOME}/q"
DIR_TICK="${DIR_HOME}/tick"
DIR_LOG="${DIR_HOME}/log"
DIR_HDB="${DIR_HOME}/hdb"
DIR_FILES="${DIR_HOME}/files"
DIR_SCRIPTS="${DIR_HOME}/scripts"

### ~~~ PROCESS SCRIPTS ~~~ ###
PROC_TICK="${DIR_Q}/tick.q"
PROC_RDB="${DIR_Q}/rdb.q"
PROC_FEED="${DIR_Q}/feed.q"
PROC_RTE="${DIR_Q}/rte.q"
PROC_CSV="${DIR_Q}/csv.q"

### ~~~ PROCESS PORTS ~~~ ###
PORT_TICK="5010"
PORT_HDB="5012"
PORT_FEED="5015"
PORT_RTE="5020"
PORT_RDB1="5030"
PORT_RDB2="5031"
PORT_CSV="5025"