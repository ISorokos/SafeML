<p align="left"> </p>

 <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT">
  <a href="https://standardjs.com"><img src="https://img.shields.io/badge/code_style-standard-brightgreen.svg" alt="Standard - \Python Style Guide"></a> [![View ECDF-based Distance Measure Algorithms  on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://uk.mathworks.com/matlabcentral/fileexchange/75282-ecdf-based-distance-measure-algorithms)
<p align="center">
 <img src="https://github.com/ISorokos/SafeML/blob/master/SafeML_Logo.png" alt="SafeML_Logo"> </p>
  
# SafeML
Exploring techniques for safety monitoring of machine learning classifiers.
## Abstract
<p align="justify">
Ensuring safety and explainability of machine learning (ML) is a topic of increasing relevance as data-driven applications venture into safety-critical application domains, traditionally committed to high safety standards that are not satisfied with an exclusive testing approach of otherwise inaccessible black-box systems. Especially the interaction between safety and security is a central challenge, as security violations can lead to compromised safety. The contribution of this project to addressing both safety and security within a single concept of protection applicable during the operation of ML systems is active monitoring of the behaviour and the operational context of the data-driven system based on distance measures of the Empirical Cumulative Distribution Function (ECDF). We investigate abstract datasets such as XOR, Spiral, and Circle and some well-known security-specific datasets for intrusion detection of simulated network traffic, using distributional shift detection measures including the Kolmogorov-Smirnov, Kuiper, Anderson-Darling, Wasserstein and mixed Wasserstein-Anderson-Darling measures. Our preliminary findings indicate that the approach can provide a basis for detecting whether the application context of an ML component is valid in the safety-security. </p>

## Description
<p align="justify">
The following figure illustrates the flowchart of the proposed approach. In this flowchart, there are two main sections including training phase and application phase. A) The training phase is an offline procedure in which a trusted dataset will be used to train the intelligent algorithm that can be a machine learning or deep learning algorithm. This study will focus on the classification ability of machine learning. Thus, using a trusted dataset the classifier will be trained and its performance will be measured with existing KPIs. Meanwhile, the probability density function and statistical parameters of each class will be estimated and stored to be used for comparison. B) The second phase or application phase is an online procedure in which real-time and unlabelled data is going to be feed to the system. For example, consider an autonomous car the has been trained to detect obstacles and it should prevent a collision. Therefore, in the application phase, the trained classifier should distinguish between the road and other objects. One important and critical issue in the application phase is that the data does not have any label. So, it cannot be assured that the classifier can operate as accurate as of the training phase. In the application phase, the untrusted labels of the classifier will be used and similarly, the probability cumulative distribution function (CDF) and statistical parameters of each class will be extracted. The CDF-based statistical difference of each class in the training phase and application phase is used to estimate the accuracy. If the estimated accuracy and expected confidence difference was very low, the classifier results and accuracy can be trusted (In this example the autonomous car continues its operation), if the difference was low, the system can ask for more data and re-evaluation to make sure about the distance. In case of larger difference, the classifier results and accuracy are no longer valid, and the system should use an alternative approach or notify a human agent (In this example, the system will ask the driver to take the control of the car).
</p>
<p align="center">
 <img src="https://github.com/ISorokos/SafeML/blob/master/FlowChart.png" alt="FlowChart">
 <figcaption>Figure 1. Flowchart of the proposed approach</figcaption>
</p>

## From SafeML Toward Explainable AI (XAI)
<p align="justify">
The proposed method is not only suitable for safety evaluation of machine learning classifiers but also can be used @Run-Time as an eXplainable AI (XAI). In one of our <a href = "https://github.com/ISorokos/SafeML/tree/master/Implementation_in_MATLAB/Explainable_AI">examples for security dataset</a>, we showed how SafeML can be used as XAI.</p>

## Case Studies
<ul>
  <li><b>Security Datasets</b></li>
