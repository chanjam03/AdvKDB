<h1>Advanced KDB+</h1>
Advanced kdb+ project completed as culiminating portion of First Derivatives, Capital Markets Training Program.

<h2>Getting Started</h2>

Initializing:
    
    Project file can be placed anywhere, configurable paramters located in AdvKDB/config/config.profile, should be adjusted accordingly. ALl other parameters should not be adjusted.

    One of these configurable variables is the associated Q environment variables. Q must be installed (https://code.kx.com/q/learn/install/)

    For the PYEXEC and JVEXEC these should point to your executable versions of each. If contained in path already these can be kept the same

    Once all prepared, cd into AdvKDB directory, all commands should be ran from within this main project directory.

<h2>Processes</h2>

General Tick Process:

    To start the entire tickerplant process can run the following command:

        sh bin/start.sh ALL

    This will bring up all intraday processes contained in tick project. Can test that processes are up using the test script:

        sh bin/test.sh ALL

    Also can bring up individual processes by specifying each, for example:

        sh bin/start.sh -i TICK
    
    Specifying the optional tag will bring up the process in an interactive terminal, for possible debugging or anaylzing the process
    Finally All the same fiunctionality described above is also possible with stopping processes, for example:

        sh bin/stop.sh ALL
        sh bin/stop.sh TICK
    
    All logs for processes are kept in sub directory: AdvKDB/logs/process with each process containing there own log file where stdout and stderr are both wrote to.

    For any other process specifics, detailed documentation for all scripts are included at the top of each script including parameters passed and options for calling.

Tickerplant Replay:

    For replay of a tickerplant log file run the replay.sh script which takes 3 arguments to specify:

        sh bin/replay.sh TABLE SYM DATE

    An example in this case is included below as I have used Canadian stocks in the random generating feed handler:

        sh bin/replay.sh trade ENB 2023.04.24

    What this is doing above is reading in the tickerplant log file from 2023.04.21, filtering on trade table with sym `ENB.
    The new log file is written to the same location with the file handle ENB2023.04.24

CSV File Load:

    For loading a csv file into our process we can use the following script: 

        sh bin/load.sh LANGUAGE CSV TABLE

    I have implmented the solutions to exercise three into this same script. By specifying what language you would like to use can test all three, examples below:

        sh bin/load.sh Q optTrades.csv optTrades 
        sh bin/load.sh PYTHON optTrades.csv optTrades
        sh bin/load.sh JAVA optTrades.csv optTrades

    Field types are read in from tickerplant so for ay future tables once schema is added to schema file (located here: AdvKDB/q/tick/sym.q) will be able to upload any csv file. 

    Files should be placed in file directory located here: AdvKDB/files.

    I have included an additional RDB subscribed to the optTrades table on port 5032. Can either start process intercativley to check:

        sh bin/start.sh -i RDB_CSV 

    Or hopen a connection on a seperate Q process to check:

        q)h:hopen 5032
        q)h "optTrades"

EOD Process:

    This is a seperate script, in a proper project environment would first run sh bin/stop.sh ALL to ensure all processes are closed. Then will run the eod process to save down data to hdb:

        sh bin/eod.sh -i
    
    Should be ran interactivley at least the first time to ensure permissons are ok.
    This will save down splayed all the tables in schema file, with all but the time and sym colum compressed to the sub directory AdvKDB/hdb.

    In order to test this can test by bringing up the hdb process interactivley to ensure that data is saved down properly. 

        sh bin/start -i HDB
        q) trade

    Would schedule this to run at end of day once that initiall stop script is called. 

Schema Change:

    To implement a schema change such as adding a new field of sequence numbers would follow these steps:

        1. Bring down system processes - need to restart the tickerplant so all other dependents will need to come down as well. 
        2. Add column into table definition in the sym file
        3. Bring tickerplant process back up to ensure that the new field is picked up
        4. Reformat the HDB to ensure data congruence. Inorder to do so cna implement a dbmaint.q script - linked here - https://github.com/KxSystems/kdb/blob/master/utils/dbmaint.md 
            and copy included in common folder of this repo.

    Therefore with this system in specific lets run through the process of adding a sequence number to trade table

        5. Bring down - sh bin/stop.sh ALL - will bring down any connected processes as well as the tickerplant
        6. Add column to sym file - sym file located in AdvKDB/q/tick/sym.q can update trade table definition with the following:

            trade:([]time:`timespan$();sym:`symbol$();price:`float$();size:`int$();seqNum:`int$())
        
        7. Starting tickerplant up again can check logs for any errors in initializing - sh bin/start.sh TICK
        8. Opening a handle to the tickerplant on a q process can check the updated schema to make sure changes were picked up:

            q) h:hopen 5010
            q) h "trade"

            Should return an empty table with the new column included - time sym price size seqNum
                                                                        --------------------------

        9. Finally to make sure historical queries will work and future EOD processing need to use dbmaint.q to update hdb structure something like the following:

            q) \l AdvKDB/q/common/dbmaint.q
            q) addcol[`:AdvKDB/hdb;`trade;`seqNum;0i]
            q) \l `:AdvKDB/hdb - (to check)

        10. Lastly, can use .Q.chk to ensure data integrity

Debugging:

    All complete solutions for the debugging problems located in sub directory: AdvKDB/debugging

API:

    As mentioned previously the load functions implementing differnt APIs can be called with the same one that calls the q version

    The web interface is a process that is automatically started up as part of the general tick structure. Can also be started interactivley to see queries form the kdb side:

        sh bin/start.sh -i WEB

    To access the client side should open a websocket enable browser and direct to ~/AdvKDB/scripts/websocket.html. Replace the root path if project folder is not in home directory.

    For API packages:

        Python: requries pandas - pip install pandas
                requires qpython - pip install qpython (https://pypi.org/project/qPython/)
        
        Java: requires kx connection - https://github.com/KxSystems/javakdb/releases
