%% Initial Section
clearvars
close all
clc

%% Parameters

% Reduced Dimension After Using PCA
Reduced_Dim = 3;
%% Read CSV Files
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
Tuesday = readtable(FileNames{1}, opts);
Wednesday = readtable(FileNames{2}, opts);
ThursdayM = readtable(FileNames{3}, opts); % M for Morning
ThursdayA = readtable(FileNames{4}, opts); % A for Afternoon
FridayM   = readtable(FileNames{5}, opts);
Friday_A1 = readtable(FileNames{6}, opts);
Friday_A2 = readtable(FileNames{7}, opts);

clear opts
%% D-reduction using PCA
[coeff, score] = pca(Wednesday{:,1:end-1});
T_RD = score(:,1:Reduced_Dim);
Wednesday_RD = cat(2,table(T_RD),table(Wednesday{:,end}));
%%
S = figure(1);
set(S,'color','w');
Col = {'b','r','c','m','g','k'};
LBs = double(Wednesday.Label);

BB = Wednesday_RD{1:10000,1:end-1};

% Needed Variables for the Loop
W_D = 0;
KS_D = 0;
AD_D = 0;
WAD_D = 0;
K_D = 0;
DTS_D = 0;
% Sliding Window Size
d = 1500;

for ii = 1:d:size(Wednesday,1)-(d+1)
    temp = Wednesday_RD{ii:ii+d-1,1:end-1};
    
    KS_dist = Kolmogorov_Smirnov_Dist(BB,temp);
    KS_D(ii:ii+d-1) = KS_dist.*ones(1,d);    
    
    K_dist = Kuiper_Dist(BB,temp);
    K_D(ii:ii+d-1) = K_dist.*ones(1,d);   
    
    AD_dist = Anderson_Darling_Dist(BB,temp);
    AD_D(ii:ii+d-1) = AD_dist.*ones(1,d);
    
    W_dist = Wasserstein_Dist(BB,temp);
    W_D(ii:ii+d-1) = W_dist.*ones(1,d);
    
    WAD_dist = Wasserstein_Anderson_Darling_Dist(BB,temp,2);
    WAD_D(ii:ii+d-1) = WAD_dist.*ones(1,d);
end

subplot(611)
plot(1:size(W_D,2), LBs(1:size(W_D,2)),'b','LineWidth', 1.5);
% title('Wednesday')
colormap jet
xlabel('Time (Sec.)')
ylabel('Class')

subplot(612)
plot(1:size(KS_D,2), KS_D, 'r','LineWidth', 1.5);
xlabel('Time (Sec.)')
ylabel('KSD')

subplot(613)
plot(1:size(K_D,2), K_D, 'm','LineWidth', 1.5);
xlabel('Time (Sec.)')
ylabel('Kuiper')

subplot(614)
plot(1:size(AD_D,2), AD_D, '-.b','LineWidth', 1.5);
xlabel('Time (Sec.)')
ylabel('ADD')

subplot(615)
plot(1:size(W_D,2), W_D, '-.r','LineWidth', 1.5);
xlabel('Time (Sec.)')
ylabel('WD')

subplot(616)
plot(1:size(WAD_D,2), WAD_D, '-.m','LineWidth', 1.5);
xlabel('Time (Sec.)')
ylabel('WAD')
%%
LB2 = LBs(1:size(W_D,2));
LB2 = LB2';

%% Merge All Vector to one Matrix
Data = [LB2;
        KS_D;
        K_D;
        AD_D;
        W_D;
        WAD_D];
    
format long

% Calculate Pearson's Correlation and P-Values
[rho,pval] = corr(Data');   

% Heatmap Plot of Correlation Values
S = figure(2);
set(S,'color','w');
xvalues = {'ClassNum','KSD','KD','ADD','WD','WAD'};
yvalues = {'ClassNum','KSD','KD','ADD','WD','WAD'};
heatmap(xvalues,yvalues,rho)
colormap jet

% Heatmap Plot of p-Values
S = figure(3);
set(S,'color','w');
xvalues = {'ClassNum','KSD','KD','ADD','WD','WAD'};
yvalues = {'ClassNum','KSD','KD','ADD','WD','WAD'};
heatmap(xvalues,yvalues,pval)
