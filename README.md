typic
======
typic is a python implementation of the [Typical Image Chooser](http://murphylab.web.cmu.edu/projects/typical/) as described in

* Markey, M.K., Boland, M.V., and Murphy, R.F. (1999) [Towards Objective Selection of Representative Microscope Images](http://murphylab.web.cmu.edu/publications/72-markey1999.pdf). Biophysical Journal 76:2230-2237.
 
TypIC is also available as a [service](http://murphylab.web.cmu.edu/services/TypIC/) in the [Protein Subcellular Location Image Database (PSLID)](http://pslid.org/start.html); though the latter version is not the one described in this repository.

### Development branch status
[![Build Status](https://travis-ci.org/icaoberg/typic.svg?branch=dev)](https://travis-ci.org/icaoberg/typic)

### Master branch status
[![Build Status](https://travis-ci.org/icaoberg/typic.svg?branch=master)](https://travis-ci.org/icaoberg/typic)

Pre-Requisites
--------------
- numpy
- scipy

To install the prerequisites in Ubuntu 12.04

```
sudo apt-get install update
sudo apt-get install python-numpy python-scipy
```

Installation
============

There are several ways to install typic. The most common way is to download the source code, unzip/untar the source code package and run the command

```
sudo python setup.py install
```
 
I have plans of submitting this package to the Python Package Index. 
If I do so, then should be able to install it by running the command

```
sudo pip install typic
```

**COMMENT**: halcon depends on [numpy](http://www.numpy.org) and [scipy](http://www.scipy.org). Installing these packages in Windows and MacOSX is not a trivial task. For more information refer to the documentation.

If you wish to install typic in a virtual enviroment, then you can do

```
virtualenv typic
cd typic
source ./bin/activate
pip install numpy
pip install scipy
mkdir src
cd src
git clone git@github.com:icaoberg/typic.git
cd typic
python setup.py install
cd ../../
deactivate
```

**COMMENT**: The previous snippet assumes that you have [virtualenv](https://pypi.python.org/pypi/virtualenv) installed in your working system.

Documentation
-------------
Documentation was written using [Sphinx](http://sphinx-doc.org/).
 To generate documentation use the following commands.

To generate html
```
cd docs
make html
```

To generate PDF document
```
cd docs
make latexpdf
```

To generate epub document
```
cd docs
make epub
```

Bugs and Questions
------------------
To submit bugs about the source code visit

https://github.com/icaoberg/typic

To submit bugs about the documentation visit

https://github.com/icaoberg/typic-docs

For any other inquiries visit those links as well.