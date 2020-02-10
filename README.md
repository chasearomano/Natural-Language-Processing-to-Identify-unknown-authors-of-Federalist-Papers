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

![alt test](/Images/WordCloud2.png)

<hr>

<h6>Part II: Exploratory Analyses with Similarity and Clustering</h6>

<ol>
  <li>Remove Stop words and perform stemming.</li>
  <li>Add more user-defined stop words based on knowledge of the text and create an updated Word Cloud </li>
  <li>Remove some very frequent words</li>
  <li>Control sparse terms: to further remove some very infrequent words</li>
   <li>Perform document clustering and explore results from clustering analyses</li>
 <li>Explore document similarity for text77 and based on the result identify who may have written text 77.</li>
 <li>Since Hamilton wrote all but one of these texts (56 which is Unknown) we can identify that Hamilton may have been the author of text 77.</li>
</ol>

![alt test](/Images/WordCloud2.png)
![alt test](/Images/Cluster.png)
<hr>

<h6>Part III: Topic Modeling</h6>
<ol>
  <li>You can explore with varying k numbers, I chose to show 8, below are the Term-topic probabilities.</li>
  <li>Visualize most common terms in each topic</li>
  <li>Calculate the document-topic probabilities</li>
  <li>View the document Probabilities in a table</li>
</ol>
<hr>

<h6>Part IV: Predicting Authorship</h6>
<ol>
  <li>Prepare the corpus by adding the ID and author columns.</li>
  <li>We will first generate SVD columns based on the entire corpus.  Pre-process the training corpus, further remove very infrequent words, and weight the predictiv DFM by tf-idf.</li>
  <li>Perform SVD for dimension reduction and choose the number of reduced dimensions as 10</li>
  <li>Add the author information as the first column (cut off at six to give a better display)</li>
 <li>Split the data into training & test.  Typically we use random data partition, however, given our specific dataset, we manually split the dataset.  Training dataset contains papers with known author information and the test dataset contains papers with unknown author information.</li>
  <li>Need to drop the unused unknown level in the training dataset, build a logistic model based on the training dataset, and compare model prediction with known authorships</li>
 <li>Predict authorship for the test dataset and View results</li>
</ol>
<hr>
