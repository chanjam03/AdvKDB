/
    RDB shell start process

    q rdb.q -p <PORT_RDB> -tp <PORT_TICK>  -hdb <PORT_HDB> -sub <tables>

    Parameters:
        - [p]: port to start RDB process on as determined by config file
        - [tp]: host port of tickerplant (default will be set to 5010 if option not supplied)
        - [hdb]: host port of HDB (defualt will be set to 5012 if option not supplied)
        - [sub]: tables to be subscribed too (what diferentiates rdb processes) 
\

if[not "w"=first string .z.o;system "sleep 1"];

upd:insert;

/ get the ticker plant and history ports
.u.x:":" ,/: (first (.Q.opt .z.x)`tp;first (.Q.opt .z.x)`hdb);
tabs:{"`",x} each (.Q.opt .z.x)`sub;

/ end of day: save, clear, hdb reload
.u.end:{t:tables`.;t@:where `g=attr each t@\:`sym;.Q.hdpf[`$":",.u.x 1;`:.;x;`sym];@[;`sym;`g#] each t;};

/ init schema and sync up from log file;cd to hdb(so client save can run)
.u.rep:{(.[;();:;].) x;if[null first y;:()];-11!y;system "cd ",1_-10_string first reverse y};
/ HARDCODE \cd if other than logdir/db

/ connect to ticker plant for (schema;(logcount;log)) - for eeach table
{.u.rep .(hopen `$":",.u.x 0) raze "(.u.sub[",x,";`];`.u `i`L)"} each tabs;