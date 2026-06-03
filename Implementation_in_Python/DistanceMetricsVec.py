'''
Description: This module contains the vectorized functions for SafeML Metrics calculation.
References:

'''

import numpy as np
from scipy.stats import chi2

PVALUE_ALPHA_THRESHOLD = 0.05

# Cramer-Von Mises Distance

def CVM_Dist_p(XX, YY):
    '''
    L1-version of the Cramer von Mises distance.
    '''
    nx = len(XX)
    ny = len(YY)
    XY = np.concatenate([XX, YY])
    X2 = np.concatenate([np.repeat(1/nx, nx), np.repeat(0, ny)])
    Y2 = np.concatenate([np.repeat(0, nx), np.repeat(1/ny, ny)])

    S_Ind = np.argsort(XY)
    XY_Sorted = XY[S_Ind]
    X2_Sorted = X2[S_Ind]
    Y2_Sorted = Y2[S_Ind]

    E_CDF = X2_Sorted[:-1].cumsum()
    F_CDF = Y2_Sorted[:-1].cumsum()
    height_mask = XY_Sorted[1:] != XY_Sorted[:-1]
    return np.sum((np.abs(F_CDF - E_CDF) * height_mask))


def CVM_Dist_PVal(XX, YY, nboots=1000):
    CVM = CVM_Dist_p(XX, YY)
    na = len(XX)
    nb = len(YY)
    n = na + nb
    comb = np.concatenate([XX, YY])

    e_list = np.random.rand(nboots, n).argpartition(na)[:, :na]
    f_list = np.random.rand(nboots, n).argpartition(na)[:, :na]
    result = np.empty(nboots)
    for i, (x, y) in enumerate(zip(e_list, f_list)):
        result[i] = CVM_Dist_p(comb[x], comb[y])

    pVal = np.sum(result > CVM) / nboots
    return pVal, CVM


# Wasserstein Distance

def Wasserstein_Dist_p(XX, YY):
    nx = len(XX)
    ny = len(YY)
    XY = np.concatenate([XX, YY])
    X2 = np.concatenate([np.repeat(1/nx, nx), np.repeat(0, ny)])
    Y2 = np.concatenate([np.repeat(0, nx), np.repeat(1/ny, ny)])

    S_Ind = np.argsort(XY)
    XY_Sorted = XY[S_Ind]
    X2_Sorted = X2[S_Ind]
    Y2_Sorted = Y2[S_Ind]

    E_CDF = X2_Sorted[:-1].cumsum()
    F_CDF = Y2_Sorted[:-1].cumsum()
    width = XY_Sorted[1:] - XY_Sorted[:-1]
    return np.sum((np.abs(E_CDF - F_CDF)) * width)


def Wasserstein_Dist_PVal(XX, YY, nboots=1000):
    WD = Wasserstein_Dist_p(XX, YY)
    na = len(XX)
    nb = len(YY)
    n = na + nb
    comb = np.concatenate([XX, YY])

    e_list = np.random.rand(nboots, n).argpartition(na)[:, :na]
    f_list = np.random.rand(nboots, n).argpartition(na)[:, :na]
    result = np.empty(nboots)
    for i, (x, y) in enumerate(zip(e_list, f_list)):
        result[i] = Wasserstein_Dist_p(comb[x], comb[y])

    pVal = np.sum(result > WD) / nboots
    return pVal, WD


# Anderson Darling Distance

def Anderson_Darling_Dist_p(XX, YY):
    nx = len(XX)
    ny = len(YY)
    n = nx + ny

    XY = np.concatenate([XX, YY])
    X2 = np.concatenate([np.repeat(1/nx, nx), np.repeat(0, ny)])
    Y2 = np.concatenate([np.repeat(0, nx), np.repeat(1/ny, ny)])

    S_Ind = np.argsort(XY)
    XY_Sorted = XY[S_Ind]
    X2_Sorted = X2[S_Ind]
    Y2_Sorted = Y2[S_Ind]

    E_CDF = X2_Sorted[:-1].cumsum()
    F_CDF = Y2_Sorted[:-1].cumsum()
    G_CDF = np.arange(0, n - 1) / n
    SD = np.sqrt(n * G_CDF * (1 - G_CDF))
    mask = (XY_Sorted[1:] != XY_Sorted[:-1]) & (SD > 0)

    return np.sum((np.abs(F_CDF[mask] - E_CDF[mask]) / SD[mask]) )


