# For Plots
library(ggplot2)
# For ML and Plots
library(caret)
# For Datasets
library(mlbench)
# For Statistical Distance Measure
library(MASS)
library(Compositional)
library(stats)
library(matlib)
library(dplyr)

Smiley_d = mlbench.smiley(1000)

df = data.frame(X = Smiley_d$x[,1], Y = Smiley_d$x[,2], LBs = factor(Smiley_d$classes))

# create a list of 80% of the rows in the original dataset we can use for training
validation_index = createDataPartition(df$X, p=0.80, list=FALSE)
# select 20% of the data for validation
validation = df[-validation_index,]
# use the remaining 80% of data to training and testing the models
dataset = df[validation_index,]

dim(dataset)

# list types for each attribute
sapply(dataset, class)

head(dataset)


# summarize the class distribution
percentage <- prop.table(table(dataset$LBs)) * 100
cbind(freq=table(dataset$LBs), percentage=percentage)

summary(dataset)

# Separating input and output
x = dataset[,1:2]
y = dataset[,3]

# scatterplot matrix
featurePlot(x, y, "pairs")

# density plots for each attribute by class value
scales = list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=factor(y), plot="density", scales=scales)


control = trainControl(method="cv", number=10)
metric = "Accuracy"

# a) linear algorithms
set.seed(7)
fit.lda = train(LBs~., data=dataset, method="lda", metric=metric, trControl=control)
# b) nonlinear algorithms
# CART
set.seed(7)
fit.cart <- train(LBs~., data=dataset, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn <- train(LBs~., data=dataset, method="knn", metric=metric, trControl=control)
# c) advanced algorithms
# SVM
set.seed(7)
fit.svm <- train(LBs~., data=dataset, method="svmRadial", metric=metric, trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(LBs~., data=dataset, method="rf", metric=metric, trControl=control)

#summarize accuracy of models
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)


# jpeg("DotPlot_Results_xor.jpg")
dotplot(results)
# dev.off()
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# estimate skill of LDA on the validation dataset
predictions1_lda = predict(fit.lda, dataset)

predictions1_cart = predict(fit.cart, dataset)

predictions1_rf = predict(fit.rf, dataset)

predictions1_knn = predict(fit.knn, dataset)

predictions1_svm = predict(fit.svm, dataset)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

predictions_lda = predict(fit.lda, validation)

predictions_cart = predict(fit.cart, validation)

predictions_rf = predict(fit.rf, validation)

predictions_knn = predict(fit.knn, validation)

predictions_svm = predict(fit.svm, validation)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc = 4
# a = dataset$X[which(dataset$LBs == 1)]
a_lda = dataset[which(dataset$LBs == cc),1]

a_cart = dataset[which(dataset$LBs == cc),1]

a_rf = dataset[which(dataset$LBs == cc),1]

a_knn = dataset[which(dataset$LBs == cc),1]

a_svm = dataset[which(dataset$LBs == cc),1]
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# b_lda = validation$X[which(predictions_lda == 1)]
b_lda = validation[which(predictions_lda == cc),1]

b_cart = validation[which(predictions_cart == cc),1]

b_rf = validation[which(predictions_rf == cc),1]

b_knn = validation[which(predictions_knn == cc),1]

b_svm = validation[which(predictions_svm == cc),1]


library('twosamples')

SIX_TEST = function(a, b)
{
  KS_1 = ks_stat(a, b, power=1)
  
  K_1 = kuiper_stat(a, b, power = 1)
  
  #CVM_1 = cvm_stat(a, b, power = 1)
  
  AD_1 = ad_stat(a, b, power = 2)
  
  WASS_1 = wass_stat(a, b, power = 1)
  
  DTS_1 = dts_stat(a, b, power = 1)
  
  Est_acc = c(1-KS_1, 1-K_1, 1-AD_1, 1-WASS_1, 1-DTS_1)
  Est_acc
}

Est_acc_LDA = SIX_TEST(a_lda, b_lda)
# Final = data.frame(t(Est_acc_LDA))

Est_acc_CART = SIX_TEST(a_cart, b_cart)
# Final = rbind(Final, t(Est_acc_CART))

Est_acc_KNN = SIX_TEST(a_knn, b_knn)

Est_acc_SVM = SIX_TEST(a_svm, b_svm)

Est_acc_RF = SIX_TEST(a_rf, b_rf)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Res_Val = results$values
Res_Val_Acc = Res_Val %>% select(2,4,6,8,10)
Res_Val_Acc_Col = colMeans(Res_Val_Acc)
True_Mean_Acc = data.frame(t(Res_Val_Acc_Col))
True_Min_Acc = data.frame(t(apply(Res_Val_Acc,2,min)))

Final = data.frame(Est_acc_LDA, Est_acc_CART, Est_acc_KNN, Est_acc_SVM, Est_acc_RF)

