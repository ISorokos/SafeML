from __future__ import print_function

import plygdata as pg

import pprint
import matplotlib.pyplot as plt
import numpy as np

from math import log
from math import sqrt
from math import pow
from numpy.linalg import det
from numpy import transpose
from numpy.linalg import inv
from numpy import array

data_noise=0.0
validation_data_ratio = 0.7

# Generate data
data_array = pg.generate_data(pg.DatasetType.ClassifyCircleData, data_noise)
# data_array = pg.generate_data(pg.DatasetType.ClassifyXORData, data_noise)
# data_array = pg.generate_data(pg.DatasetType.ClassifyTwoGaussData, data_noise)
# data_array = pg.generate_data(pg.DatasetType.ClassifySpiralData, data_noise)
# data_array = pg.generate_data(pg.DatasetType.RegressPlane, data_noise)
# data_array = pg.generate_data(pg.DatasetType.RegressGaussian, data_noise)

# Divide the data for training and validating at a specified ratio
X_train, y_train, X_valid, y_valid = pg.split_data(data_array, validation_size=validation_data_ratio)

# Plot Data
fig, ax = pg.plot_points_with_playground_style(X_train, y_train,X_valid , y_valid, figsize = (6, 6), dpi = 100)
plt.show()

from pandas import DataFrame

train_D = np.concatenate([X_train, y_train] ,axis = 1)

test_D = np.concatenate([X_valid, y_valid],axis = 1)

df = DataFrame(train_D)

# export_csv = df.to_csv (r'C:/Users/Koorosh/Desktop/Paper_Joyjit/PlayD_Circle.csv', index = None, header= None)

td1 = X_train[np.where(y_train[:,0] == 1)]
td2 = X_train[np.where(y_train[:,0] == -1)]
mean1 = np.mean(td1, axis = 0)
cov1 = np.cov(td1.T)
mean2 = np.mean(td2, axis = 0)
cov2 = np.cov(td2.T)

s = 0.5

mean_diff = mean2 - mean1
var_avg = (cov1 + cov2) * 0.5
ln_coeff = 0.5 * log(det(var_avg) / sqrt(det(cov1) * det(cov2)))

dist2 = 0.125 * np.matmul(np.matmul(mean_diff.T,inv(var_avg)), mean_diff) + ln_coeff

from numpy import exp

print('Error', exp(-dist2))
