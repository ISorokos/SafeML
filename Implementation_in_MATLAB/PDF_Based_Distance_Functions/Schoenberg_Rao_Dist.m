function SR_Dist = Schoenberg_Rao_Dist(mu1, sig1, mu2, sig2)
% Ref: Schoenberg-Rao distances: Entropy-based and geometry-aware statistical Hilbert distances
     SR_Dist = ((mu2 - mu1) * erf((mu2 - mu1) / sqrt(2*(sig1^2 + sig2^2))) + ...
                 sqrt(2 / pi) * sqrt(sig1 ^ 2 + sig2 ^ 2) * ...
                 exp(- 1 / 2 * (mu1 - mu2) ^ 2 / (sig1 ^ 2 + sig2 ^ 2))) ....
                 - (sig1 + sig2) / sqrt(pi);

end


    

