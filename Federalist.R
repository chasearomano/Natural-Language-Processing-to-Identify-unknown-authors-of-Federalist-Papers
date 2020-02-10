# Objective: to predict authorship for 12 federalist papers
# Quanteda tutorial: https://tutorials.quanteda.io

# Read data
papers <- read.csv('federalist.csv',stringsAsFactors = F)

###############################################################
# Part I: Initial exploration

dim(papers)
table(papers$Author)

# Narrow down to papers written by Hamilton/Madison/Unknown
papers <- papers[which(papers$Author=="HAMILTON"|
                         papers$Author=="MADISON"|
                         papers$Author=="UNKNOWN"),]
table(papers$Author)

# Order records based on author
papers <- papers[order(papers$Author),]

# Remove "To the People of the State of New York: "
papers$Text <- substring(papers$Text,40)

# Establish the corpus and initial DFM matrix
library(quanteda)
myCorpus <- corpus(papers$Text)

summary(myCorpus)
myDfm <- dfm(myCorpus)

# Simple frequency analyses
tstat_freq <- textstat_frequency(myDfm)
head(tstat_freq, 20)

# Visulize the most frequent terms
library(ggplot2)
myDfm %>% 
  textstat_frequency(n = 20) %>% 
  ggplot(aes(x = reorder(feature, frequency), y = frequency)) +
  geom_point() +
  labs(x = NULL, y = "Frequency") +
  theme_minimal()

# Wordcloud
textplot_wordcloud(myDfm,max_words=200)

###############################################################
#Part II: Exploratory analyses with similarity and clustering

# Remove stop words and perform stemming
library(stopwords)
myDfm <- dfm(myCorpus,
             remove_punc = T,
             remove = c(stopwords("english")),
             stem = T)
dim(myDfm)
topfeatures(myDfm,30)

# Add more user-defined stop words
# It is a bit subjective, and exercise your judgement with caution
stopwords1 <-c('may','one','two','can','must',
               'upon','might','shall')

myDfm <- dfm(myCorpus,
             remove_punc = T,
             remove=c(stopwords('english'),stopwords1),
             stem = T) 

dim(myDfm)
topfeatures(myDfm,30)
textplot_wordcloud(myDfm,max_words=200)

# Further remove some very frequency words
stopwords2 <- c('state','govern','power',
                'constitut','nation','peopl')
myDfm <- dfm_remove(myDfm,stopwords2)
topfeatures(myDfm,30)

# Control sparse terms: to further remove some very infrequency words
myDfm<- dfm_trim(myDfm,min_termfreq=4, min_docfreq=2)
dim(myDfm)

# Perform document clustering
# Explore results from clustering analyses
doc_dist <- textstat_dist(myDfm)
clust <- hclust(as.dist(doc_dist))
plot(clust,xlab="Distance",ylab=NULL)

# Explore document similarity for text77
# Based on the result, do you think who wrote text77?
# You can also explore other similarity measures, such as cosine, 
text_sim <- textstat_simil(myDfm, 
                           selection="text77",
                           margin="document",
                           method="correlation")
as.list(text_sim,n=10)

# Explore terms most similar to "commerc"
# You can also explore other terms, such as "court" and "war"
term_sim <- textstat_simil(myDfm,
                           selection="commerc",
                           margin="feature",
                           method="correlation")
as.list(term_sim,n=8)

###############################################################
#Part III: Topic Modeling
library(topicmodels)
library(tidytext)

# Explore the option with 10 topics
# You can explore with varying k numbers
myLda <- LDA(myDfm,k=8,control=list(seed=101))
myLda

# Term-topic probabilities
myLda_td <- tidy(myLda)
myLda_td

# Visulize most common terms in each topic
library(ggplot2)
library(dplyr)

top_terms <- myLda_td %>%
  group_by(topic) %>%
  top_n(8, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip()

# View topic 8 terms in each topic
Lda_term<-as.matrix(terms(myLda,8))
View(Lda_term)

# Document-topic probabilities
ap_documents <- tidy(myLda, matrix = "gamma")
ap_documents

# View document-topic probabilities in a table
Lda_document<-as.data.frame(myLda@gamma)
View(Lda_document)

###############################################################
#Part IV: To predict authorships

# Prepare the corpus by adding the ID and author columns
docvars(myCorpus,"ID") <- papers$ID
docvars(myCorpus, "Author") <- papers$Author
summary(myCorpus,10)


# We will first generate SVD columns based on the entire corpus

# Pre-process the training corpus
modelDfm <- dfm(myCorpus,
                remove_punc = T,
                remove=c(stopwords('english'),stopwords1),
                stem = T) 

# Further remove very infrequent words 
modelDfm <- dfm_trim(modelDfm,min_termfreq=4, min_docfreq = 2)

dim(modelDfm)

# Weight the predictiv DFM by tf-idf
modelDfm_tfidf <- dfm_tfidf(modelDfm)
dim(modelDfm_tfidf)

# Perform SVD for dimension reduction
# Choose the number of reduced dimensions as 10
modelSvd <- textmodel_lsa(modelDfm_tfidf, nd=10)
head(modelSvd$docs)

# Add the author information as the first column
modelData <-cbind(docvars(myCorpus,"Author"),as.data.frame(modelSvd$docs))
colnames(modelData)[1] <- "Author"
head(modelData)

# Split the data into training & test
# Typically we use random data partition
# However, given our specific dataset, we manually split the dataset
# Training dataset contains papers with known author information
# Test dataset contains papers with unknonw author information
trainData <- subset(modelData,Author=="HAMILTON"|Author=="MADISON")
testData <- subset(modelData,Author=="UNKNOWN")

# Need to drop the unused unkown level in the training dataset
str(trainData)
trainData$Author <- droplevels(trainData$Author)
str(trainData)

# Build a logistic model based on the training dataset
regModel <- glm(formula=Author~.,
                family=binomial(link=logit),
                data=trainData)

# Compare model prediction with known authorships
pred <- predict(regModel, newdata=trainData, type='response')
pred.result <- ifelse(pred > 0.5,1,0)
print(table(pred.result, trainData$Author))

# Predict authorship for the test dataset
unknownPred <- predict(regModel, newdata=testData, type='response')
# View results
unknownPred <- cbind(testData$Author,as.data.frame(unknownPred))
print(unknownPred)

