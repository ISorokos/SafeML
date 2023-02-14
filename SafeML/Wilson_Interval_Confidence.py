# Kläs, M., & Sembach, L. (2019). Uncertainty wrappers for data-driven models. In International Conference on Computer Safety, Reliability, and Security. Springer.
from math import sqrt
def Wilson_Interval_Confidence(p, n, z = 3.29): # The z-score for a 95% confidence interval is 1.96.
    denominator = 1 + z**2/n
    centre_adjusted_probability = p + z*z / (2*n)
    adjusted_standard_deviation = sqrt((p*(1 - p) + z*z / (4*n)) / n)
    
    lower_bound = (centre_adjusted_probability - z*adjusted_standard_deviation) / denominator
    upper_bound = (centre_adjusted_probability + z*adjusted_standard_deviation) / denominator
    
    return (lower_bound, upper_bound)
