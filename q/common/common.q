
// Functions - Logging
.log.out:{[message] -1 " " sv (string .z.p; "User:"; raze string .z.h; "INFO:"; message; "Mem:";.Q.s1 .Q.w[]);};
.log.err:{[message] -2 " " sv (string .z.p; "User:"; raze string .z.h; "ERROR:"; message; "Mem:";.Q.s1 .Q.w[]);};
.z.po:{.log.out["Port Opened: ", string .z.w]};
.z.pc:{.log.out["Port Closed: ", string .z.w]};
