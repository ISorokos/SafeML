function KS_Dist = Kolmogorov_Smirnov_Dist_PN(XX,YY)
% XX = normrnd(1,1,[100,1]);
% YY = normrnd(1,1.1,[100,1]);
    YY(~any(~isnan(YY), 2),:)=[];
    XX(~any(~isnan(XX), 2),:)=[];
    for jj = 1:size(XX,2)
          X = XX(:,jj);
          Y = YY(:,jj);
          nx = length(X);
          ny = length(Y);
          n = nx + ny;

          XY = [X;Y];
          X2 = [(1/nx).*ones(nx,1);zeros(ny,1)];
          Y2 = [zeros(nx,1);(1/ny).*ones(ny,1)];

          [SortedXY ,I] = sort(XY);
          X2_Sorted = X2(I);
          Y2_Sorted = Y2(I);

          ResP = 0;
          ResN = 0;
          E_CDF = 0;
          F_CDF = 0;
          power = 1;
          height = 0;

          for ii = 1:n-1
              E_CDF = E_CDF + X2_Sorted(ii);
              F_CDF = F_CDF + Y2_Sorted(ii);
              
              if SortedXY(ii+1) ~= SortedXY(ii)
                  height = (F_CDF-E_CDF);
              end
              if height > ResP
                  ResP = height;
              end
              if height < ResN
                  ResN = height;
              end
          end
          [~, I] = max([ResP, abs(ResN)]);
          if I == 1
             KS_Dist_temp(jj) = ResP;  
          elseif I == 2
             KS_Dist_temp(jj) = ResN;  
          end
    end
    KS_Dist = (KS_Dist_temp);
end