def Anderson_Darling_Dist_PVal(XX, YY, nboots=1000):
    AD = Anderson_Darling_Dist_p(XX, YY)
    na = len(XX)
    nb = len(YY)
    n = na + nb
    comb = np.concatenate([XX, YY])

    e_list = np.random.rand(nboots, n).argpartition(na)[:, :na]
    f_list = np.random.rand(nboots, n).argpartition(na)[:, :na]
    result = np.empty(nboots)
    for i, (x, y) in enumerate(zip(e_list, f_list)):
        result[i] = Anderson_Darling_Dist_p(comb[x], comb[y])

    pVal = np.sum(result > AD) / nboots
    return pVal, AD


# Kolmogorov Smirnov Distance

def Kolmogorov_Smirnov_Dist_p(XX, YY):
    nx = len(XX)
    ny = len(YY)
    XY = np.concatenate([XX, YY])
    X2 = np.concatenate([np.repeat(1/nx, nx), np.repeat(0, ny)])
    Y2 = np.concatenate([np.repeat(0, nx), np.repeat(1/ny, ny)])

    S_Ind = np.argsort(XY)
    XY_Sorted = XY[S_Ind]
    X2_Sorted = X2[S_Ind]
    Y2_Sorted = Y2[S_Ind]

    E_CDF = X2_Sorted[:-1].cumsum()
    F_CDF = Y2_Sorted[:-1].cumsum()
    height_mask = XY_Sorted[1:] != XY_Sorted[:-1]

    return np.max(np.abs(E_CDF - F_CDF) * height_mask)


def Kolmogorov_Smirnov_Dist_PVal(XX, YY, nboots=1000):
    KSD = Kolmogorov_Smirnov_Dist_p(XX, YY)
    na = len(XX)
    nb = len(YY)
    n = na + nb
    comb = np.concatenate([XX, YY])

    e_list = np.random.rand(nboots, n).argpartition(na)[:, :na]
    f_list = np.random.rand(nboots, n).argpartition(na)[:, :na]
    result = np.empty(nboots)
    for i, (x, y) in enumerate(zip(e_list, f_list)):
        result[i] = Kolmogorov_Smirnov_Dist_p(comb[x], comb[y])

    pVal = np.sum(result > KSD) / nboots
    return pVal, KSD


# DTS Distance

def DTS_Dist_p(XX, YY):
    nx = len(XX)
    ny = len(YY)
    n = nx + ny

    XY = np.concatenate([XX, YY])
    X2 = np.concatenate([np.repeat(1/nx, nx), np.repeat(0, ny)])
    Y2 = np.concatenate([np.repeat(0, nx), np.repeat(1/ny, ny)])

    S_Ind = np.argsort(XY)
    XY_Sorted = XY[S_Ind]
    X2_Sorted = X2[S_Ind]
    Y2_Sorted = Y2[S_Ind]

    E_CDF = X2_Sorted[:-1].cumsum()
    F_CDF = Y2_Sorted[:-1].cumsum()
    G_CDF = np.arange(0, n - 1) / n
    SD = np.sqrt(n * G_CDF * (1 - G_CDF))
    mask = SD > 0
    width = XY_Sorted[1:] - XY_Sorted[:-1]

    return np.sum((np.abs(E_CDF[mask] - F_CDF[mask]) / SD[mask]) * width[mask])


def DTS_Dist_PVal(XX, YY, nboots=1000):
    DTS = DTS_Dist_p(XX, YY)
    na = len(XX)
    nb = len(YY)
    n = na + nb
    comb = np.concatenate([XX, YY])

    e_list = np.random.rand(nboots, n).argpartition(na)[:, :na]
    f_list = np.random.rand(nboots, n).argpartition(na)[:, :na]
    result = np.empty(nboots)
    for i, (x, y) in enumerate(zip(e_list, f_list)):
        result[i] = DTS_Dist_p(comb[x], comb[y])

    pVal = np.sum(result > DTS) / nboots
    return pVal, DTS


def ES_Dist(XX, YY, t=(0.4, 0.8)):
    XX, YY, t = np.asarray(XX), np.asarray(YY), np.asarray(t)
    XY = np.concatenate((XX, YY))
    nx, ny = len(XX), len(YY)
    n = nx + ny

    sigma = (np.percentile(XY, 75, interpolation='midpoint') - np.percentile(XY, 25, interpolation='midpoint')) / 2
    ts = t.reshape((-1, 1)) / sigma
    gxm = np.vstack((np.cos(ts * XX), np.sin(ts * XX)))
    gym = np.vstack((np.cos(ts * YY), np.sin(ts * YY)))
    g_diff = np.mean(gxm, axis=1) - np.mean(gym, axis=1)

    Sx = ((nx - 1) / nx) * np.cov(gxm)
    Sy = ((ny - 1) / ny) * np.cov(gym)
    omega = (n / nx) * Sx + (n / ny) * Sy
    omega_inv = np.linalg.pinv(omega)
    rank = np.linalg.matrix_rank(omega_inv)
    W2 = n * np.dot(g_diff, np.dot(omega_inv, g_diff.T))

    if max(nx, ny) < 25:
        corr = 1.0 / (1.0 + n ** (-0.45) + 10.1 * (nx ** (-1.7) + ny ** (-1.7)))
        W2 = corr * W2

    p = 1 - chi2.cdf(W2, rank)
    return W2, p


