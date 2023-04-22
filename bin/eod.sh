#! /bin/bash

################################################################################
##
##  CSV file shell start process for python or java (q called with normal start 
##  script)
##
##  sh load.sh <LANGUAGE> <NAME_CSV> <NAME_TABLE>
##
##  i.e. sh load.sh PYTHON optTrades.csv optTrades
##
##  Parameters:
##      - [LANGUAGE]: script to call the csv load process
##      - [NAME_CSV]: filename of csv to load in and send to tickerplant (All 
##          files should be placed in files directory)
##      - [NAME_TABLE]: name of table to be updated on tickerplant (should be 
##          added to sym schema file)
##
##  Options:
##      - [LANGUAGE] -> "Q","PYTHON","JAVA"
##
################################################################################