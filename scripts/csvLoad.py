from qpython import qconnection
import pandas as pd
import argparse

class data:

    def __init__(self,q,file,table):
        self.q = q
        self.file = file
        self.table = table
        self.types = self.read_types()

    def read_types(self):
        schema = q.sendSync("meta " + self.table)
        types = list(schema["t"])
        return types

    def read_csv(self):
        df = pd.read_csv(self.file)
        self.vals = df.values

    def sendMsgs(self):
        for msg in self.vals:
            q.sendSync(self.format_msg(msg))

    def format_msg(self,msg):
        for i,val in enumerate(msg):
            val = str(val)
            if self.types[i] == "n":
                msg[i] = "0D"+(val.split("D"))[-1]
            if self.types[i] == "s":
                msg[i] = "`"+val
            if self.types[i] == "i":
                msg[i] = val+"i"
            if self.types[i] == "d":
                msg[i] = val.replace("-",".")
            if self.types[i] == "f":
                msg[i] = str(val)+"f"
        msg = ".u.upd[`" + self.table + ";(enlist " + ";enlist ".join(msg) + ")]"
        return msg
        

if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("-tp", action="store", help="Port of tickerplant", type=int, default=5010, required=False)
    parser.add_argument("-file", action="store", help="Filepath of csv to load to tickerplant", required=True)
    parser.add_argument("-table", action="store", help="Name of table to update on tickerplant", required=True)
    args = parser.parse_args()

    with qconnection.QConnection(host='localhost', port=args.tp, pandas=True) as q:
        t = data(q,args.file,args.table)
        t.read_csv()
        t.sendMsgs()
