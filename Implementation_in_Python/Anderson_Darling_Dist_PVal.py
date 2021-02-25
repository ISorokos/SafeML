def Anderson_Darling_Dist(XX, YY):
  
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

    Res = 0
    E_CDF = 0
    F_CDF = 0
    G_CDF = 0
    height = 0
    SD = 0
    power = 1

    for ii in range(0, n-2):
        E_CDF = E_CDF + X2_Sorted[ii]
        F_CDF = F_CDF + Y2_Sorted[ii]
        G_CDF = G_CDF + 1/n
        SD = (n * G_CDF * (1-G_CDF))**0.5
        height = abs(F_CDF - E_CDF)
        if XY_Sorted[ii+1] != XY_Sorted[ii]: 
            if SD>0: 
            Res = Res + (height/SD)**power

    AD_Dist = Res
    
    return AD_Dist

def  Anderson_Darling_Dist_PVal(XX, YY):
    # Information about Bootstrap Method: 
    # https://towardsdatascience.com/an-introduction-to-the-bootstrap-method-58bcb51b4d60
    import random
    nboots = 1000
    AD = Anderson_Darling_Dist(XX,YY)
    na = len(XX)
    nb = len(YY)
    n = na + nb
    comb = np.concatenate([XX,YY])
    reps = 0
    bigger = 0
    for ii in range(1, nboots):
        e = random.sample(range(n), na)
        f = random.sample(range(n), nb)
        boost_AD = Anderson_Darling_Dist(comb[e],comb[f]);
        if (boost_AD > AD):
            bigger = 1 + bigger
            
    pVal = bigger/nboots;

    return pVal, AD
