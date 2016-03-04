## LOAD PACKAGES ####
library(dplyr)


## READ IN DATA ####
# Read in full season data
data = read.table("data/rcourse_lesson3_data.txt", header=T, sep="\t")

# Read in player (Buster Posey) specific data
data_posey = read.table("data/rcourse_lesson3_data_posey.txt", header=T, sep="\t")


## CLEAN DATA ####
# Add columns to full season data to make data set specific to the Giants
data_clean = data %>%
  # Make a column for if the Giants were the home or visiting team
  mutate(home_visitor = ifelse(home_team == "SFN", "home", "visitor")) %>%
  # Make a column for if the game was before or after the All-Star break
  mutate(allstar_break = ifelse(date < 20100713, "before", "after")) %>%
  # Make win-loss column
  mutate(win = ifelse(home_team == "SFN" & home_score > visitor_score, 1,
                      ifelse(visitor_team == "SFN" & home_score < visitor_score, 1, 0))) %>%
  # Make columns for Giants' stats
  mutate(giants_hits = ifelse(home_team == "SFN", home_hits, visitor_hits)) %>%
  mutate(giants_pitchers_used = ifelse(home_team == "SFN", home_pitchers_used, visitor_pitchers_used)) %>%
  mutate(giants_errors = ifelse(home_team == "SFN", home_errors, visitor_errors)) %>%
  # Make columsn for other team's stats
  mutate(other_hits = ifelse(home_team != "SFN", home_hits, visitor_hits)) %>%
  mutate(other_pitchers_used = ifelse(home_team != "SFN", home_pitchers_used, visitor_pitchers_used)) %>%
  mutate(other_errors = ifelse(home_team != "SFN", home_errors, visitor_errors)) %>%
  # Make a column for game number
  arrange(date) %>%
  mutate(game_number = row_number())

# Combine full season data with player (Buster Posey) specific data and clean
data_posey_clean = data_posey %>%
  # Join with full season data
  inner_join(data_clean) %>%
  # Make a column for if walked or not
  mutate(walked = ifelse(walks > 0, "yes", "no"))

# Check size of player specific data to be sure inner_join() worked correctly
dim(data_posey)
dim(data_posey_clean)






