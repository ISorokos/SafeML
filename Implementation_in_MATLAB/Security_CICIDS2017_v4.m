%% Initial Section
clearvars
close all
clc

%% Parameters

% Reduced Dimension After Using PCA
Reduced_Dim = 3;
% Maximum Number Permutation
PermNum = 100;

%% Read CSV Files
% The Dataset can be downloaded from: https://www.unb.ca/cic/datasets/ids-2017.html
% Dataset Zip file should be extracted and then its CSV files should be
% moved to the same folder of the code

FileNames = {'Tuesday-WorkingHours.pcap_ISCX.csv','Wednesday-workingHours.pcap_ISCX.csv',...
             'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv','Thursday-WorkingHours-Afternoon-Infilteration.pcap_ISCX.csv',...
             'Friday-WorkingHours-Morning.pcap_ISCX.csv','Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv',...
             'Friday-WorkingHours-Afternoon-PortScan.pcap_ISCX.csv'};
      
opts = delimitedTextImportOptions("NumVariables", 79);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["DestinationPort", "FlowDuration", "TotalFwdPackets", "TotalBackwardPackets", "TotalLengthofFwdPackets", "TotalLengthofBwdPackets", "FwdPacketLengthMax", "FwdPacketLengthMin", "FwdPacketLengthMean", "FwdPacketLengthStd", "BwdPacketLengthMax", "BwdPacketLengthMin", "BwdPacketLengthMean", "BwdPacketLengthStd", "FlowBytess", "FlowPacketss", "FlowIATMean", "FlowIATStd", "FlowIATMax", "FlowIATMin", "FwdIATTotal", "FwdIATMean", "FwdIATStd", "FwdIATMax", "FwdIATMin", "BwdIATTotal", "BwdIATMean", "BwdIATStd", "BwdIATMax", "BwdIATMin", "FwdPSHFlags", "BwdPSHFlags", "FwdURGFlags", "BwdURGFlags", "FwdHeaderLength", "BwdHeaderLength", "FwdPacketss", "BwdPacketss", "MinPacketLength", "MaxPacketLength", "PacketLengthMean", "PacketLengthStd", "PacketLengthVariance", "FINFlagCount", "SYNFlagCount", "RSTFlagCount", "PSHFlagCount", "ACKFlagCount", "URGFlagCount", "CWEFlagCount", "ECEFlagCount", "DownUpRatio", "AveragePacketSize", "AvgFwdSegmentSize", "AvgBwdSegmentSize", "FwdHeaderLength1", "FwdAvgBytesBulk", "FwdAvgPacketsBulk", "FwdAvgBulkRate", "BwdAvgBytesBulk", "BwdAvgPacketsBulk", "BwdAvgBulkRate", "SubflowFwdPackets", "SubflowFwdBytes", "SubflowBwdPackets", "SubflowBwdBytes", "Init_Win_bytes_forward", "Init_Win_bytes_backward", "act_data_pkt_fwd", "min_seg_size_forward", "ActiveMean", "ActiveStd", "ActiveMax", "ActiveMin", "IdleMean", "IdleStd", "IdleMax", "IdleMin", "Label"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "categorical"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Label", "EmptyFieldRule", "auto");
opts = setvaropts(opts, ["DestinationPort", "FlowDuration", "TotalFwdPackets", "TotalBackwardPackets", "TotalLengthofFwdPackets", "TotalLengthofBwdPackets", "FwdPacketLengthMax", "FwdPacketLengthMin", "FwdPacketLengthMean", "FwdPacketLengthStd", "BwdPacketLengthMax", "BwdPacketLengthMin", "BwdPacketLengthMean", "BwdPacketLengthStd", "FlowBytess", "FlowPacketss", "FlowIATMean", "FlowIATStd", "FlowIATMax", "FlowIATMin", "FwdIATTotal", "FwdIATMean", "FwdIATStd", "FwdIATMax", "FwdIATMin", "BwdIATTotal", "BwdIATMean", "BwdIATStd", "BwdIATMax", "BwdIATMin", "FwdPSHFlags", "BwdPSHFlags", "FwdURGFlags", "BwdURGFlags", "FwdHeaderLength", "BwdHeaderLength", "FwdPacketss", "BwdPacketss", "MinPacketLength", "MaxPacketLength", "PacketLengthMean", "PacketLengthStd", "PacketLengthVariance", "FINFlagCount", "SYNFlagCount", "RSTFlagCount", "PSHFlagCount", "ACKFlagCount", "URGFlagCount", "CWEFlagCount", "ECEFlagCount", "DownUpRatio", "AveragePacketSize", "AvgFwdSegmentSize", "AvgBwdSegmentSize", "FwdHeaderLength1", "FwdAvgBytesBulk", "FwdAvgPacketsBulk", "FwdAvgBulkRate", "BwdAvgBytesBulk", "BwdAvgPacketsBulk", "BwdAvgBulkRate", "SubflowFwdPackets", "SubflowFwdBytes", "SubflowBwdPackets", "SubflowBwdBytes", "Init_Win_bytes_forward", "Init_Win_bytes_backward", "act_data_pkt_fwd", "min_seg_size_forward", "ActiveMean", "ActiveStd", "ActiveMax", "ActiveMin", "IdleMean", "IdleStd", "IdleMax", "IdleMin"], "FillValue", 0);

% Import the data
% Tuesday = readtable(FileNames{1}, opts);
% Wednesday = readtable(FileNames{2}, opts);
% ThursdayM = readtable(FileNames{3}, opts); % M for Morning
% ThursdayA = readtable(FileNames{4}, opts); % A for Afternoon
% FridayM   = readtable(FileNames{5}, opts);
% Friday_A1 = readtable(FileNames{6}, opts);
% Friday_A2 = readtable(FileNames{7}, opts);

DayNum = 3; % Select A Day based on Above Numbers
Selected_Data = readtable(FileNames{DayNum}, opts);

clear opts
%% D-reduction using PCA
[coeff, score] = pca(Selected_Data{:,1:end-1});
T_RD = score(:,1:Reduced_Dim);
Selected_Data_RD = cat(2,table(T_RD),table(Selected_Data{:,end}));
%% Main Loop
for kk = 1:PermNum
    
    % Data Partitioning
    Ind = crossvalind('HoldOut',Selected_Data_RD{:,end},0.8);
    
    % Train Data
    XTrain = Selected_Data_RD{find(Ind == 0), 1:end-1};
    YTrain = categorical(Selected_Data_RD{find(Ind == 0), end});

    % Test Data
    XTest = Selected_Data_RD{find(Ind == 1), 1:end-1};
    YTest = categorical(Selected_Data_RD{find(Ind == 1), end});

    % Labels
    LBs = categories(YTrain);
    
    % Type of Classifiers
    classifier_name = {'Naive Bayes','Discriminant Analysis','Classification Tree','Nearest Neighbor'};

    classifier{1} = fitcnb(XTrain,YTrain);
    classifier{2} = fitcdiscr(XTrain,YTrain);
    classifier{3} = fitctree(XTrain,YTrain);
    classifier{4} = fitcknn(XTrain,YTrain);
    %%
    
    % Labels
    Labels = unique(Selected_Data_RD{:,end});

    for ii = 4:numel(classifier)

        yfit = predict(classifier{ii},XTest);
        S = figure(20+ii);
        set(S,'color','w');
        confusionchart(YTest,yfit);
        title(classifier_name{ii});
        % Number of Classes
        ClassNum = size(unique(Selected_Data_RD{:,end}),1);

        for jj = 1:ClassNum

            XTrain_L = XTrain(find(YTrain == Labels(jj)),:);
            XTest_L  = XTest(find(yfit == Labels(jj)),:);

            Results(jj, 1, kk) = Acc_Check2(YTest,yfit,jj);

            Results(jj, 2, kk) = Chern_off_Dist(XTrain_L,XTest_L);

            Results(jj, 3, kk) = Kolmogorov_Smirnov_Dist(XTrain_L,XTest_L);

            Results(jj, 4, kk) = Kuiper_Dist(XTrain_L,XTest_L);

            Results(jj, 5, kk) = Anderson_Darling_Dist(XTrain_L,XTest_L);

            Results(jj, 6, kk) = Wasserstein_Dist(XTrain_L,XTest_L);

            Results(jj, 7, kk) = Wasserstein_Anderson_Darling_Dist(XTrain_L,XTest_L,2);
               
        end
        Plots_Acc_Dist2(Results(:,:,kk), ii);
        temp = Results(:,:,kk);
        [B, I] = sort(temp(:,1));
        SResults(:,:,kk) = temp(I,:);  
    end

end
%%
BoxPlot_Acc_Dist(SResults, 100 + DayNum, ClassNum)

%% functions

% For Accuracy Measure of Each Class
function Acc_1 = Acc_Check2(YTest,yfit, jj)
C_Mat = confusionmat(YTest,yfit);
Acc_1 = C_Mat(jj,jj)/sum(C_Mat(jj,:));
end

% For Simple Plots
function Plots_Acc_Dist2(Results, FigNum)
    [B, I] = sort(Results(:,1));
    SResults = Results(I,:);   
    
    Methods = {'\fontsize{16}Chernoff','\fontsize{16}Kolmogorov-Smirnov','\fontsize{16}Kuiper','\fontsize{16}Anderson-Darling','\fontsize{16}Wasserstein','\fontsize{16}WAD'};

    S = figure(FigNum);
    set(S,'color','w');
    set(S, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    subplot(321)
    for ii = 1:size(Results,2)-1
        subplot(3,2,ii)
        plot(SResults(:,1), SResults(:,ii+1), '-')
        title(Methods{ii})
        xlabel('\fontsize{16}Accuracy')
        ylabel('\fontsize{16}Distance')
        hold on
        plot(SResults(:,1), SResults(:,ii+1), '*r')
        hold off
    end
end

% For Box Plots 
function BoxPlot_Acc_Dist(SResults, FigNum, ClassNum)

    rng('default')  % For reproducibility

    Methods = {'\fontsize{16}Chernoff','\fontsize{16}Kolmogorov-Smirnov','\fontsize{16}Kuiper','\fontsize{16}Anderson-Darling','\fontsize{16}Wasserstein','\fontsize{16}WAD'};

    S = figure(FigNum);
    set(S,'color','w');
    set(S, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    subplot(321)
    for ii = 1:6
        subplot(3,2,ii)
        [x, g] = Reshape_for_BoxPlot(SResults, ii+1, ClassNum);
        boxplot(x,g)
        title(Methods{ii})
        xlabel('\fontsize{16}Mean Accuracy (100 Permutation)')
        ylabel('\fontsize{16}Distance')
        xtickangle(45)
    end
end

% For Preprocessing Data Befor Box Plot 
function [x, g] = Reshape_for_BoxPlot(SResults, DNum, ClassNum)

    rng('default')  % For reproducibility
    SResults = real(SResults);
    
    x = zeros(size(SResults, 3), ClassNum);
    g = {};
    
    for ii = 1:ClassNum
        x(:,ii) = reshape(SResults(ii,DNum,:),[size(SResults, 3),1]); 

        g = cat(1,g,repmat({['Mu =', num2str(mean(reshape(SResults(ii,1,:),[size(SResults, 3),1])))]},size(SResults, 3),1));
    end
    
end
