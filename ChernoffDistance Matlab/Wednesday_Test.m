%% Initial Section
clearvars
close all
clc

%% Parameters
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
%% BENIGN
% load('Wednesday_Model_PCA.mat');
[coeff, score] = pca(Wednesday{:,1:end-1});
T_RD = score(:,1:Reduced_Dim);
Wednesday_RD = cat(2,table(T_RD),table(Wednesday{:,end}));

[Wednesday_Model_PCA_3D, validationAccuracy] = trainClassifier(Wednesday_RD);

Wednesday_RD_BENIGN = Wednesday_RD(find(Wednesday_RD{:,end} == 'BENIGN'),:);

Acc_Wednesday_RD_BENIGN = Acc_Check(Wednesday_RD_BENIGN,Wednesday_Model_PCA_3D)

Dist_Wednesday_RD_BENIGN = Chern_off_Dist(Wednesday_RD_BENIGN{:,1:end-1},Wednesday_RD_BENIGN{:,1:end-1})

%% DoS GoldenEye
Wednesday_RD_Dos_GoldenEye = Wednesday_RD(find(Wednesday_RD{:,end} == 'DoS GoldenEye'),:);

Acc_Wednesday_RD_Dos_GoldenEye = Acc_Check(Wednesday_RD_Dos_GoldenEye,Wednesday_Model_PCA_3D)

Dist_Wednesday_RD_Dos_GoldenEye = Chern_off_Dist(Wednesday_RD_BENIGN{:,1:end-1},Wednesday_RD_Dos_GoldenEye{:,1:end-1})

%% DoS Hulk
Wednesday_RD_DoS_Hulk = Wednesday_RD(find(Wednesday_RD{:,end} == 'DoS Hulk'),:);

Acc_Wednesday_RD_DoS_Hulk = Acc_Check(Wednesday_RD_DoS_Hulk,Wednesday_Model_PCA_3D)

Dist_Wednesday_RD_DoS_Hulk = Chern_off_Dist(Wednesday_RD_BENIGN{:,1:end-1},Wednesday_RD_DoS_Hulk{:,1:end-1})
%% DoS Slowhttptest 
Wednesday_RD_Dos_Slowhttptest = Wednesday_RD(find(Wednesday_RD{:,end} == 'DoS Slowhttptest'),:);

Acc_Wednesday_RD_Dos_Slowhttptest = Acc_Check(Wednesday_RD_Dos_Slowhttptest,Wednesday_Model_PCA_3D)

Dist_Wednesday_RD_Dos_Slowhttptest = Chern_off_Dist(Wednesday_RD_BENIGN{:,1:end-1},Wednesday_RD_Dos_Slowhttptest{:,1:end-1})
%% DoS slowloris 
Wednesday_RD_Dos_slowloris  = Wednesday_RD(find(Wednesday_RD{:,end} == 'DoS slowloris '),:);

Acc_Wednesday_RD_Dos_slowloris  = Acc_Check(Wednesday_RD_Dos_slowloris,Wednesday_Model_PCA_3D)

Dist_Wednesday_RD_Dos_slowloris  = Chern_off_Dist(Wednesday_RD_BENIGN{:,1:end-1},Wednesday_RD_Dos_slowloris{:,1:end-1})
%% Heartbleed 
Wednesday_RD_Heartbleed = Wednesday_RD(find(Wednesday_RD{:,end} == 'Heartbleed'),:);

Acc_Wednesday_RD_Heartbleed = Acc_Check(Wednesday_RD_Heartbleed,Wednesday_Model_PCA_3D)

Dist_Wednesday_RD_Heartbleed = Chern_off_Dist(Wednesday_RD_BENIGN{:,1:end-1},Wednesday_RD_Heartbleed{:,1:end-1})
%%
Results = [Acc_Wednesday_RD_BENIGN,          Dist_Wednesday_RD_BENIGN
           Acc_Wednesday_RD_Dos_GoldenEye,   Dist_Wednesday_RD_Dos_GoldenEye
           Acc_Wednesday_RD_DoS_Hulk,        Dist_Wednesday_RD_DoS_Hulk 
           Acc_Wednesday_RD_Dos_Slowhttptest,Dist_Wednesday_RD_Dos_Slowhttptest 
           Acc_Wednesday_RD_Dos_slowloris,   Dist_Wednesday_RD_Dos_slowloris
           Acc_Wednesday_RD_Heartbleed,      Dist_Wednesday_RD_Heartbleed];
figure(1)
plot(SResults(:,1), SResults(:,2), '-')
xlabel('Accuracy')
ylabel('P_{error}')
hold on
plot(SResults(:,1), SResults(:,2), '*r')
hold off

