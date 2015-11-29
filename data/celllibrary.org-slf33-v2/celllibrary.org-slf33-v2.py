# coding: utf-8

# In[ ]:

import cPickle as pickle
from os.path import isfile
from os.path import isdir
import numpy
from urllib import urlretrieve
from os import makedirs
from os import system

filename = 'celllibrary.org-slf33-v2.pkl'
if not isfile( filename ):
    print "Retrieving database " + filename
    url = 'http://murphylab.web.cmu.edu/software/searcher/' + filename
    urlretrieve( url, filename )
    
data = pickle.load( open( filename, 'r' ))

image_directory = './images/'
if not isdir( image_directory ):
    makedirs( image_directory )

resolution = 0.176
if data.has_key( resolution ):
    data = data[resolution]


# In[ ]:

cell_library = []

for datum in data:
    url = datum[3]
    print "Checking image " + url
    
    if numpy.isnan( datum[6:] ).any():
        print "Features contain NaNs. Ignoring feature vector."
    else:
        iid = url[35:]
        ome_tif_filename = image_directory + str(iid) + '.ome.tif'
        ome_tif_url = 'http://grackle.crbs.ucsd.edu:8080/OmeroWebService/images/' + iid + '.tif'
        original_image_viewer_url = datum[4]
        original_image_url = datum[3]
        thumbnail_image_url = datum[5]
        ome_tif_thumbnail_filename = image_directory + str(iid) + '.ome.jpg'
        
        if not isfile( ome_tif_filename ):
            print "Retrieving image: " + ome_tif_url
            urlretrieve( ome_tif_url, ome_tif_filename )
            
            print "Retrieving thumbnail: " + original_image_viewer_url
            urlretrieve( thumbnail_image_url, ome_tif_thumbnail_filename )
            
            database = datum[1]
            features = datum[7:]
            
            cell_library.append([iid, ome_tif_filename, ome_tif_url, original_image_url,original_image_viewer_url, ome_tif_thumbnail_filename, thumbnail_image_url, resolution, features])
            
filename = 'database-celllibrary_featureset-slf33_resolution-' +  str(resolution) + '_version2.0.pkl'
pickle.dump( cell_library, open( filename, 'w') )
