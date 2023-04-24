////////////////////////////////////////////////////////////////////////////////
//  
//  End of day processing q script
//
//  q hdb.q -p <PORT_HDB> -libCommon <LIB_COMMON> -dirHDB <DIR_HDB>
//
//  i.e. q feed.q -p 5015 -tp 5010
//
//  Parameters:
//      - [p]: port to start tickerplant process on as determined by config file
//      - [tp]: host port of tickerplant
//      - [libCommon]: common library containing functions
//
////////////////////////////////////////////////////////////////////////////////

// Parsing command line arguments and sourcing applicable libraries
args:(.Q.opt .z.x);
system raze "l ",(args `libCommon);
system raze "l ",(args `libSym);
dirHDB:args `dirHDB;
tpLog:hsym first `$ raze (args `dirReplay),"/sym",(string .z.D);

// Defining update function and saving function for parsing replayed log file
upd:{[tab;data] insert[tab;data]}

saveTab:{[dt;tab]
    fp:hsym `$ raze dirHDB,"/",(string dt),"/",(string tab),"/";
    compCols:(),cols[tab] except `time`sym;
    compDets:compCols!(count compCols)#enlist (17;2;6);
    (fp;compDets) set .Q.en[hsym first `$ dirHDB;get tab]
    };

// Replaying log file and updating tables in memory
-11!tpLog;

// Saving down each table with compression on all other cols
saveTab[.z.D] each tables[`.];
