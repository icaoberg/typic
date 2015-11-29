#!/bin/bash

virtualenv --system-site-packages .
source ./bin/activate

pip install jupyter
pip install -U ipython[all]
pip install numpy
pip install scipy
pip install tabulate
pip install pandas
pip install scikit-learn

deactivate
