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

// Checking port and ensuring that port is 6000 for websocket
if[not system"p";system"p 5060"];

// Parsing command line arguments and sourcing applicable libraries
args:(.Q.opt .z.x);
system raze "l ",(args `libCommon);
system raze "l ",(args `libR);

// Defining tabs to subscribe to from TP
.u.tabs:`trade`quote;

//  Calling subscription
.log.out["Subscribing to tables from tickerplant"];
.u.sub[];

// Defining websocket message handlers
.z.ws:{value x};
.z.wo:{`wsConn upsert (x;.z.t)};
.z.wc:{delete from `wsConn where handle = x};

// Functions to be called through websocket
loadPage:{ getSyms[.z.w]; sub[`getQuotes;enlist `]; sub[`getTrades;enlist `]};
filterSyms:{ sub[`getQuotes;x];sub[`getTrades;x]};

getSyms:{ (neg[x]) .j.j `func`result!(`getSyms;distinct (quote`sym),trade`sym)};

getQuotes:{
  filter:$[all raze null x;distinct quote`sym;raze x];
  res: 0!select last bid,last ask by sym,last time from quote where sym in filter;
  `func`result!(`getQuotes;res)};

getTrades:{
  filter:$[all raze null x;distinct trade`sym;raze x];
  res: 0!select last price,last size by sym,last time from trade where sym in filter;
  `func`result!(`getTrades;res)};

// Init websocket connection table
wsConn: ([] handle:(); connectTime:());
