# Getting-and-Cleaning-Data-Project

This project is part of a requirement for Getting and Cleaning Data. This is to demonstrate on how to get and clean the datasets.
The raw dataset used for this project comes from the research paper which recognizes Human Activity through Smartphones sensor (Anguita et.al, 2012).

The source code - "run_analysis.R" - generates a tidy dataset which:
1. Reads all the raw datasets;
2. Merges the training and test datasets from the raw dataset;
3. Filters all the mean and std features from the merged dataset;
4. Adds descriptive labels / variable names from the filtered dataset;
5. Computes the mean of all variables by subject and activity; and
6. Export the tidy dataset as .txt


Reference:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
