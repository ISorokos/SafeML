function CVM_Dist = Cramer_Von_Mises(XX,YY)

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
          power = 2;
          height = 0;

          for ii = 1:n-1
              
              E_CDF = E_CDF + X2_Sorted(ii);
              F_CDF = F_CDF + Y2_Sorted(ii);
              height = abs(F_CDF-E_CDF);
              
              if SortedXY(ii+1) ~= SortedXY(ii)
                  Res = Res + height ^ power
              end 
          end

          CVM_Dist_temp(jj) = Res;  
    end
    CVM_Dist = max(CVM_Dist_temp);
end
