
// Functions - Logging
.log.out:{[msg] -1 " " sv (string .z.p; "User:"; raze string .z.h; "INFO:"; msg);};
.log.err:{[msg] -2 " " sv (string .z.p; "User:"; raze string .z.h; "ERROR:"; msg);};
.z.po:{.log.out["Port Opened: ", string .z.w]};
.z.pc:{.log.out["Port Closed: ", string .z.w]};
