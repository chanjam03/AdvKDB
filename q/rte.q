/
    Complex event processor shell start process

    q rdb.q -p <PORT_CPE> -tp <PORT_TICK>  -hdb <PORT_HDB> -dirHome <DIR_REPO> - dirHDB <DIR_HDB> -sub <tables>

    Parameters:
        - [p]: port to start CPE process on as determined by config file
        - [tp]: host port of tickerplant (default will be set to 5010 if option not supplied)
        - [hdb]: host port of HDB (defualt will be set to 5012 if option not supplied)
        - [dirHome]: repo base directory
        - [dirHDB]: base hdb directory
        - [sub]: tables to be subscribed too
\

/ Import filepaths and sourcing rdb funcitons
dirHome:(.Q.opt .z.x)`dirHome; 
system raze "l ",dirHome,"/q/tick/r.q";

/ Calling subscription
.u.sub[];

/ Gen top book details
genDetails:{[]
    ret:select maxPx:max price by sym from trade;
    ret:ret lj select minPx:min price by sym from trade;
    ret:ret lj select volume:sum size by sym from trade;
    ret:ret lj xkey[`sym;] select from quote where time = (max;time) fby sym;
    ret:xkey[`sym;] xcols[`sym`time;] 0! ret;
    :ret;};

/ Setting function to be run on interval
.z.ts:{
    tab:genDetails[];
    vals:flip value flip 0! tab;
    {h(".u.upd";`OHLC;(enlist .z.N),x)} each vals;
    };

/ Opening handle to tickerplant and intializing .z.ts
h:hopen hsym `$ raze "localhost:",(.Q.opt .z.x)`tp;
\t 5000