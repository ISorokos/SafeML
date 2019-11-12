import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import datetime

from sklearn import manifold, datasets
from sklearn.manifold import TSNE
from time import time
from sklearn.decomposition import PCA
from math import sqrt
from math import pow
from numpy.linalg import det
from numpy import transpose
from numpy import array
from numpy.linalg import inv

df = pd.read_csv('C:/Users/582725/Downloads/S3_1E5_type2.csv', sep = ',')
df.head()
df = df.fillna(0)
df2 = df.drop(df.columns[-1], axis=1)
df2: object = df2.loc[:, (df2 != 0).any(axis=0)]

pca = PCA(n_components=3)
pca_result = pca.fit_transform(df2)
df2['pca-one'] = pca_result[:,0]
df2['pca-two'] = pca_result[:,1]
df2['pca-three'] = pca_result[:,2]

df3 = np.concatenate((df2['pca-one'].values.reshape(99999,1), df2['pca-two'].values.reshape(99999,1),df2['pca-three'].values.reshape(99999,1)), axis=1)

from sklearn.model_selection import train_test_split
train1, test1 = train_test_split(df3, test_size = 0.3)

if __name__ == '__main__':


    from math import log
    from math import sqrt
    from math import pow
    from numpy.linalg import det
    from numpy import transpose
    from numpy.linalg import inv
    from numpy import array

    mean1 = np.mean(train1, axis = 0)
    mean1 = mean1.reshape(3, 1)
    cov1 = np.cov(train1.T)
    mean2 = np.mean(test1, axis = 0)
    mean2 = mean2.reshape(3, 1)
    cov2 = np.cov(test1.T)

    s = 0.5

    from numpy import exp

    mean_diff = mean2 - mean1
    mean_diff = mean_diff.reshape(3, 1)
    var_avg = (cov1 + cov2) * 0.5
    ln_coeff = 0.5 * log(det(var_avg) / sqrt(det(cov1) * det(cov2)))


    dist2 = 0.125 * np.matmul(np.matmul(mean_diff.T,inv(var_avg)), mean_diff) + ln_coeff

    print('Error', 1 - exp(-dist2))