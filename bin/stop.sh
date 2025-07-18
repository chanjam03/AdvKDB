#! /bin/bash

################################################################################
##
##  Stop process script for tickerplant and related processes
##
##  sh bin/stop.sh <PROCESS>
##
##	i.e. sh bin/stop.sh ALL
##
##  Parameters:
##      - [PROCESS]: Process to stop, if "ALL" will start all process in the 
##      	in the proper order
##
##  Options:
##      - [PROCESS] -> "ALL","TICK","HDB","RDB1","RDB2","FEED","CEP","WEB"
##
################################################################################

# sourcing config profile
source ./config/config.profile

# Reading in process
PROCESS=$1

# Stopping process
echo ""
case $PROCESS in
        ALL)
        echo "Stopping websocket process"
        lsof -i :${PORT_WEB} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9
        echo "Stopping complex event process"
        lsof -i :${PORT_CEP} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9
        echo "Stopping feed process"
        lsof -i :${PORT_FEED} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9
        echo "Stopping rdb1 process"
        lsof -i :${PORT_RDB1} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9
        echo "Stopping rdb2 process"
        lsof -i :${PORT_RDB2} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9
        echo "Stopping rdbCsv process"
        lsof -i :${PORT_RDB_CSV} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9
        echo "Stopping hdb process"
        lsof -i :${PORT_HDB} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9
        echo "Stopping tick process"
        lsof -i :${PORT_TICK} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
        WEB)
        echo "Stopping websocket process"
        lsof -i :${PORT_CEP} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
	CEP)
        echo "Stopping complex event process"
        lsof -i :${PORT_CEP} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
	FEED)
        echo "Stopping feed process"
        lsof -i :${PORT_FEED} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
	RDB1)
        echo "Stopping rdb1 process"
        lsof -i :${PORT_RDB1} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
	RDB2)
        echo "Stopping rdb2 process"
        lsof -i :${PORT_RDB2} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
	RDB_CSV)
        echo "Stopping rdbCsv process"
        lsof -i :${PORT_RDB_CSV} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
        HDB)
        echo "Stopping hdb process"
        lsof -i :${PORT_HDB} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9;;
	TICK)
        echo "Stopping tick process"
        lsof -i :${PORT_TICK} | grep LISTEN | awk '{print $2; exit}' | xargs kill -9
esac
echo ""
