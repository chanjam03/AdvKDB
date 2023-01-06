### ~~~ CONFIGURABLE PARAMETERS ~~~ ###
ROOT="/Users/firstderivative/dev"
QHOME="/Users/firstderivative/qhome"
QLIC="/Users/firstderivative/qhome"
QEXEC="/Users/firstderivative/qhome/m64/q"

### ~~~ INTERNAL DIRECTORIES ~~~ ###
DIR_HOME="${ROOT}/AdvKDB"
DIR_Q="${DIR_HOME}/q"
DIR_TICK="${DIR_HOME}/tick"
DIR_LOG="${DIR_HOME}/log"
DIR_HDB="${DIR_HOME}/hdb"

### ~~~ PROCESS SCRIPTS ~~~ ###
PROC_TICK="${DIR_Q}/tick.q"
PROC_RDB="${DIR_Q}/rdb.q"
PROC_FEED="${DIR_Q}/feed.q"

### ~~~ PROCESS PORTS ~~~ ###
PORT_TICK="5010"
PORT_HDB="5012"
PORT_FEED="5015"
PORT_RDB1="5030"
PORT_RDB2="5031"