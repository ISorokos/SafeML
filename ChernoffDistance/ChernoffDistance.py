import math
import numpy.linalg

def chernoff_distance(s, means, variances, univariate = False):
    """ Returns the Chernoff Distance, as defined in (3.150), p.98 of 
        Fukunaga, 1990, Introduction to Statistical Pattern Recognition, 2nd Edition
    """

    from math import log
    from math import sqrt
    from math import pow
    
    from numpy.linalg import det
    from numpy import transpose
    from numpy.linalg import inv
    from numpy import array

    if univariate:
        part1 = 0.25 * log(0.25 * (variances[0] / variances[1] + variances[1] / variances[0]) + 0.5)
        part2 = 0.25 * pow(means[0] - means[1], 2) / (variances[0] + variances[1])
        return part1 + part2

    mean_diff = array(means[0]) - array(means[1])
    var_avg = (array(variances[0]) + array(variances[1])) * 0.5
    ln_coeff = 0.5 * log(det(var_avg) / sqrt(det(array(variances[0])) * det(array(variances[1]))))

    #return 0.125 * transpose(mean_diff) * inv(var_avg) * mean_diff + ln_coeff
     return 0.125 * np.matmul(np.matmul(mean_diff.T, inv(var_avg)), mean_diff) + ln_coeff 
    

if __name__ == '__main__':
    #import doctest
    #doctest.testmod()

    mean1 = (1, 2)
    cov1 = [[1, 0], [0, 1]]
    mean2 = (3, 4)
    cov2 = [[2, 0], [0, 2]]

    s = 0.5

    distance = chernoff_distance(s, [mean1, mean2], [cov1, cov2])

    print('chernoff_distance(', end='')
    print(s, str([mean1, mean2]), str([cov1, cov2]), end='')
    print('):')
    print(distance)

    from numpy import exp
    print('Error', exp(-distance))

    distance2 = chernoff_distance(s, [mean1, mean1], [cov1, cov1])

    print('chernoff_distance(', end='')
    print(s, str([mean1, mean1]), str([cov1, cov1]), end='')
    print('):')
    print(distance2)

    from numpy import exp
    print('Error', exp(-distance2))
