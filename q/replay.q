////////////////////////////////////////////////////////////////////////////////
//  
//  Replay log file process
//
//  q replay.q -p 5050 -libCommon <LIB_COMMON> -dirReplay <DIR_LOGS_REP> -dirTick <DIR_TICK> -table <TABLE> -sym <SYM> -date <DATE>"
//
//  i.e. q replay.q -p 5050 -libCommon AdvKDB/q/common/common.q -dirReplay AdvKDB/logs/replay -dirTick AdvKDB/q/tick -table trade -sym ENB -date
//
//  Parameters:
//      - [p]: port to start Replay process on as determined by config file
//      - [libCommon]: common library containing functions
//      - [dirReplay]: log directory containing replay files
//      - [dirTick]: tick directory containing schema file
//      - [table]: table on which to filter log file 
//      - [sym]: symbol to filter on 
//      - [date]: date to filter on
//
////////////////////////////////////////////////////////////////////////////////

// Parsing command line arguments and sourcing applicable libraries
args:(.Q.opt .z.x);
system raze "l ",(args `libCommon);
dirReplay:args `dirReplay;
dirTick:args `dirTick;
system raze "l ",(args `dirTick),"/sym.q";
table:first `$ args `table;
filterSym:first `$ args `sym;
dt:args `date;

// Creating filepaths to replay file and schemareading in values
vals:get hsym `$ raze dirReplay,"/sym",dt;

// Filtering based on based criteria
vals:vals[;2] where [vals[;1] = table];
{insert[table;] x} each vals;
vals:flip value flip ?[`trade;enlist (=;`sym;`filterSym);0b;()];

// Opening handle to new log file and writing updates
writeFp:hsym `$ raze dirReplay,"/",(string filterSym),dt;
writeFp set ();
h:hopen writeFp;
{h enlist (".u.upd";table;x)} each vals;
