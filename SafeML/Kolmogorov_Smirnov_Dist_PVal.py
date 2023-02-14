def Kolmogorov_Smirnov_Dist(XX, YY):
  
    import numpy as np
    nx = len(XX)
    ny = len(YY)
    n = nx + ny

    XY = np.concatenate([XX,YY])
    X2 = np.concatenate([np.repeat(1/nx, nx), np.repeat(0, ny)])
    Y2 = np.concatenate([np.repeat(0, nx), np.repeat(1/ny, ny)])

    S_Ind = np.argsort(XY)
    XY_Sorted = XY[S_Ind]
    X2_Sorted = X2[S_Ind]
    Y2_Sorted = Y2[S_Ind]

    Res = 0;
    height = 0;
    E_CDF = 0;
    F_CDF = 0;
    power = 1;

    for ii in range(0, n-2):
        E_CDF = E_CDF + X2_Sorted[ii]
        F_CDF = F_CDF + Y2_Sorted[ii]
        if XY_Sorted[ii+1] != XY_Sorted[ii]: height = abs(F_CDF-E_CDF)
        if height > Res: Res = height

    KS_Dist = Res**power
    
    return KS_Dist
  
def  Kolmogorov_Smirnov_Dist_PVal(XX, YY):
    # Information about Bootstrap Method: 
    # https://towardsdatascience.com/an-introduction-to-the-bootstrap-method-58bcb51b4d60
    import random
    nboots = 1000
    KSD = Kolmogorov_Smirnov_Dist(XX,YY)
    na = len(XX)
    nb = len(YY)
    n = na + nb
    comb = np.concatenate([XX,YY])
    reps = 0
    bigger = 0
    for ii in range(1, nboots):
        e = random.sample(range(n), na)
        f = random.sample(range(n), nb)
        boost_KSD = Kolmogorov_Smirnov_Dist(comb[e],comb[f]);
        if (boost_KSD > KSD):
            bigger = 1 + bigger
            
    pVal = bigger/nboots;

    return pVal, KSD
