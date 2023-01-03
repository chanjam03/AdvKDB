/
    Feed shell start process

    q feed.q -p <PORT_RDB> -tp <PORT_TICK> 

    Parameters:
        - [p]: port to start RDB process on as determined by config file
        - [tp]: host port of tickerplant (default will be set to 5010 if option not supplied)
\

/ retrieving tickerplant port
PORT_TICK:first (.Q.opt .z.x)`tp;
h:neg hopen `$":localhost:",PORT_TICK;

/ defining syms and initial prices
syms:`RY`TD`ENB`SHOP`BAM`BMO`CM`TRI`SU
prices:syms!111.08 79.70 44.02 622.38 54.57 119.38 127.28 104.16 29.92

n:2 /number of rows per update
flag:1 /generate 10% of updates for trade and 90% for quote
getmovement:{[s] rand[0.0001]*prices[s]} /get a random price movement 
/generate trade price
getprice:{[s] prices[s]+:rand[1 -1]*getmovement[s]; prices[s]} 
getbid:{[s] prices[s]-getmovement[s]} /generate bid price
getask:{[s] prices[s]+getmovement[s]} /generate ask price
/timer function
.z.ts:{
  s:n?syms;
  $[0<flag mod 10;
    h(".u.upd";`quote;(n#.z.N;s;getbid'[s];getask'[s];n?1000;n?1000)); 
    h(".u.upd";`trade;(n#.z.N;s;getprice'[s];n?1000))];
  flag+:1; }
/trigger timer every 100ms
\t 100