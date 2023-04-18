////////////////////////////////////////////////////////////////////////////////
//  
//  CSV file shell start process
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

// Read in libs
system raze "l ",dirHome,"/q/common/logging.q";

// Parsing passed command line arguments
PORT_TICK:first "J"$(.Q.opt .z.x)`$"-tp";
FILE:first hsym `$(.Q.opt .z.x)`$"-file";
TABLE:first `$(.Q.opt .z.x)`$"-table";

// Connecting to tickerplant and getting schema information for table
h:hopen PORT_TICK;
schema: h (raze "meta ",string TABLE);
types: upper -1_ (-1 _ flip value schema) `t;

// Loading csv file into memory
t:(types;enlist",")0:FILE;

// Writing rows to tickerplant
@[h; (`.u.upd; TABLE; flip get each t); {0}]
