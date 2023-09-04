# RoBoSS
RoBoSS: A Robust, Bounded, Sparse, and Smooth Loss Function for Supervised Learning


This code corresponds to the paper Mushir Akhtar, M. Tanveer, and Mohd. Arshad. "RoBoSS: A Robust, Bounded, Sparse, and Smooth Loss Function for Supervised Learning".

If you are using our code, please give proper citation to the above given paper.

If there is any issue/bug in the code please write to phd2101241004@iiti.ac.in


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Description of the files in RoBoSS-Code.
   
1. RoBoSS_NAG_function.m: This file contains the function of NAG algorithm utilized to solve the RoBoSS-SVM. In RoBoSS_NAG_function the inputs and their meanings are as follows:
   %       alltrain denotes the training data.
   %       test denotes the test data.
   %       a and b are RoboSS loss parameters.
   %       c and mew are trade-off parameter and kernel parameter,
   %       respectively.
   %       m denotes the size of mini-batch.
   %       max_iter denotes the number of maximum iteration.
   %       k and r are the learning rate decay factor and momemtum
   %       parameter related to NAG algorithm, respectively.
   %       t denotes the iteration number. 
   The outputs of RoBoSS_NAG_function and their meaning are as follows:
   %       gamma_opt denotes the optimal parameter of the model.
   %       Accuracy and time denotes the the classification accuracy and training time of the model.


2. Main_RoBoSS.m: This is the main file of RoBoSS-SVM. To utilize this code, you simply need to import the data and execute this script. Within the script, you will be required to provide values for various parameters (such as loss function parameters, NAG algorithm parameters, trade-off parameter, kernel parameter etc.).
To replicate the results achieved with RoBoSS-SVM, you should adhere to the same instructions outlined in the paper "RoBoSS: A Robust, Bounded, Sparse, and Smooth Loss Function for Supervised Learning". 


  
