<p align="left"> </p>

 <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT">
  <a href="https://standardjs.com"><img src="https://img.shields.io/badge/code_style-standard-brightgreen.svg" alt="Standard - \Python Style Guide"></a>

<p align="center">
 <img src="https://github.com/ISorokos/SafeML/blob/master/SafeML_Logo.png" alt="SafeML_Logo"> </p>
  
# SafeML
Exploring techniques for estimating safety of machine learning classifiers.

## Description
<p align="justify">
The following figure illustrates the flowchart of the proposed approach. In this flowchart, there are two main sections including training phase and application phase. A) The training phase is an offline procedure in which a trusted dataset will be used to train the intelligent algorithm that can be a machine learning or deep learning algorithm. This study will focus on the classification ability of machine learning. Thus, using a trusted dataset the classifier will be trained and its performance will be measured with existing KPIs. Meanwhile, the probability density function and statistical parameters of each class will be estimated and stored to be used for comparison. B) The second phase or application phase is an online procedure in which real-time and unlabelled data is going to be feed to the system. For example, consider an autonomous car the has been trained to detect obstacles and it should prevent a collision. Therefore, in the application phase, the trained classifier should distinguish between the road and other objects. One important and critical issue in the application phase is that the data does not have any label. So, it cannot be assured that the classifier can operate as accurate as of the training phase. In the application phase, the untrusted labels of the classifier will be used and similarly, the probability cumulative distribution function (CDF) and statistical parameters of each class will be extracted. The CDF-based statistical difference of each class in the training phase and application phase is used to estimate the accuracy. If the estimated accuracy and expected confidence difference was very low, the classifier results and accuracy can be trusted (In this example the autonomous car continuous its operation), if the difference was low, the system can ask for more data and re-evaluation to make sure about the distance. In case of having more difference, the classifier results and accuracy is no longer valid, and the system should use alternative approach or notify human agent (In this example, the system will ask the driver to take the control of the car).
</p>
<p align="center">
 <img src="https://github.com/ISorokos/SafeML/blob/master/FlowChart.png" alt="FlowChart">
 <figcaption>Figure 1. Flowchart of the proposed approach</figcaption>
</p>

## Examples

* Hypothetical Example
* Security Dataset
* Tensorflow Playground Datasets (<a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R/Examples/2D_XOR_Dataset">XOR</a>, <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R/Examples/2D_Spiral_Dataset">Spiral</a>)

## Publication


