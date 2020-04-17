<p align="left"> </p>

 <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT">
  <a href="https://standardjs.com"><img src="https://img.shields.io/badge/code_style-standard-brightgreen.svg" alt="Standard - \Python Style Guide"></a>

<p align="center">
 <img src="https://github.com/ISorokos/SafeML/blob/master/SafeML_Logo.png" alt="SafeML_Logo"> </p>
  
# SafeML
Exploring techniques for estimating safety of machine learning classifiers.
## Abstract
<p align="justify">Nowadays the application of advanced machine learning or deep learning in various industries is growing rapidly. In parallel with this massive growth, the concern about the safety and explainability of these algorithms are also high. This project is proposing a solution to do a safety verification using statistical difference measure algorithms. A number of hypothetical and real examples are provided to clarify the limitations and capabilities of the proposed method.</p>

## Description
<p align="justify">
The following figure illustrates the flowchart of the proposed approach. In this flowchart, there are two main sections including training phase and application phase. A) The training phase is an offline procedure in which a trusted dataset will be used to train the intelligent algorithm that can be a machine learning or deep learning algorithm. This study will focus on the classification ability of machine learning. Thus, using a trusted dataset the classifier will be trained and its performance will be measured with existing KPIs. Meanwhile, the probability density function and statistical parameters of each class will be estimated and stored to be used for comparison. B) The second phase or application phase is an online procedure in which real-time and unlabelled data is going to be feed to the system. For example, consider an autonomous car the has been trained to detect obstacles and it should prevent a collision. Therefore, in the application phase, the trained classifier should distinguish between the road and other objects. One important and critical issue in the application phase is that the data does not have any label. So, it cannot be assured that the classifier can operate as accurate as of the training phase. In the application phase, the untrusted labels of the classifier will be used and similarly, the probability cumulative distribution function (CDF) and statistical parameters of each class will be extracted. The CDF-based statistical difference of each class in the training phase and application phase is used to estimate the accuracy. If the estimated accuracy and expected confidence difference was very low, the classifier results and accuracy can be trusted (In this example the autonomous car continuous its operation), if the difference was low, the system can ask for more data and re-evaluation to make sure about the distance. In case of having more difference, the classifier results and accuracy is no longer valid, and the system should use alternative approach or notify human agent (In this example, the system will ask the driver to take the control of the car).
</p>
<p align="center">
 <img src="https://github.com/ISorokos/SafeML/blob/master/FlowChart.png" alt="FlowChart">
 <figcaption>Figure 1. Flowchart of the proposed approach</figcaption>
</p>

## Examples

* Security Dataset: In <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_MATLAB">MATLAB implementation</a>, A Intrusion Detection Evaluation Dataset (<a href="https://www.unb.ca/cic/datasets/ids-2017.html">CICIDS2017</a>) has been used. 
* MLBENCH Datasets: In <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R">R implementation</a>, A number of datasets in <a href="https://www.rdocumentation.org/packages/mlbench/versions/2.1-1">MLBENCH library</a> of R such as <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R/Examples/2D_XOR_Dataset">XOR</a>, <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R/Examples/2D_Spiral_Dataset">Spiral</a>, <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R/Examples/2D_Circle_Dataset">Circle</a>, and <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R/Examples/2D_Smiley_Dataset">Smiley</a> have been used.

## Publication

