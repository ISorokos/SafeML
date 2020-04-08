function K_Dist = Kuiper_Dist(XX,YY)
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

          E_CDF = 0;
          F_CDF = 0;
          power = 1;
          height = 0;
          UU = 0;  %Up
          DWN = 0; %Down
          PO = 1;  %Power

          for ii = 1:n-1
              E_CDF = E_CDF + X2_Sorted(ii);
              F_CDF = F_CDF + Y2_Sorted(ii);
              
              if SortedXY(ii+1) ~= SortedXY(ii)
                  height = F_CDF-E_CDF;
              end
              if height > UU
                  UU = height;
              end 
              if height < DWN
                  DWN = height;
              end
          end

          K_Dist_temp(jj) =  abs(DWN)^PO + abs(UU)^PO;  
    end
    K_Dist = max(K_Dist_temp);
end