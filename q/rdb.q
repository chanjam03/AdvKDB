/
    RDB shell start process

    q rdb.q -p <PORT_RDB> -tp <PORT_TICK>  -hdb <PORT_HDB> -dirHome <DIR_REPO> - dirHDB <DIR_HDB> -sub <tables>

    Parameters:
        - [p]: port to start RDB process on as determined by config file
        - [tp]: host port of tickerplant (default will be set to 5010 if option not supplied)
        - [hdb]: host port of HDB (defualt will be set to 5012 if option not supplied)
        - [dirHome]: repo base directory
        - [dirHDB]: base hdb directory
        - [sub]: tables to be subscribed too
\

/ Import filepaths and sourcing rdb funcitons
dirHome:(.Q.opt .z.x)`dirHome; 
system raze "l ",dirHome,"/q/tick/r.q"

/ Calling subscription
.u.sub[];