## References
<p align="justify">
Amodei, D., Olah, C., Steinhardt, J., Christiano, P., Schulman, J., & Mané, D. (2016). Concrete Problems in AI Safety. http://arxiv.org/abs/1606.06565
Aslansefat, K., Bahar Gogani, M., Kabir, S., Shoorehdeli, M. A., & Yari, M. (2019). Performance evaluation and design for variable threshold alarm systems through semi-Markov process. ISA Transactions. https://doi.org/10.1016/j.isatra.2019.08.015
Bellemare, M. G., Danihelka, I., Dabney, W., Mohamed, S., Lakshminarayanan, B., Hoyer, S., & Munos, R. (2017). The Cramer Distance as a Solution to Biased Wasserstein Gradients. http://arxiv.org/abs/1705.10743
Burton, S., Habli, I., Lawton, T., McDermid, J., Morgan, P., & Porter, Z. (2020). Mind the gaps: Assuring the safety of autonomous systems from an engineering, ethical, and legal perspective. Artificial Intelligence, 279, 103201. https://doi.org/10.1016/j.artint.2019.103201
Davenport, T. H., Brynjolfsson, E., McAfee, A., James, H., & Wilson, R. (2019). Artificial Intelligence: The Insights You Need from Harvard Business Review. Harvard Business Review.
Du‐Harpur, X., Watt, F. M., Luscombe, N. M., & Lynch, M. D. (2020). What is AI? Applications of artificial intelligence to dermatology. British Journal of Dermatology, bjd.18880. https://doi.org/10.1111/bjd.18880
Evans, J. (2020). Artificial Intelligence and Public Standards: A Review by the Committee on Standards in Public Life.
Fukunaga, K. (1992). Introduction to Statistical Pattern Recognition (Second Edition). Academic Press.
Goodfellow, I. J., Pouget-Abadie, J., Mirza, M., Xu, B., Warde-Farley, D., Ozair, S., Courville, A., & Bengio, Y. (2014). Generative Adversarial Nets. http://www.github.com/goodfeli/adversarial
Gulrajani, I., Ahmed, F., Arjovsky, M., Dumoulin, V., & Courville, A. (2017). Improved Training of Wasserstein GANs Montreal Institute for Learning Algorithms. https://github.com/igul222/improved
Hadjeres, G., & Nielsen, F. (2020). Schoenberg-Rao distances: Entropy-based and geometry-aware statistical Hilbert distances. http://arxiv.org/abs/2002.08345
ISO/IEC JTC 1/SC 42: Artificial intelligence. (2020).
Laurens van der Maaten. (2014). Accelerating t-SNE using Tree-Based Algorithms. Journal of Machine Learning Research, 15, 3221–3245. https://doi.org/10.1007/978-1-60761-580-4_8
Nielsen, F. (2014). Generalized Bhattacharyya and Chernoff upper bounds on Bayes error using quasi-arithmetic means. Pattern Recognition Letters, 42(1), 25–34. https://doi.org/10.1016/j.patrec.2014.01.002
Nielsen, F. (2018). The Chord Gap Divergence and a Generalization of the Bhattacharyya Distance. ICASSP, IEEE International Conference on Acoustics, Speech and Signal Processing - Proceedings, 2018-April, 2276–2280. https://doi.org/10.1109/ICASSP.2018.8462244
Quiñonero-Candela, J., & Schwaighofer, A. (2009). Dataset Shift in Machine Learning. MIT Press.
Schulam, P., & Saria, S. (2019). Can You Trust This Prediction? Auditing Pointwise Reliability After Learning. http://arxiv.org/abs/1901.00403
Sharkey, A. (2019). Autonomous weapons systems, killer robots and human dignity. Ethics and Information Technology, 21(2), 75–87. https://doi.org/10.1007/s10676-018-9494-0
Su, J., Vargas, D. V., & Sakurai, K. (2019). One Pixel Attack for Fooling Deep Neural Networks. IEEE Transactions on Evolutionary Computation, 23(5), 828–841. https://doi.org/10.1109/TEVC.2019.2890858
Theodoridis, S., & Koutroumbas, K. (2009). Pattern Recognition. In Pattern Recognition. Elsevier Inc. https://doi.org/10.1016/B978-1-59749-272-0.X0001-2
Wiens, J., Saria, S., Sendak, M., Ghassemi, M., Liu, V. X., Doshi-Velez, F., Jung, K., Heller, K., Kale, D., Saeed, M., Ossorio, P. N., Thadaney-Israni, S., & Goldenberg, A. (2019). Do no harm: a roadmap for responsible machine learning for health care. Nature Medicine, 25(9), 1337–1340. https://doi.org/10.1038/s41591-019-0548-6
Zahm, O., Cui, T., Law, K., Spantini, A., & Marzouk, Y. (2018). Certified dimension reduction in nonlinear Bayesian inverse problems. http://arxiv.org/abs/1807.03712
</p>
