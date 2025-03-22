# Reqired libraries 
library(tidyverse)
library(farff)
library(pdftools)
library(dplyr)

# List of names and descriptions
attr_table <- read.csv("Attributes.csv")

# Load in feature variants from test set with names
Features_Variant_1 <- read.csv("Dataset/Training/Features_Variant_1.csv", header = FALSE, col.names = attr_table$Name)
Features_Variant_2 <- read.csv("Dataset/Training/Features_Variant_2.csv", header = FALSE, col.names = attr_table$Name)
Features_Variant_3 <- read.csv("Dataset/Training/Features_Variant_3.csv", header = FALSE, col.names = attr_table$Name)
Features_Variant_4 <- read.csv("Dataset/Training/Features_Variant_4.csv", header = FALSE, col.names = attr_table$Name)
Features_Variant_5 <- read.csv("Dataset/Training/Features_Variant_5.csv", header = FALSE, col.names = attr_table$Name)

# Check size of each variant 
nrow(Features_Variant_1)
nrow(Features_Variant_2)
nrow(Features_Variant_3)
nrow(Features_Variant_4)
nrow(Features_Variant_5)

# For EDA purposes only, merging all datasets and 
# adding a variable to indicate which variant the set came from 
Features_Variant_1 <- Features_Variant_1 %>% mutate(variant = 1)
Features_Variant_2 <- Features_Variant_2 %>% mutate(variant = 2)
Features_Variant_3 <- Features_Variant_3 %>% mutate(variant = 3)
Features_Variant_4 <- Features_Variant_4 %>% mutate(variant = 4)
Features_Variant_5 <- Features_Variant_5 %>% mutate(variant = 5)

# Merge all feature sets 
dataset <- bind_rows(
  Features_Variant_1, 
  Features_Variant_2,
  Features_Variant_3,
  Features_Variant_4,
  Features_Variant_5
)

# Verify merge - correct number of rows? 
nrow(dataset) == sum(nrow(Features_Variant_1),
                     nrow(Features_Variant_2),
                     nrow(Features_Variant_3),
                     nrow(Features_Variant_4),
                     nrow(Features_Variant_5))

nrow(dataset)
nrow(dataset[dataset$Basetime < 24,])


# Explore "Page Category" feature 
unique(dataset$PageCategory)

## Convert vars "Page Category" column to text (more descriptive for feature analysis)
# Read all categories from category pdf 
# This code is not very clear... see https://bookdown.org/kochiuyu/Technical-Analysis-with-R/pdf-files.html for reference 
page_categories <- pdf_text("Dataset/Catagory_File - Feature 4.pdf")
rows <- scan(textConnection(page_categories), what="character", sep = "\n")

# Create DF with category and index 
page_categories_df <-  tibble(
  category = rows, 
  code = seq(1, length(rows), by = 1)
)
# head(page_categories_df)

# Add category to main dataset df 
dataset <- left_join(x = dataset, y = page_categories_df, by = c("PageCategory" = "code"))
### Note-to-self: This needs a sweep to verify results! ### 
# View(dataset)


## Select desired variables. Drop un-required vars. 


## Create features for day of week for base and post day of week 

nrow(dataset[dataset$Basetime < 24,])