## READ IN DATA ####
source("scripts/rcourse_lesson3_cleaning.R")


## LOAD PACKAGES ####
# [none currently needed]


## ORGANIZE DATA ####
# Full season data
data_stats = data_clean

# Player specific data
data_posey_stats = data_posey_clean


## BUILD MODEL - FULL SEASON DATA ####
# Make logistic regression model
allstar.glm = glm(win ~ allstar_break, family = "binomial", data = data_stats)

# Summarise model and save
allstar.glm_sum = summary(allstar.glm)

# Call summary of model
allstar.glm_sum


## BUILD MODEL - PLAYER SPECIFIC DATA ####
# Make logistic regression model
posey_walked.glm = glm(win ~ walked, family = "binomial", data = data_posey_stats)

# Summarise model and save
posey_walked.glm_sum = summary(posey_walked.glm)

# Call summary of model
posey_walked.glm_sum






