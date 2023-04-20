////////////////////////////////////////////////////////////////////////////////
//  
//  Tickerplant q script
//
//  q tick.q sym <DIR_LOGS_REP> -p <PORT_TICK> -libCommon <LIB_COMMON> -libU <LIB_U> -dirTick <DIR_TICK>
//
//  i.e. q tick.q sym replay -p 5010 -libCommon AdvKDB/q/common/common.q -libU AdvKDB/q/tick/u.q -dirHome AdvKDB
//
//  Parameters:
//      - [sym]: filepath to tp log file
//      - [p]: port to start tickerplant process on as determined by config file
//      - [libCommon]: common library containing functions
//      - [libU]: library containg base .u functions for tickerplant implementation
//      - [dirHome]: home dir to load in libs from
//
////////////////////////////////////////////////////////////////////////////////

// Checking port and ensuring that port is 5010 for tickerplant
if[not system"p";system"p 5010"];

// Importing filepaths and loading additional libraries
args:(.Q.opt .z.x);
system raze "l ",(args `libCommon);
system raze "l ",(args `dirTick),"/",(src:first .z.x,enlist"sym"),".q";
system raze "l ",(args `libU);

.log.out["Updating .u functions"];
\d .u
ld:{if[not type key L::`$(-10_string L),string x;.[L;();:;()]];i::j::-11!(-2;L);if[0<=type i;-2 (string L)," is a corrupt log. Truncate to length ",(string last i)," and restart";exit 1];hopen L};
tick:{init[];@[;`sym;`g#]each t;schema::x;logpath::y;d::.z.D;if[l::count y;L::`$":",y,"/",x,10#".";l::ld d];};

endofday:{.log.out["Starting EOD process."];end d;d+:1;if[l;hclose l;l::0(`.u.ld;d)]};
ts:{if[d<x;if[d<x-1;system"t 0";'.log.error["more than one day?"]];endofday[]]};

if[system"t";
 .z.ts:{pub'[t;value each t];@[`.;t;@[;`sym;`g#]0#];i::j;ts .z.D};
 upd:{[t;x]
 if[not -16=type first first x;if[d<"d"$a:.z.P;.z.ts[]];a:"n"$a;x:$[0>type first x;a,x;(enlist(count first x)#a),x]];
 t insert x;if[l;l enlist (`upd;t;x);j+:1];}];

if[not system"t";system"t 1000";
 .z.ts:{ts .z.D};
 upd:{[t;x]ts"d"$a:.z.P;
 if[not -16=type first first x;a:"n"$a;x:$[0>type first x;a,x;(enlist(count first x)#a),x]];
 f:key flip value t;pub[t;$[0>type first x;enlist f!x;flip f!x]];if[l;l enlist (`upd;t;x);i+:1];}];

\d .

.u.tick[src;.z.x 1];
