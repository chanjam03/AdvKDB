////////////////////////////////////////////////////////////////////////////////
//  
//  Historical database q script
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
system raze "l ",(args `dirHDB);
