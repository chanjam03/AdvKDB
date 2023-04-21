////////////////////////////////////////////////////////////////////////////////
//  
//  Replay log file process
//
//  q csv.q -p <PORT_CSV> -tp <PORT_TICK> --file <FILE> --table <NAME_TABLE>
//
//  i.e. q csv.q -p 5025 --file AdvKDB/files/optTrades.csv --table optTrades
//
//  Parameters:
//      - [p]: port to start CSV process on as determined by config file
//      - [tp]: port of tick process as determined by config file
//      - [file]: complete file to csv to load in as passed by shell start
//      - [table]: name of table on tickerplant to update with file content
//
////////////////////////////////////////////////////////////////////////////////

// Parsing command line arguments and sourcing applicable libraries
args:(.Q.opt .z.x);
system raze "l ",(args `libCommon);
dirReplay:args `dirReplay;
table:first `$ args `table;
sym:first `$ args `sym;
dt:$[`~dt:(first `$ args `date);.z.D;"D"$ string dt];
