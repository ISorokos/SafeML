% TODO: Provide formula and reference
function Dist = Chern_off_Dist(D2,D1) % @Koorosh: Why are the inputs reversed ?
    %alpha = 0.5; %% Locking alpha to 0.5 effectively uses the Bhattacharrya measure instead
    D1(~any(~isnan(D1), 2),:)=[]; % @Koorosh: Remove NaN from D1 ?
    D2(~any(~isnan(D2), 2),:)=[]; % @Koorosh: Remove NaN from D2 ?
    mean1 = mean(D1);
    mean2 = mean(D2);
    cov1 = cov(D1);
    cov2 = cov(D2);
    mean_diff = mean2 - mean1;
    var_avg = (cov1 + cov2) * 0.5;
    ln_coeff = 0.5 * log(det(var_avg) / sqrt(det(cov1) * det(cov2)));
    dist2 = 0.125 * (mean_diff * inv(var_avg)) * mean_diff' + ln_coeff;
    Dist = 1 - exp(-dist2);
end
