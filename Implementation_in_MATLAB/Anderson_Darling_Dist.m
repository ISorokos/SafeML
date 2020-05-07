function AD_Dist = Anderson_Darling_Dist(XX,YY)

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

          Res = 0;
          E_CDF = 0;
          F_CDF = 0;
          G_CDF = 0;
          Power = 2;

          for ii = 1:n-1
              E_CDF = E_CDF + X2_Sorted(ii);
              F_CDF = F_CDF + Y2_Sorted(ii);
              G_CDF = G_CDF + (1/n);
              sd = (n*G_CDF*abs(1-G_CDF))^0.5;
              height = abs(F_CDF-E_CDF);
              if SortedXY(ii) ~= SortedXY(ii+1)
                  if sd > 0
                     Res = Res + (height/sd) ^ Power;  
                  end
              end
          end

          AD_Dist_temp(jj) = Res;  
    end
    AD_Dist = max(AD_Dist_temp);
end
