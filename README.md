#AdvKDB
Advanced kdb+ project completed as culiminating portion of First Derivatives, Capital Markets Training Program.

Initializing:
    
    Project file can be placed anywhere, configurable paramters located in AdvKDB/config/config.profile, should be
    adjusted accordingly. 

    One of these configurable variables is the associated Q environment variables. Q must be installed (https://code.kx.com/q/learn/install/)

    Once all prepared, cd into AdvKDB directory, all commands should be ran from within this main project directory.

Exercise 1: Tick
Create a project with the following components and requirements. The basis of the exercise will be tick scripts available here:
(https://github.com/kxsystems/kdb-tick)

    1. Ticker Plant:
    2. RDB
    3. Feed Handler
    4. Complex Event Processor
    5. Logging
    6. Startup/Shutdown Scripts
    7. Tickerplant log replay
    8. Csv file load
    9. EOD Process
    10. Schema Change

Exercise 2: Debugging
Debug the following

    1. TP/RDB problem
    2. Splay Table problem
    3. Blocking Calls
    4. Query Performance

Exercise 3: API

    1. Csv file load script (python)
    2. Csv file load script (java)
    3. Web Interface - HTML5

TO FORMAT:

- will need to install and import the qconnection library (also provide the link with which to download it)


Exercise 1. Question 10.

Problem:

    Discuss the effect a schema change to the trade table in the above system e.g. a sequence number column was added to both trade and quote tables. How you would plan a turnover to update the schema.

Solution: 

    To implement a schema change such as adding a new field of sequence numbers would follow these steps:

        1. Bring down system processes - need to restart the tickerplant so all other dependents will need to come down as well. 
        2. Add column into table definition in the sym file
        3. Bring tickerplant process back up to ensure that the new field is picked up
        4. Reformat the HDB to ensure data congruence. Inorder to do so cna implement a dbmaint.q script - linked here - https://github.com/KxSystems/kdb/blob/master/utils/dbmaint.md 
            and copy included in common folder of this repo.

    Therefore with this system in specific lets run through the process of adding a sequence number to trade table

        1. Bring down - sh bin/stop.sh ALL - will bring down any connected processes as well as the tickerplant
        2. Add column to sym file - sym file located in AdvKDB/q/tick/sym.q can update trade table definition with the following:

            trade:([]time:`timespan$();sym:`symbol$();price:`float$();size:`int$();seqNum:`int$())
        
        3. Starting tickerplant up again can check logs for any errors in initializing - sh bin/start.sh TICK
        4. Opening a handle to the tickerplant on a q process can check the updated schema to make sure changes were picked up:

            q) h:hopen 5010
            q) h "trade"

            Should return an empty table with the new column included - time sym price size seqNum
                                                                        --------------------------

        5. Finally to make sure historical queries will work and future EOD processing need to use dbmaint.q to update hdb structure something like the following:

            q) \l AdvKDB/q/common/dbmaint.q
            q) addcol[`:AdvKDB/hdb;`trade;`seqNum;0i]
            q) \l `:AdvKDB/hdb - (to check)

        6. Lastly, can use .Q.chk to ensure data integrity

Java package for kx connection can be found here - https://github.com/KxSystems/javakdb/releases

qpython package required