#!/bin/bash

virtualenv --system_site_packages .
source ./bin/activate

pip install jupyter
pip install -U ipython[all]
pip install numpy
pip install scipy

deactivate
