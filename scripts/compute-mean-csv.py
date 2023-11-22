import sys
sys.path.append("/home/lehembr211/.local/lib/python3.8/site-packages")
sys.path.append("/usr/lib/python3/dist-packages")
import pandas as pd

print('Output file: ', sys.argv[1])
print('Working on ', (len(sys.argv)-2), ' files.')
print(str(sys.argv[2:]))

files = []
# We concatenate all the results files (we remove argv[0] which is script name
# and argv[2] which is the output file).
for k in range(2,len(sys.argv)):
  files+=[pd.read_csv(sys.argv[k], sep=',')]

# Getting all the csvs in the same data frame then getting mean by Time stamp.
data = pd.concat(files)
data = data.groupby(['Time','Layer','Type']).mean()

data.to_csv(sys.argv[1], sep=',')

