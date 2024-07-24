# RoBoSS
RoBoSS: A Robust, Bounded, Sparse, and Smooth Loss Function for Supervised Learning

This code corresponds to the paper: Mushir Akhtar, M. Tanveer, and Mohd. Arshad. "RoBoSS: A Robust, Bounded, Sparse, and Smooth Loss Function for Supervised Learning.” 
- Under Revision in IEEE Transactions on Pattern Analysis and Machine Intelligence.

If you are using our code, please give proper citation to the above given paper.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

We have put a demo of the “RoBoSS-SVM” model with the “credit_approval” dataset. 


Description of files:
---------------------
Main.m: This is the main file of RoBoSS-SVM. To utilize the code, you simply need to import the data and execute this script. Within the script, you will be required to provide values for various parameters (such as loss function parameters, trade-off parameter, kernel parameter etc.). To replicate the results achieved with RoBoSS-SVM, you should adhere to the same instructions outlined in the paper.


RoBoSS_function.m: The Main file calls this file for the training and testing process. This file contains the function of NAG algorithm utilized to solve the RoBoSS-SVM. In RoBoSS_function the inputs and their meanings are as follows: train denotes the training data, test denotes the test data, a and b are RoBoSS loss parameters, C and sigma are trade-off parameter and kernel parameter, respectively. m denotes the size of mini-batch. The outputs of RoBoSS_function and their meaning are as follows: Accuracy and time denotes the classification accuracy and training time of the model.


Add_label_noise.m: This file contains the script to add label noise to the dataset.


Add_outliers.m: This file contains the script to add outliers to the dataset.
---------------------------------------------------

The codes are not optimized for efficiency. The codes have been cleaned for better readability and documented and are not exactly the same as used in our paper. 
For the detailed experimental setup, please follow the paper. 
We have re-run and checked the codes only in a few datasets, so if you find any bugs/issues, please write to Mushir Akhtar (phd2101241004@iiti.ac.in).