<p align="justify">
A Intrusion Detection Evaluation Dataset (<a href="https://www.unb.ca/cic/datasets/ids-2017.html">CICIDS2017</a>) [<a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_MATLAB">MATLAB implementation</a>].</li></p>
<p align="justify">
Tor-nonTor Dataset (<a href="https://www.unb.ca/cic/datasets/tor.html">ISCXTor2016</a>) [<a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_MATLAB">MATLAB implementation</a>].
</p>
<p align="justify">
DDoS Attach Dataset (<a href="https://www.unb.ca/cic/datasets/ids-2018.html">CSE-CIC-IDS2018</a>) [<a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_MATLAB">MATLAB implementation</a>].</p>
<p align="justify">
NSL version of KDD Security Dataset  (<a href="https://www.unb.ca/cic/datasets/nsl.html">NSL-KDD</a>) [<a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_MATLAB/NSL_KDD_Security_Dataset">MATLAB implementation</a>].</p>
<p align="justify">
DDoS Evaluation Dataset (<a href="https://www.unb.ca/cic/datasets/ddos-2019.html">CICDDoS2019</a>) [<a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_MATLAB/CICDDoS2019_Security_Dataset">MATLAB implementation</a>].</p>
<p align="justify">
CIC DoS Dataset (<a href="https://www.unb.ca/cic/datasets/dos-dataset.html">CICDoS2017</a>) [Will be available in <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_MATLAB">MATLAB implementation</a>].
</p> 
<p align="justify">
VPN-nonVPN Dataset (<a href="https://www.unb.ca/cic/datasets/vpn.html">ISCXVPN2016</a>) [Will be available in <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_MATLAB">MATLAB implementation</a>].
</p> 
<p align="justify">
Botnet Dataset (<a href="https://www.unb.ca/cic/datasets/botnet.html">BotNet2014</a>) [Will be available in <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_MATLAB">MATLAB implementation</a>].
</p> 
 
<li><b>MLBENCH Datasets</b></li>

<p align="justify">
A number of datasets in <a href="https://www.rdocumentation.org/packages/mlbench/versions/2.1-1">MLBENCH library</a> of R such as <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R/Examples/2D_XOR_Dataset">XOR</a>, <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R/Examples/2D_Spiral_Dataset">Spiral</a>, <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R/Examples/2D_Circle_Dataset">Circle</a>, and <a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R/Examples/2D_Smiley_Dataset">Smiley</a> [<a href="https://github.com/ISorokos/SafeML/tree/master/Implementation_in_R">R implementation</a>].</p>
  <li><a href = "http://benchmark.ini.rub.de/?section=gtsrb&subsection=dataset"><b>GTSRB - German Traffic Sign Recognition Benchmark</b></a> [will be added soon in <a href = "https://github.com/ISorokos/SafeML/tree/master/Implementation_in_Python">Python implementation</a>].</li>
  <li>CIFAR 10/100 Datasets [Will be added soon...]</li>
  <li>More datasets will be tested. Please stay tuned.</li>
  
</ul>

## Contributors
* <a href = "https://github.com/ISorokos">Ioannis Sorokos (Fraunhofer Institute for Experimental Software Engineering)</a>
* <a href = "https://github.com/koo-ec">Koorosh Aslansefat (University of Hull)</a>
* Ramin Tavakoli Kolagari (Technische Hochschule Nürnberg) 
* <a href = "https://github.com/declan-whiting">Declan Whiting (University of Hull & APD Communications)</a>

## Publication
<p align="justify">
Aslansefat, K. Sorokos, I., Whiting, D., Tavakoli Kolagari, R. and Papadopoulos, Y. (2020) <b>SafeML: Safety Monitoring of Machine Learning Classifiers through Statistical Difference Measure<b>. [<a href="https://arxiv.org/abs/2005.13166">arXiv</a>][<a href="https://www.researchgate.net/publication/341699548_SafeML_Safety_Monitoring_of_Machine_Learning_Classifiers_through_Statistical_Difference_Measure/stats">ResearchGate</a>][<a href = "https://deepai.org/publication/safeml-safety-monitoring-of-machine-learning-classifiers-through-statistical-difference-measure">DeepAI</a>]
 
## Cite as
<pre>
@article{Aslansefat2020SafeML,
   author  = {{Aslansefat}, Koorosh and {Sorokos}, Ioannis and {Whiting}, Declan and
              {Tavakoli Kolagari}, Ramin and {Papadopoulos}, Yiannis},
   title   = "{SafeML: Safety Monitoring of Machine Learning Classifiers through Statistical Difference Measure}",
   journal = {arXiv e-prints},
   year    = {2020},
   url     = {https://arxiv.org/abs/2005.13166},
   eprint  = {2005.13166},
}
</pre>

## Related Works
<p align="justify">
Amodei, D., Olah, C., Steinhardt, J., Christiano, P., Schulman, J., & Mané, D. (2016). <b>Concrete Problems in AI Safety</b>. [<a href="http://arxiv.org/abs/1606.06565">arXiv</a>]
</p> 
<p align="justify">
Irving, G., Christiano, P., & Amodei, D. (2018). <b>AI Safety via Debate</b>. [<a href = "https://arxiv.org/pdf/1805.00899.pdf">arXiv</a>]
</p>
<p align="justify">
Schulam, P., & Saria, S. (2019). <b>Can You Trust This Prediction? Auditing Pointwise Reliability After Learning</b>. [<a href = "http://arxiv.org/abs/1901.00403">arXiv</a>]
</p>
<p align="justify">
Kläs, M., & Sembach, L. (2019). <b>Uncertainty Wrappers for Data-driven Models</b>. [<a href = "https://doi.org/10.1007/978-3-030-26250-1_29">Springer</a>]
 </p>
<p align="justify">
Gehr, T., Mirman, M., Drachsler-Cohen, D., Tsankov, P., Chaudhuri, S., & Vechev, M. (2018). <b>AI2: Safety and robustness certification of neural networks with abstract interpretation</b>. In IEEE Symposium on Security and Privacy (SP). [<a href = "https://doi.org/10.1109/SP.2018.00058">IEEE</a>]
</p> 
 
## Related Projects
<p align="justify">
<a href = "https://github.com/koo-ec/SafeNN">SafeNN Project: </a>This porject relies on the idea of SafeML and aimed to evaluate safety of Deep Neural Networks using statistical distance measures.</p>
<p align="justify">
<a href = "https://github.com/dependable-ai/nn-dependability-kit">NN-Dependability-KIT Project: </a>Toolbox for software dependability engineering of artificial neural networks.</p>
<p align="justify">
<a href = "https://github.com/cfinlay/confident-nn">Confident-NN Project: </a>Toolbox for empirical confidence estimation in neural networks-based classification.</p>
<p align="justify">
<a href = "https://eth-sri.github.io/research/safeai">SafeAI Project: </a>Different toolboxes like <a href = "https://github.com/eth-sri/diffai">DiffAI<a>, <a href = "https://github.com/eth-sri/dl2">DL2<a> and <a href = "https://github.com/eth-sri/eran">ERAN</a> from SRILab ETH Zürich focusing on robust, safe and interpretable AI.</p> 

## License
This framework is available under an MIT License.

## Acknowledgments
<p align="justify">We  would  like  to  thank  EDFEnergy R&D UK Centre, AURA Innovation Centre and University of Hull for their support.</p>
