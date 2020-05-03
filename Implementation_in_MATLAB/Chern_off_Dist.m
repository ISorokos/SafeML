% @return Dist : the distance between two probability density functions D1 and D2
% From: (Listing 3.149 and 3.150) in Page 98 - Fukunaga, K. (1992). Introduction to Statistical Pattern Recognition (Second Edition). Academic Press.
function Dist = Chern_off_Dist(D1, D2)
    % Listing 3.150 of reference
    %alpha = 0.5; %% Locking alpha to 0.5 effectively uses the Bhattacharrya measure instead
    D1(~any(~isnan(D1), 2),:)=[]; % Remove NaN from D1 
    D2(~any(~isnan(D2), 2),:)=[]; % Remove NaN from D2
    mean1 = mean(D1);
    mean2 = mean(D2);
    cov1 = cov(D1);
    cov2 = cov(D2);
    mean_diff = mean2 - mean1;
    var_avg = (cov1 + cov2) * 0.5;
    ln_coeff = 0.5 * log(det(var_avg) / sqrt(det(cov1) * det(cov2)));
    dist2 = 0.125 * (mean_diff * inv(var_avg)) * mean_diff' + ln_coeff;
    Dist = 1 - exp(-dist2); % Listing 3.149 of reference, taking the complement of the upper bound of the Bayes error
end
