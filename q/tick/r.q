if[not "w"=first string .z.o;system "sleep 1"];

upd:insert;

// Setting ticker plant and hdb ports
.u.x:":" ,/: (first (.Q.opt .z.x)`tp;first (.Q.opt .z.x)`hdbp);

// End of day: save, clear, hdb reload
.u.end:{t:tables`.;t@:where `g=attr each t@\:`sym;.Q.hdpf[`$":",.u.x 1;`:.;x;`sym];@[;`sym;`g#] each t;};

// Init schema and sync up from log file;cd to hdb(so client save can run)
.u.rep:{(.[;();:;].)each $[1=count first x;enlist x;x];if[null first y;:()];system raze "cd ",(.Q.opt .z.x)`dirHDB};
    
// Connect to ticker plant for (schema;(logcount;log))
.u.sub:{.u.rep .(hopen `$":",.u.x 0)"(.u.sub[;`] each `",("`" sv string .u.tabs),";`.u `i`L)";};