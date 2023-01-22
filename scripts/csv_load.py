
from qpython import qconnection
from qpython.qtype import QException
import csv

# Connect to kdb ticker plant
q = qconnection.QConnection(host='localhost', port=5010)
q.open()

# Getting variables.
CSV_PATH = '/Users/firstderivative/dev/AdvKDB/file/optTrades.csv'
TABLE = 'optTrades'

# Itterating through csv file
try:
    with open(CSV_PATH, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            q.sendSync('insert', TABLE, list(row.values()))
except QException as e:
    print(e)
finally:
    q.close()


