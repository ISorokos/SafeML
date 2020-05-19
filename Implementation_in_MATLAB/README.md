# Statistical/Probabilistic Distance Measure
<p align = "justify">Statistical/Probabilistic distance measure algorithms can be categorized into two main categories: I) Cumulative Distribution Function (CDF)-based and II) Probability Density Function (PDF)-based. The following algorithms have been used in this project.</p>

<p align="center">
 <img src="https://github.com/ISorokos/SafeML/blob/master/Implementation_in_MATLAB/Figures/CDF_Distance_Measures.png" alt="CDF_Distance_Measures">
 <figcaption>Figure 1. Some of the Well-known Cumulative Distribution Function (CDF)-based Distance Measures</figcaption>
</p>

<p align="center">
 <img src="https://github.com/ISorokos/SafeML/blob/master/Implementation_in_MATLAB/Figures/pdf_Distance_Measures.png" alt="pdf_Distance_Measures">
 <figcaption>Figure 2. Some of the Well-known Probability Density Function (PDF)-based Distance Measures</figcaption>
</p>

# Implemented Functions

## Wasserstein Distance
Simple example for Wasserstein distance measure function in MATLAB:

<pre>X = normrnd(1,1,[100,1]);
Y = normrnd(1,1.1,[100,1]);
WS_Dist = Wasserstein_Dist(X,Y)</pre>

## Anderson-Darling Distance
Simple example for Anderson-Darling distance measure function in MATLAB:

<pre>X = normrnd(1,1,[100,1]);
Y = normrnd(1,1.1,[100,1]);
AD_Dist = Anderson_Darling_Dist(X,Y)</pre>

## Kolmogorov Smirnov Distance
Simple example for Kolmogorov Smirnov distance measure function in MATLAB:

<pre>X = normrnd(1,1,[100,1]);
Y = normrnd(1,1.1,[100,1]);
AD_Dist = Kolmogorov_Smirnov_Dist(X,Y)</pre>

# MATLAB Toolbox Requirement
    {'MATLAB'                                 }
    {'System Identification Toolbox'          }
    {'Statistics and Machine Learning Toolbox'}
    {'Bioinformatics Toolbox'                 }
