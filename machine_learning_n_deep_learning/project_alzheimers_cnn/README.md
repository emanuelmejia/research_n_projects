# Alzheimer’s Progression: An Image Classification project using MRI Data

We applied 7 machine learning models to classify brain MRIs into four possible Alzheimer's stages, namely Multi-Class Logistic Regression, K-means clustering, K nearest neighbor, Decision Trees, Random Forest, Neural Networks and Convolutional Neural Networks.

Our dataset consisted of more than 6K images, preprocessed and labeled into one of the four stages (Non Demented, Very Mild Demented, Mild Demented, Moderate Demented). As part of the data engineering process we used a data augmentation process to generate synthetic data to balance our dataset. Afterwards, we ran a Principal Component Analysis which reduced our features per image from 49,125 (128x128x3) to only 225 which contained more than 85% of the variation.

Our best model (feed-forward Neural Network) achieved an accuracy of almost 97% in the testing dataset, with all metrics above 98% for the two most advanced stages (Mild and Moderate Demented).
