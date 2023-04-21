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
DIR_TICK="${DIR_Q}/tick"
DIR_COMMON="${DIR_Q}/common"
DIR_LOGS="${DIR_HOME}/logs"
DIR_LOGS_PROC="${DIR_LOGS}/process"
DIR_LOGS_REP="${DIR_LOGS}/replay"
DIR_HDB="${DIR_HOME}/hdb"
DIR_FILES="${DIR_HOME}/files"
DIR_SCRIPTS="${DIR_HOME}/scripts"

### ~~~ LIBRARY SCRIPTS ~~~ ###
LIB_COMMON="${DIR_COMMON}/common.q"
LIB_U="${DIR_TICK}/u.q"
LIB_R="${DIR_TICK}/r.q"

### ~~~ PROCESS SCRIPTS ~~~ ###
PROC_TICK="${DIR_Q}/tick.q"
PROC_RDB1="${DIR_Q}/rdb1.q"
PROC_RDB2="${DIR_Q}/rdb2.q"
PROC_FEED="${DIR_Q}/feed.q"
PROC_CEP="${DIR_Q}/cep.q"
PROC_Q_CSV="${DIR_Q}/csvLoad.q"
PROC_PYTHON_CSV="${DIR_SCRIPTS}/csvLoad.py"
PROC_JAVA_CSV="${DIR_SCRIPTS}/csvLoad.java"

### ~~~ PROCESS PORTS ~~~ ###
PORT_TICK="5010"
PORT_HDB="5012"
PORT_FEED="5015"
PORT_CEP="5020"
PORT_RDB1="5030"
PORT_RDB2="5031"
PORT_CSV="5025"