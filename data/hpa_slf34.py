
import cPickle as pickle
from urllib import urlretrieve
from os import remove

url = 'http://murphylab.web.cmu.edu/software/searcher/'
filename = 'proteinatlas.org-slf34-v5.pkl'

print "This file will download the SLF34 content database for the Human Protein Atlas v3.0 from OMERO.searcher v1.5.0"

print "Downloading file. Please be patient..."
urlretrieve(url + filename , filename )

content_database = pickle.load( open( filename, 'rw' ) )

resolution = 0.64
if content_database.has_key( resolution ):
	content_database = content_database[ 0.64 ]

remove( filename )
filename = "proteinatlas_r" + str(resolution) + "_slf33.pkl"

database = []
for datum in content_database:
	database.append([datum[6], datum[5],datum[11:]])

pickle.dump( database, open( filename, 'w' ) )