figure(2)
SResults = sort(Results,1)
bar(SResults(:,1), SResults(:,2))
xlabel('Accuracy')
ylabel('P_{error}')

%%
function Acc = Acc_Check(Data,Wednesday_Model_PCA_3D)
% load('Wednesday_Model_PCA.mat');
yfit = Wednesday_Model_PCA_3D.predictFcn(Data);

correctPredictions = (Data{:,end} == yfit);
isMissing = ismissing(yfit);
correctPredictions = correctPredictions(~isMissing);
Acc = sum(correctPredictions)/length(correctPredictions);
end
function Dist = Chern_off_Dist(D2,D1)

    D1(~any(~isnan(D1), 2),:)=[];
    D2(~any(~isnan(D2), 2),:)=[];
    mean1 = mean(D1);
    mean2 = mean(D2);
    cov1 = cov(D1);
    cov2 = cov(D2);
    mean_diff = mean2 - mean1;
    var_avg = (cov1 + cov2) * 0.5;
    ln_coeff = 0.5 * log(det(var_avg) / sqrt(det(cov1) * det(cov2)));
    dist2 = 0.125 *(mean_diff*inv(var_avg))*mean_diff' + ln_coeff;
    Dist = 1 - exp(-dist2);
end

function [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)

inputTable = trainingData;
% Split matrices in the input table into vectors
inputTable.T_RD_1 = inputTable.T_RD(:,1);
inputTable.T_RD_2 = inputTable.T_RD(:,2);
inputTable.T_RD_3 = inputTable.T_RD(:,3);

predictorNames = {'T_RD_1', 'T_RD_2', 'T_RD_3'};
predictors = inputTable(:, predictorNames);
response = inputTable.Var1;
isCategoricalPredictor = [false, false, false];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationTree = fitctree(...
    predictors, ...
    response, ...
    'SplitCriterion', 'gdi', ...
    'MaxNumSplits', 100, ...
    'Surrogate', 'off', ...
    'ClassNames', categorical({'BENIGN'; 'DoS GoldenEye'; 'DoS Hulk'; 'DoS Slowhttptest'; 'DoS slowloris'; 'Heartbleed'}));

% Create the result struct with predict function
splitMatricesInTableFcn = @(t) [t(:,setdiff(t.Properties.VariableNames, {'T_RD'})), array2table(table2array(t(:,{'T_RD'})), 'VariableNames', {'T_RD_1', 'T_RD_2', 'T_RD_3'})];
extractPredictorsFromTableFcn = @(t) t(:, predictorNames);
predictorExtractionFcn = @(x) extractPredictorsFromTableFcn(splitMatricesInTableFcn(x));
treePredictFcn = @(x) predict(classificationTree, x);
trainedClassifier.predictFcn = @(x) treePredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'T_RD'};
trainedClassifier.ClassificationTree = classificationTree;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2019b.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
% Split matrices in the input table into vectors
inputTable.T_RD_1 = inputTable.T_RD(:,1);
inputTable.T_RD_2 = inputTable.T_RD(:,2);
inputTable.T_RD_3 = inputTable.T_RD(:,3);

predictorNames = {'T_RD_1', 'T_RD_2', 'T_RD_3'};
predictors = inputTable(:, predictorNames);
response = inputTable.Var1;
isCategoricalPredictor = [false, false, false];

% Set up holdout validation
cvp = cvpartition(response, 'Holdout', 0.3);
trainingPredictors = predictors(cvp.training, :);
trainingResponse = response(cvp.training, :);
trainingIsCategoricalPredictor = isCategoricalPredictor;

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationTree = fitctree(...
    trainingPredictors, ...
    trainingResponse, ...
    'SplitCriterion', 'gdi', ...
    'MaxNumSplits', 100, ...
    'Surrogate', 'off', ...
    'ClassNames', categorical({'BENIGN'; 'DoS GoldenEye'; 'DoS Hulk'; 'DoS Slowhttptest'; 'DoS slowloris'; 'Heartbleed'}));

% Create the result struct with predict function
treePredictFcn = @(x) predict(classificationTree, x);
validationPredictFcn = @(x) treePredictFcn(x);

% Add additional fields to the result struct


% Compute validation predictions
validationPredictors = predictors(cvp.test, :);
validationResponse = response(cvp.test, :);
[validationPredictions, validationScores] = validationPredictFcn(validationPredictors);

% Compute validation accuracy
correctPredictions = (validationPredictions == validationResponse);
isMissing = ismissing(validationResponse);
correctPredictions = correctPredictions(~isMissing);
validationAccuracy = sum(correctPredictions)/length(correctPredictions);
end