def _flatten_for_distance(arr):
    arr = np.asarray(arr)
    if arr.ndim <= 1:
        return arr
    return arr.reshape(-1)


def CVM_Dist_p(XX, YY):
    XX = _flatten_for_distance(XX)
    YY = _flatten_for_distance(YY)

    nx = len(XX)
    ny = len(YY)
    n = nx + ny

    XY = np.concatenate([XX, YY])
    X2 = np.concatenate([np.repeat(1 / nx, nx), np.repeat(0, ny)])
    Y2 = np.concatenate([np.repeat(0, nx), np.repeat(1 / ny, ny)])

    S_Ind = np.argsort(XY)
    XY_Sorted = XY[S_Ind]
    X2_Sorted = X2[S_Ind]
    Y2_Sorted = Y2[S_Ind]

    E_CDF = X2_Sorted[:-1].cumsum()
    F_CDF = Y2_Sorted[:-1].cumsum()
    height_mask = XY_Sorted[1:] != XY_Sorted[:-1]
    power = 1

    Res = np.sum((np.abs(F_CDF - E_CDF) * height_mask) ** power)
    return Res


def CVM_Dist_PVal(XX, YY, nboots=1000):
    XX = _flatten_for_distance(XX)
    YY = _flatten_for_distance(YY)

    CVM = CVM_Dist_p(XX, YY)
    na = len(XX)
    nb = len(YY)
    n = na + nb
    comb = np.concatenate([XX, YY])

    result = np.empty(nboots)
    for i in range(nboots):
        x = np.random.choice(n, na, replace=False)
        y = np.random.choice(n, na, replace=False)
        result[i] = CVM_Dist_p(comb[x], comb[y])

    pVal = np.sum(result > CVM) / nboots
    return pVal, CVM


def Wasserstein_Dist_p(XX, YY):
    XX = _flatten_for_distance(XX)
    YY = _flatten_for_distance(YY)

    nx = len(XX)
    ny = len(YY)
    n = nx + ny

    XY = np.concatenate([XX, YY])
    X2 = np.concatenate([np.repeat(1 / nx, nx), np.repeat(0, ny)])
    Y2 = np.concatenate([np.repeat(0, nx), np.repeat(1 / ny, ny)])

    S_Ind = np.argsort(XY)
    XY_Sorted = XY[S_Ind]
    X2_Sorted = X2[S_Ind]
    Y2_Sorted = Y2[S_Ind]

    E_CDF = X2_Sorted[:-1].cumsum()
    F_CDF = Y2_Sorted[:-1].cumsum()
    width = XY_Sorted[1:] - XY_Sorted[:-1]
    Res = ((np.abs(E_CDF - F_CDF)) * width).sum()

    return Res


def Wasserstein_Dist_PVal(XX, YY, nboots=1000):
    XX = _flatten_for_distance(XX)
    YY = _flatten_for_distance(YY)

    WD = Wasserstein_Dist_p(XX, YY)
    na = len(XX)
    nb = len(YY)
    n = na + nb
    comb = np.concatenate([XX, YY])

    result = np.empty(nboots)
    for i in range(nboots):
        x = np.random.choice(n, na, replace=False)
        y = np.random.choice(n, na, replace=False)
        result[i] = Wasserstein_Dist_p(comb[x], comb[y])

    pVal = np.sum(result > WD) / nboots
    return pVal, WD


def Anderson_Darling_Dist_p(XX, YY):
    XX = _flatten_for_distance(XX)
    YY = _flatten_for_distance(YY)

    nx = len(XX)
    ny = len(YY)
    n = nx + ny

    XY = np.concatenate([XX, YY])
    X2 = np.concatenate([np.repeat(1 / nx, nx), np.repeat(0, ny)])
    Y2 = np.concatenate([np.repeat(0, nx), np.repeat(1 / ny, ny)])

    S_Ind = np.argsort(XY)
    XY_Sorted = XY[S_Ind]
    X2_Sorted = X2[S_Ind]
    Y2_Sorted = Y2[S_Ind]

    E_CDF = X2_Sorted[:-1].cumsum()
    F_CDF = Y2_Sorted[:-1].cumsum()
    G_CDF = np.arange(0, n - 1, 1) / n
    SD = np.sqrt(n * G_CDF * (1 - G_CDF))
    mask = (XY_Sorted[1:] != XY_Sorted[:-1]) & (SD > 0)
    Res = ((np.abs(F_CDF[mask] - E_CDF[mask]) / SD[mask]) ** 1).sum()

    return Res


