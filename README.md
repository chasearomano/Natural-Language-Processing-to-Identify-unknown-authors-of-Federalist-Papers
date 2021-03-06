# Exploring Unknown Authors <br> for 12 Federalist Papers

### By Chase Romano
 
<hr>

<h6>Part I: Initial Exploration</h6>
<ol>
  <li>Papers included in the data set include papers written by Hamilton, Jay, Madison, Hamilton & Madison, and Unknown.  Narrow down to papers written by Hamilton, Madison, and Unknown.</li>
  <li>Order the Papers based on Author, Remove “To the People of the State of New York: “ , and establish the corpus and initial DFM Matrix.</li>
  <li>Conduct some simple frequency analysis</li>
  <li>Visualize the most frequent terms</li>
</ol>

![alt test](/Images/WordCloud.png)

<hr>

<h6>Part II: Exploratory Analyses with Similarity and Clustering</h6>

<ol>
  <li>Remove Stop words and perform stemming.</li>
  <li>Add more user-defined stop words based on knowledge of the text and create an updated Word Cloud </li>
 
 ![alt test](/Images/WordCloud2.png)
 
  <li>Remove some very frequent words</li>
  <li>Control sparse terms: to further remove some very infrequent words</li>
   <li>Perform document clustering and explore results from clustering analyses</li>
   
   ![alt test](/Images/Cluster.png)
   
 <li>Explore document similarity for text77 and based on the result identify who may have written text 77.</li>
 
 ![alt test](/Images/DocSim.png)
 
 <li>Since Hamilton wrote all but one of these texts (56 which is Unknown) we can predict that Hamilton wrote text 77</li>
</ol>


<hr>

<h6>Part III: Topic Modeling</h6>
<ol>
  <li>You can explore with varying k numbers, I chose to show 8, below are the Term-topic probabilities.</li>
  <li>Visualize most common terms in each topic</li>
 
 
 ![alt test](/Images/TopicMod.png)
 
  <li>Calculate the document-topic probabilities</li>
  <li>View the document Probabilities in a table</li>
  
   ![alt test](/Images/DocProb.png)
  
</ol>
<hr>

<h6>Part IV: Predicting Authorship</h6>
<ol>
  <li>Prepare the corpus by adding the ID and author columns.</li>
  <li>We will first generate SVD columns based on the entire corpus.  Pre-process the training corpus, further remove very infrequent words, and weight the predictiv DFM by tf-idf.</li>
  <li>Perform SVD for dimension reduction and choose the number of reduced dimensions as 10</li>
 
  ![alt test](/Images/SVD1.png)
 
  <li>Add the author information as the first column (cut off at six to give a better display)</li>
  
  ![alt test](/Images/SVD2.png)
  
 <li>Split the data into training & test.  Typically we use random data partition, however, given our specific dataset, we manually split the dataset.  Training dataset contains papers with known author information and the test dataset contains papers with unknown author information.</li>
  <li>Need to drop the unused unknown level in the training dataset, build a logistic model based on the training dataset, and compare model prediction with known authorships</li>
  
  ![alt test](/Images/ConfMat.png)
  
 <li>Predict authorship for the test dataset and View results</li>
 
 ![alt test](/Images/Prediction.png)
 
 The final model predicts that Madison wrote 3 of the 12 Unknown papers (Papers 51, 62, and 63) 
 
</ol>
<hr>
