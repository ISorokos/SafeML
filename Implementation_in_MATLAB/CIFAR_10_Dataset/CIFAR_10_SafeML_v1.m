%% Classifying the CIFAR-10 dataset using Convolutional Neural Networks
% This example shows how to train a Convolutional Neural Network (CNN) from
% scratch using the dataset CIFAR10.
%
% Data Credit: Krizhevsky, A., & Hinton, G. (2009). Learning multiple 
% layers of features from tiny images.

% Copyright 2016 The MathWorks, Inc.
clc
clearvars
%% Download the CIFAR-10 dataset
if ~exist('cifar-10-batches-mat','dir')
    cifar10Dataset = 'cifar-10-matlab';
    disp('Downloading 174MB CIFAR-10 dataset...');   
    websave([cifar10Dataset,'.tar.gz'],...
        ['https://www.cs.toronto.edu/~kriz/',cifar10Dataset,'.tar.gz']);
    gunzip([cifar10Dataset,'.tar.gz'])
    delete([cifar10Dataset,'.tar.gz'])
    untar([cifar10Dataset,'.tar'])
    delete([cifar10Dataset,'.tar'])
end    

%% Prepare the CIFAR-10 dataset
if ~exist('cifar10Train','dir')
    disp('Saving the Images in folders. This might take some time...');    
    saveCIFAR10AsFolderOfImages('cifar-10-batches-mat', pwd, true);
end

%% Load image CIFAR-10 Training dataset (50000 32x32 colour images in 10 classes)
imsetTrain = imageSet('cifar10Train','recursive');

%% Load Features
Data1 = load('C:\Users\Koo\Desktop\R Project\Ioannis Security SafeML\CIFAR_10\cifar-10-batches-mat\data_batch_1.mat');
Data2 = load('C:\Users\Koo\Desktop\R Project\Ioannis Security SafeML\CIFAR_10\cifar-10-batches-mat\data_batch_2.mat');
Data3 = load('C:\Users\Koo\Desktop\R Project\Ioannis Security SafeML\CIFAR_10\cifar-10-batches-mat\data_batch_3.mat');
Data4 = load('C:\Users\Koo\Desktop\R Project\Ioannis Security SafeML\CIFAR_10\cifar-10-batches-mat\data_batch_4.mat');
Data5 = load('C:\Users\Koo\Desktop\R Project\Ioannis Security SafeML\CIFAR_10\cifar-10-batches-mat\data_batch_5.mat');

Train_Data = [Data1.data; Data2.data; Data3.data; Data4.data; Data5.data];

Reduced_Dim = 10;
[coeff, score] = pca(double(Train_Data));
Train_Data_RD = score(:,1:Reduced_Dim);

%% Display Sampling of Image Data
numClasses = size(imsetTrain,2);
imagesPerClass = 10;
imagesInMontage = cell(imagesPerClass,numClasses);
for i = 1:size(imagesInMontage,2)
    imagesInMontage(:,i) = ...
        imsetTrain(i).ImageLocation(randi(imsetTrain(i).Count, 1, ...
        imagesPerClass));
end
figure(80)
montage({imagesInMontage{:}},'Size',[numClasses,imagesPerClass]);
title('Sample of Training Data (CIFAR-10, Krizhevsky, 2009.)')

%% Prepare the data for Training
% Read all images and store them in a 4D uint8 input array for training,
% with its corresponding class
trainNames = {imsetTrain.Description};
XTrain = zeros(32,32,3,sum([imsetTrain.Count]),'uint8');
TTrain = categorical(discretize((1:sum([imsetTrain.Count]))',...
    [0,cumsum([imsetTrain.Count])],'categorical',trainNames));

j = 0;
tic;
for c = 1:length(imsetTrain)
    for i = 1:imsetTrain(c).Count
        XTrain(:,:,:,i+j) = read(imsetTrain(c),i);
    end
    j = j + imsetTrain(c).Count;
end
toc;

%% CNN architecture
    conv1 = convolution2dLayer(5,32,'Padding',2,...
                         'BiasLearnRateFactor',2);
    conv1.Weights = (single(randn([5 5 3 32])*0.0001));
    fc1 = fullyConnectedLayer(64,'BiasLearnRateFactor',2);
    fc1.Weights = (single(randn([64 576])*0.1));
    fc2 = fullyConnectedLayer(10,'BiasLearnRateFactor',2);
    fc2.Weights = (single(randn([10 64])*0.1));

    layers = [ ...
        imageInputLayer([32 32 3]);

        convolution2dLayer(5,32,'Padding',2,'BiasLearnRateFactor',2);
        maxPooling2dLayer(3,'Stride',2);
        reluLayer();

        convolution2dLayer(5,32,'Padding',2,'BiasLearnRateFactor',2);
        reluLayer();

        averagePooling2dLayer(3,'Stride',2);
        convolution2dLayer(5,64,'Padding',2,'BiasLearnRateFactor',2);
        reluLayer();

        averagePooling2dLayer(3,'Stride',2);
        fc1;
        reluLayer();
        fc2;
        softmaxLayer()
        classificationLayer()];

    % Define the training options.
    opts = trainingOptions('sgdm', ...
        'InitialLearnRate', 0.001, ...
        'LearnRateSchedule', 'piecewise', ...
        'LearnRateDropFactor', 0.1, ...
        'LearnRateDropPeriod', 8, ...
        'L2Regularization', 0.004, ...
        'MaxEpochs', 10, ...
        'MiniBatchSize', 100, ...
        'Verbose', true);

    % Training the CNN
    [net, info] = trainNetwork(XTrain, TTrain, layers, opts);

