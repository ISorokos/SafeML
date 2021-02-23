close all
clearvars
clc

format long
%% Generating XOR Data
% number of samples of each class
% K = 3000;
% % define classes
% q = 0.50; % offset of classes
% A = [rand(1,K)-q; rand(1,K)+q];
% B = [rand(1,K)+q; rand(1,K)+q];
% C = [rand(1,K)+q; rand(1,K)-q];
% D = [rand(1,K)-q; rand(1,K)-q];

load('XOR_data.mat')
% plot classes
    
    S = figure(1);
    set(S,'color','w');
plot(A(1,:),A(2,:),'bs')
hold on
grid on
plot(B(1,:),B(2,:),'r+')
plot(C(1,:),C(2,:),'bs')
plot(D(1,:),D(2,:),'r+')
% text labels for classes
% text(.5-q,.5+2*q,'Class A')
% text(.5+q,.5+2*q,'Class B')
% text(.5+q,.5-2*q,'Class C')
% text(.5-q,.5-2*q,'Class D')

Selected_Data_RD = [A,B,C,D];
Selected_Data_RD = Selected_Data_RD';

L1 = ones(1,K);
L2 = 2.*ones(1,K);
Y = [L1,L2,L1,L2];
Y = Y';
%%
    % Data Partitioning
    Ind = crossvalind('HoldOut',Y,0.8);
    
    % Train Data
    XTrain = Selected_Data_RD(find(Ind == 0),:);
    YTrain = categorical(Y(find(Ind == 0)));

    % Test Data
    XTest = Selected_Data_RD(find(Ind == 1),:);
    YTest = categorical(Y(find(Ind == 1)));

%%
    % Labels
    LBs = categories(YTrain);
    
    % Type of Classifiers
    classifier_name = {'Naive Bayes','Discriminant Analysis','Classification Tree','Nearest Neighbor','Support Vector Machine with G-Kernel'};

%     classifier{1} = fitcnb(XTrain,YTrain);
%     classifier{2} = fitcdiscr(XTrain',YTrain);
%     classifier{1} = fitctree(XTrain,YTrain);
    classifier{4} = fitcknn(XTrain,YTrain);
%     classifier{5} = fitckernel(XTrain,YTrain);
%%    
    Labels = categorical(unique(Y));
       
    ii = 4; kk =1;
    yfit = predict(classifier{ii},XTest);
    
    S = figure(2);
    set(S,'color','w');
    confusionchart(YTest,yfit);
    title(classifier_name{ii});
    % Number of Classes
    ClassNum = size(unique(Y),1);

%         for jj = 1:ClassNum

    XTrain_1 = XTrain(find(YTrain == Labels(1)),:);
    XTrain_2 = XTrain(find(YTrain == Labels(2)),:);

    XTest_1  = XTest(find(yfit == Labels(1)),:);
    XTest_2  = XTest(find(yfit == Labels(2)),:);
    
    XTest_T1  = XTest(find(YTest == Labels(1)),:);
    XTest_T2  = XTest(find(YTest == Labels(2)),:);
    
    I1 = find(yfit == YTest);
    I2 = find(yfit ~= YTest);
    
    XTest_G = XTest(I1,:);
    XTest_B = XTest(I2,:);
    
    YTest_G = YTest(I1);
    YTest_B = YTest(I2);
    
    XTest_G1 = XTest_G(find(YTest_G == Labels(1)),:);
    XTest_G2 = XTest_G(find(YTest_G == Labels(2)),:);
    
    XTest_B1 = XTest_B(find(YTest_B == Labels(1)),:);
    XTest_B2 = XTest_B(find(YTest_B == Labels(2)),:);
    
    KSD11 = Kolmogorov_Smirnov_Dist_PN(XTrain_1,XTest_G1);
    KSD22 = Kolmogorov_Smirnov_Dist_PN(XTrain_2,XTest_G2);
    
    KSD12 = Kolmogorov_Smirnov_Dist_PN(XTrain_2,XTest_B2);
    KSD21 = Kolmogorov_Smirnov_Dist_PN(XTrain_1,XTest_B1);
    
    S = figure(3);
    set(S,'color','w');
    x = 1;
    subplot(2,2,1)
    barh(x,KSD11','BaseValue',0)
    title('Why Class 1 Detected as Class 1?')
    xlim([-0.6,0.6])
    
    subplot(2,2,2)
    barh(x,KSD12','BaseValue',0)
    title('Why Class 1 Detected as Class 2?')
    xlim([-0.6,0.6])
    subplot(2,2,3)
    x = 2;
    barh(x,KSD21','BaseValue',0)
    title('Why Class 2 Detected as Class 1?')
    xlim([-0.6,0.6])
    subplot(2,2,4)
    barh(x,KSD22','BaseValue',0)
    title('Why Class 2 Detected as Class 2?')
    xlim([-0.6,0.6])

%%
    Labels = categorical(unique(Y));
       
    ii = 4; kk =1;
    yfit = predict(classifier{ii},XTest);
    
    S = figure(2);
    set(S,'color','w');
    confusionchart(YTest,yfit);
    title(classifier_name{ii});
    
    % Number of Classes
    ClassNum = size(unique(Y),1);

    XTrain_1 = XTrain(find(YTrain == Labels(1)),:);
    XTrain_2 = XTrain(find(YTrain == Labels(2)),:);

    XTest_1  = XTest(find(yfit == Labels(1)),:);
    XTest_2  = XTest(find(yfit == Labels(2)),:);
    
    XTest_T1  = XTest(find(YTest == Labels(1)),:);
    XTest_T2  = XTest(find(YTest == Labels(2)),:);
    
    I1 = find(yfit == YTest);
    I2 = find(yfit ~= YTest);
    
    XTest_G = XTest(I1,:);
    XTest_B = XTest(I2,:);
    
    YTest_G = YTest(I1);
    YTest_B = YTest(I2);
    
    XTest_G1 = XTest_G(find(YTest_G == Labels(1)),:);
    XTest_G2 = XTest_G(find(YTest_G == Labels(2)),:);
    
    XTest_B1 = XTest_B(find(YTest_B == Labels(1)),:);
    XTest_B2 = XTest_B(find(YTest_B == Labels(2)),:);
    
    KSD11 = Wasserstein_Dist_PN(XTrain_1,XTest_G1);
    KSD22 = Wasserstein_Dist_PN(XTrain_2,XTest_G2);
    
    KSD12 = Wasserstein_Dist_PN(XTrain_2,XTest_B2);
    KSD21 = Wasserstein_Dist_PN(XTrain_1,XTest_B1);
    
    S = figure(4);
    set(S,'color','w');
    x = 1;
    subplot(2,2,1)
    barh(x,KSD11','BaseValue',0)
    title('Why Class 1 Detected as Class 1?')
    xlim([-0.6,0.6])
    
    subplot(2,2,2)
    barh(x,KSD12','BaseValue',0)
    title('Why Class 1 Detected as Class 2?')
    xlim([-0.6,0.6])
    subplot(2,2,3)
    x = 2;
    barh(x,KSD21','BaseValue',0)
    title('Why Class 2 Detected as Class 1?')
    xlim([-0.6,0.6])
    subplot(2,2,4)
    barh(x,KSD22','BaseValue',0)
    title('Why Class 2 Detected as Class 2?')
    xlim([-0.6,0.6])