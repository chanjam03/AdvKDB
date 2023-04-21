////////////////////////////////////////////////////////////////////////////////
//  
//  Feedhandler q script
//
//  q feed.q -p <PORT_RDB> -tp <PORT_TICK> -libCommon <LIB_COMMON> -libR <LIB_R>
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
system raze "l ",(args `libR);
tp:first args `tp;

// Defining tabs to subscribe to from TP
.u.tabs:`quote`trade;

// Calling subscription
.log.out["Subscribing to tables from tickerplant"];
.u.sub[];

// Gen top book details
genDetails:{[]
    ret:select maxPx:max price by sym from trade;
    ret:ret lj select minPx:min price by sym from trade;
    ret:ret lj select volume:sum size by sym from trade;
    ret:ret lj xkey[`sym;] select from quote where time = (max;time) fby sym;
    ret:0! xkey[`sym;] xcols[`sym`time;] 0! ret;
    ret:select time,sym,volume,maxPx,minPx,bid,ask,bsize,asize from ret;
    ret:value flip ret;
    :ret;};

// Setting function to be run on interval
.z.ts:{
    rets:genDetails[];
    h (".u.upd";`OHLC;rets);
    };

// Opening handle to tickerplant and intializing .z.ts
h:hopen hsym `$ raze "localhost:",tp;
\t 5000