def Anderson_Darling_Dist_PVal(XX, YY, nboots=1000):
    XX = _flatten_for_distance(XX)
    YY = _flatten_for_distance(YY)

    AD = Anderson_Darling_Dist_p(XX, YY)
    na = len(XX)
    nb = len(YY)
    n = na + nb
    comb = np.concatenate([XX, YY])

    result = np.empty(nboots)
    for i in range(nboots):
        x = np.random.choice(n, na, replace=False)
        y = np.random.choice(n, na, replace=False)
        result[i] = Anderson_Darling_Dist_p(comb[x], comb[y])

    pVal = np.sum(result > AD) / nboots
    return pVal, AD


def Kolmogorov_Smirnov_Dist_p(XX, YY):
    XX = _flatten_for_distance(XX)
    YY = _flatten_for_distance(YY)

    nx = len(XX)
    ny = len(YY)
    n = nx + ny

    XY = np.concatenate([XX, YY])
    X2 = np.concatenate([np.repeat(1 / nx, nx), np.repeat(0, ny)])
    Y2 = np.concatenate([np.repeat(0, nx), np.repeat(1 / ny, ny)])

    S_Ind = np.argsort(XY)
    XY_Sorted = XY[S_Ind]
    X2_Sorted = X2[S_Ind]
    Y2_Sorted = Y2[S_Ind]

    E_CDF = X2_Sorted[:-1].cumsum()
    F_CDF = Y2_Sorted[:-1].cumsum()
    height_mask = XY_Sorted[1:] != XY_Sorted[:-1]
    Res = (np.abs(E_CDF - F_CDF) * height_mask).max()

    return Res


def Kolmogorov_Smirnov_Dist_PVal(XX, YY, nboots=1000):
    XX = _flatten_for_distance(XX)
    YY = _flatten_for_distance(YY)

    KSD = Kolmogorov_Smirnov_Dist_p(XX, YY)
    na = len(XX)
    nb = len(YY)
    n = na + nb
    comb = np.concatenate([XX, YY])

    result = np.empty(nboots)
    for i in range(nboots):
        x = np.random.choice(n, na, replace=False)
        y = np.random.choice(n, na, replace=False)
        result[i] = Kolmogorov_Smirnov_Dist_p(comb[x], comb[y])

    pVal = np.sum(result > KSD) / nboots
    return pVal, KSD


def DTS_Dist_p(XX, YY):
    XX = _flatten_for_distance(XX)
    YY = _flatten_for_distance(YY)

    nx = len(XX)
    ny = len(YY)
    n = nx + ny

    XY = np.concatenate([XX, YY])
    X2 = np.concatenate([np.repeat(1 / nx, nx), np.repeat(0, ny)])
    Y2 = np.concatenate([np.repeat(0, nx), np.repeat(1 / ny, ny)])

    S_Ind = np.argsort(XY)
    XY_Sorted = XY[S_Ind]
    X2_Sorted = X2[S_Ind]
    Y2_Sorted = Y2[S_Ind]

    E_CDF = X2_Sorted[:-1].cumsum()
    F_CDF = Y2_Sorted[:-1].cumsum()
    G_CDF = np.arange(0, n - 1, 1) / n
    SD = np.sqrt(n * G_CDF * (1 - G_CDF))
    mask = SD > 0
    width = XY_Sorted[1:] - XY_Sorted[:-1]
    Res = (((np.abs(E_CDF[mask] - F_CDF[mask]) / SD[mask]) ** 1) * width[mask]).sum()

    return Res


def DTS_Dist_PVal(XX, YY, nboots=1000):
    XX = _flatten_for_distance(XX)
    YY = _flatten_for_distance(YY)

    DTS = DTS_Dist_p(XX, YY)
    na = len(XX)
    nb = len(YY)
    n = na + nb
    comb = np.concatenate([XX, YY])

    result = np.empty(nboots)
    for i in range(nboots):
        x = np.random.choice(n, na, replace=False)
        y = np.random.choice(n, na, replace=False)
        result[i] = DTS_Dist_p(comb[x], comb[y])

    pVal = np.sum(result > DTS) / nboots
    return pVal, DTS


__all__ = [
    'CVM_Dist_p',
    'CVM_Dist_PVal',
    'Wasserstein_Dist_p',
    'Wasserstein_Dist_PVal',
    'Anderson_Darling_Dist_p',
    'Anderson_Darling_Dist_PVal',
    'Kolmogorov_Smirnov_Dist_p',
    'Kolmogorov_Smirnov_Dist_PVal',
    'DTS_Dist_p',
    'DTS_Dist_PVal',
    'ES_Dist'
]
