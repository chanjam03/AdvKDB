
from qpython import qconnection
import csv
import argparse

def main():
    # Getting passed variables from bash script invokation
    parser = argparse.ArgumentParser()
    parser.add_argument("--file",action="store", help="Filepath of csv to load to tickerplant", required=True)
    parser.add_argument("--table",action="store", help="Name of table to update on tickerplant")
    args = parser.parse_args()
    
    # Reading in csv file from passed path
    with open(args.file, 'r') as csvfile:
        csv_reader = csv.reader(csvfile)
        i = 0
        for i,row in enumerate(csv_reader):
            if i == 0:
                continue
            q.sendAsync('.u.upd',args.table,row)
            
if __name__ == "__main__":
    # Connect to kdb ticker plant
    q = qconnection.QConnection(host='localhost', port=5010)
    q.open()
    main()
    q.close()
