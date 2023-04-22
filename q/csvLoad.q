////////////////////////////////////////////////////////////////////////////////
//  
//  CSV file shell start process
//
//  q csv.q -p <PORT_CSV> -tp <PORT_TICK> -libCommon <LIB_COMMON> -file <FILE> -table <NAME_TABLE>
//
//  i.e. q csv.q -p 5025 --file AdvKDB/files/optTrades.csv --table optTrades
//
//  Parameters:
//      - [p]: port to start CSV process on as determined by config file
//      - [tp]: port of tick process as determined by config file
//      - [libCommon]: common library containing functions
//      - [file]: complete file to csv to load in as passed by shell start
//      - [table]: name of table on tickerplant to update with file content
//
////////////////////////////////////////////////////////////////////////////////

// Parsing command line arguments and sourcing applicable libraries
args:(.Q.opt .z.x);
system raze "l ",(args `libCommon);
tp:first "J"$args `tp;
file:first hsym `$ args `file;
table:first `$ args `table;

// Connecting to tickerplant and getting schema information for table
h:hopen tp;
schema: h (raze "meta ",string table);
types: upper (flip value schema) `t;

// Loading csv file into memory
t:(types;enlist",")0:file;
vals:value flip t;

// Writing csv to tickerplant
h (".u.upd";table;vals);
