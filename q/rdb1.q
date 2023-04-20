////////////////////////////////////////////////////////////////////////////////
//  
//  RDB1 q script
//
//  q rdb1.q -p <PORT_RDB1> -tp <PORT_TICK> -hdbp <PORT_HDB> -libCommon <LIB_COMMON> -libR <LIB_R> -dirHDB <DIR_HDB>
//
//  i.e. q rdb1.q -p 5030 -tp 5010 -hdbp 5012 -libCommon AdvKDB/q/common/common.q -libR AdvKDB/q/tick/r.q -dirHome AdvKDB/hdb
//
//  Parameters:
//      - [p]: port to start rdb1 process on as determined by config file
//      - [tp]: host port of tickerplant
//      - [hdbp]: host port of HDB instance
//      - [libCommon]: common library containing functions
//      - [libR]: library contain base runctions for rdb functionality
//      - [dirHome]: home dir to load in libs from
//      - [dirHDB]: hdb dir
//
////////////////////////////////////////////////////////////////////////////////

// Parsing command line arguments and sourcing applicable libraries
args:(.Q.opt .z.x);
system raze "l ",(args `libCommon);
system raze "l ",(args `libR);

// Defining tabs to subscribe to from TP
.u.tabs:`quote`trade;

//  Calling subscription
.log.out["Subscribing to tables from tickerplant"];
.u.sub[];
