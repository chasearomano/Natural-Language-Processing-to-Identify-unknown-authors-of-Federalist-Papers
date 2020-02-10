# Exploring Unknown Authours <br> for 12 Federalist Papers

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
  <li>Add more user-defined stop words based on knowledge of the text and create an updated Word Cloud</li>
  <li>Remove some very frequent words</li>
  <li>Control sparse terms: to further remove some very infrequent words</li>
   <li>Perform document clustering and explore results from clustering analyses</li>
 <li>Explore document similarity for text77 and based on the result identify who may have written text 77.</li>
 <li>Since Hamilton wrote all but one of these texts (56 which is Unknown) we can identify that Hamilton may have been the author of text 77.</li>
</ol>
 
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
