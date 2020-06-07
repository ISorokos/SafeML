function SI = Separability_Index(Selected_Data,Labels)
    %% Based on Following Paper
    % https://arxiv.org/ftp/arxiv/papers/2005/2005.13120.pdf
    % Data Separability for Neural Network Classifiers and the Development of a Separability Index

    LBs = double(unique(Labels));

    ClassNum = numel(unique(Labels));

    BCD_Val = BCD_Calc(Selected_Data, Labels);
    %%
    for ii = 1:ClassNum
        ICD_Val_temp(:,ii) = ICD_Calc(Selected_Data(find(Labels == LBs(ii)),:));
        D1(ii) = Kolmogorov_Smirnov_Dist(ICD_Val_temp(:,ii),BCD_Val);
        D2(ii) = Kuiper_Dist(ICD_Val_temp(:,ii),BCD_Val);
        D3(ii) = Wasserstein_Dist(ICD_Val_temp(:,ii),BCD_Val);
        D4(ii) = Wasserstein_Anderson_Darling_Dist(ICD_Val_temp(:,ii),BCD_Val,2);
        D5(ii) = Anderson_Darling_Dist(ICD_Val_temp(:,ii),BCD_Val);
        D6(ii) = Cramer_Von_Mises(ICD_Val_temp(:,ii),BCD_Val);
    end

    KSD = mean(D1)
    KD = mean(D2)
    WD = mean(D3)
    WAD = mean(D4)
    ADD = mean(D5)
    CVM = mean(D6)

    SI = WAD;
end

%% Functions

function BCD_Val = BCD_Calc(XX, Labels)
% 
    FeatureNum = size(XX,2);
    ClassNum = numel(unique(Labels));
    LBs = double(unique(Labels));
    dxy = 0;
    kk = 1;
    for ii = 1:ClassNum-1
        for jj = ii+1:ClassNum
            Tmp1 = XX(find(Labels == LBs(ii)),:);
            Tmp2 = XX(find(Labels == LBs(jj)),:);
            for xx = 1:FeatureNum 
                for yy = 1:FeatureNum
                    dxy(kk) = norm(Tmp1(:,xx)-Tmp2(:,yy),2);
                    kk = kk + 1;
                end
            end
        end      
    end
    BCD_Val = dxy;
end
% 
function ICD_Val = ICD_Calc(XX)

   FeatureNum = size(XX,2);
   dx = 0;
   kk = 1;
   for ii = 1:FeatureNum
       for jj = ii+1:FeatureNum
       dx(:,kk) = norm(XX(:,ii)-XX(:,jj),2);
       kk = kk + 1;
       end
   end
   ICD_Val = dx;  
end