%% Load Test Data

imsetTest = imageSet('cifar10Test','recursive');

testNames = {imsetTest.Description};
XTest = zeros(32,32,3,sum([imsetTest.Count]),'uint8');
TTest = categorical(discretize((1:sum([imsetTest.Count]))',...
    [0,cumsum([imsetTest.Count])],'categorical',testNames));
j = 0;
tic;
for c = 1:length(imsetTest)
    for i = 1:imsetTest(c).Count
        XTest(:,:,:,i+j) = read(imsetTest(c),i);
    end
    j = j + imsetTest(c).Count;
end
toc;
%% Load Test Features
load('C:\Users\Koo\Desktop\R Project\Ioannis Security SafeML\CIFAR_10\cifar-10-batches-mat\test_batch.mat')
Test_Data = data;
Test_Labels = labels;

% PCA
[coeff, score] = pca(double(Test_Data));
Test_Data_RD = score(:,1:Reduced_Dim);
% t-SNE
% YYY_Test = tsne(double(Test_Data));
% Test_Data_RD = YYY_Test(:,1:2);

clear data labels

%% Run the network on the test set
PermNum = 100;

for kk = 1:PermNum
    
    Ind = crossvalind('HoldOut',TTest,0.8);

    % Test Data
    XTest1 = Test_Data_RD(find(Ind == 0), :);
    XTest2 = XTest(:,:,:,find(Ind == 0));
    TTest2 = categorical(TTest(find(Ind == 0)));
    
    YTest = classify(net, XTest2);

    Labels = categorical(unique(YTest));

    S = figure(3);
    set(S,'color','w');      
    confusionchart(TTest2,YTest);

    ClassNum = size(Labels,1);

    for jj = 1:ClassNum
    
            XTrain_L = Train_Data_RD(find(TTrain == Labels(jj)),:);
            XTest_L  = XTest1(find(YTest == Labels(jj)),:);

            Results(jj, 1, kk) = Acc_Check2(TTest2, YTest,jj);

            Results(jj, 2, kk) = Cramer_Von_Mises(XTrain_L,XTest_L);

            Results(jj, 3, kk) = Kolmogorov_Smirnov_Dist(XTrain_L,XTest_L);

            Results(jj, 4, kk) = Kuiper_Dist(XTrain_L,XTest_L);

            Results(jj, 5, kk) = Anderson_Darling_Dist(XTrain_L,XTest_L);

            Results(jj, 6, kk) = Wasserstein_Dist(XTrain_L,XTest_L);

            Results(jj, 7, kk) = Wasserstein_Anderson_Darling_Dist(XTrain_L,XTest_L,2);
    end
%%

        Plots_Acc_Dist2(Results(:,:,kk), 1);
        temp = Results(:,:,kk);
        [B, I] = sort(temp(:,1));
        SResults(:,:,kk) = temp(I,:);  
        
end
%%
BoxPlot_Acc_Dist(SResults, 100 + 1, ClassNum, Labels)
% Calculate the overal accuracy.
accuracy = sum(YTest == TTest2)/numel(TTest2)
%% Needed Functions

% Accuracy Evaluation Function
function Acc_1 = Acc_Check2(TTest,YTest, jj)
C_Mat = confusionmat(TTest,YTest);
Acc_1 = C_Mat(jj,jj)/sum(C_Mat(jj,:));
end

% Simple Result Plot Function
function Plots_Acc_Dist2(Results, FigNum)
    [B, I] = sort(Results(:,1));
    SResults = Results(I,:);   
    
    Methods = {'\fontsize{16}Cramer Von Mises','\fontsize{16}Kolmogorov-Smirnov','\fontsize{16}Kuiper','\fontsize{16}Anderson-Darling','\fontsize{16}Wasserstein','\fontsize{16}WAD'};

    S = figure(FigNum);
    set(S,'color','w');
    set(S, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    subplot(231)
    for ii = 1:size(Results,2)-1
        subplot(2,3,ii)
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
function BoxPlot_Acc_Dist(SResults, FigNum, ClassNum, Labels)

    rng('default')  % For reproducibility

    Methods = {'\fontsize{16}Cramer Von Mises','\fontsize{16}Kolmogorov-Smirnov','\fontsize{16}Kuiper','\fontsize{16}Anderson-Darling','\fontsize{16}Wasserstein','\fontsize{16}WAD'};

    S = figure(FigNum);
    set(S,'color','w');
    set(S, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    subplot(231)
    for ii = 1:6
        subplot(2,3,ii)
        [x, g] = Reshape_for_BoxPlot(SResults, ii+1, ClassNum, Labels);
        boxplot(x,g)
        title(Methods{ii})
        xlabel('\fontsize{16}Mean Accuracy (100 Permutation)')
        ylabel('\fontsize{16}Distance')
        xtickangle(45)
    end
end

% For Preprocessing Data Befor Box Plot 
function [x, g] = Reshape_for_BoxPlot(SResults, DNum, ClassNum, Labels)

    rng('default')  % For reproducibility
    SResults = real(SResults);
    
    x = zeros(size(SResults, 3), ClassNum);
    g = {};
    
    for ii = 1:ClassNum
        x(:,ii) = reshape(SResults(ii,DNum,:),[size(SResults, 3),1]); 

        g = cat(1,g,repmat({[char(Labels(ii)),' Acc = ', num2str(mean(reshape(SResults(ii,1,:),[size(SResults, 3),1])))]},size(SResults, 3),1))
    end
    
end
