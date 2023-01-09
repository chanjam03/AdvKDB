
/
    CSV file shell start process

    q csv.q -p <PORT_CSV> 

    Parameters:
        - [p]: port to start RDB process on as determined by config file


        - [tp]: host port of tickerplant (default will be set to 5010 if option not supplied)
        - [hdb]: host port of HDB (defualt will be set to 5012 if option not supplied)
        - [dirHome]: repo base directory
        - [dirHDB]: base hdb directory
        - [sub]: tables to be subscribed too
\

/ Setting types to be read in from csv file
types:"DSIDFSIFFFFFFFIIS";

