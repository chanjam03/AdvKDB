if[not "w"=first string .z.o;system "sleep 1"];

upd:insert;

/ Retrieving tables to subcribe to from script invocation
.u.tabs:{$[0>type x;enlist x;x]} `$(.Q.opt .z.x)`sub;

/ Setting ticker plant and hdb ports
.u.x:":" ,/: (first (.Q.opt .z.x)`tp;first (.Q.opt .z.x)`hdb);

/ end of day: save, clear, hdb reload
.u.end:{t:tables`.;t@:where `g=attr each t@\:`sym;.Q.hdpf[`$":",.u.x 1;`:.;x;`sym];@[;`sym;`g#] each t;};

/ init schema and sync up from log file;cd to hdb(so client save can run)
.u.rep:{(.[;();:;].)each $[1=count first x;enlist x;x];if[null first y;:()];system raze "cd ",(.Q.opt .z.x)`dirHDB};
    
/ HARDCODE \cd if other than logdir/db

/ connect to ticker plant for (schema;(logcount;log))
.u.sub:{.u.rep .(hopen `$":",.u.x 0)"(.u.sub[;`] each `",("`" sv string .u.tabs),";`.u `i`L)";};