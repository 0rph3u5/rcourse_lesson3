## READ IN DATA ####
source("scripts/rcourse_lesson3_cleaning.R")


## LOAD PACKAGES ####
library(ggplot2)


## ORGANIZE DATA ####
# Full season data
data_figs = data_clean %>%
  # Change order of level of variables for figure
  mutate(allstar_break = factor(allstar_break, levels = c("before", "after")))

# Summarise full season data by All-Star break
data_figs_sum = data_figs %>%
  # Select what to group the data by
  group_by(allstar_break) %>%
  # Select summarized value to be created
  summarise(wins_perc = mean(win) * 100) %>%
  # Ungroup data
  ungroup()

# Player specific data
data_posey_figs = data_posey_clean

# Summarise player specific data by if walked or not
data_posey_figs_sum = data_posey_figs %>%
  # Select what to group the data by
  group_by(walked) %>%
  # Select summarized value to be created
  summarise(wins_perc = mean(win) * 100) %>%
  # Ungroup data
  ungroup()
  

## MAKE FIGURES ####
# All-Star break
allstar.plot = ggplot(data_figs_sum, aes(x = allstar_break, y = wins_perc)) +
  # Make the figure a barplot
  geom_bar(stat = "identity") +
  # Set y-axis to range from 0 to 100
  ylim(0, 100) +
  # Add a title
  ggtitle("Percentage of Games Won\nBefore and After All-Star Break") +
  # Customize the x-axis
  xlab("Before or after All-Star break") +
  # Customize the y-axis
  ylab("Percentage of games won") +
  # Remove dark background
  theme_bw() +
  # Additional paramaters for displaying plot
  theme(text=element_text(size=18), title=element_text(size=18),
        panel.border = element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"),
        legend.position="none", legend.key=element_blank(),
        strip.background = element_rect(color="white", fill="white"))

# Write figure to a pdf in the 'figures' folder
pdf("figures/allstar.pdf")
allstar.plot
# Close pdf call
dev.off()

# Posey walked or not
posey_walked.plot = ggplot(data_posey_figs_sum, aes(x = walked, y = wins_perc)) +
  # Make the figure a barplot
  geom_bar(stat = "identity") +
  # Set y-axis to range from 0 to 100
  ylim(0, 100) +
  # Add a title
  ggtitle("Percentage of Games Won\nDepending on if Posey Walked or Not") +
  # Customize the x-axis
  xlab("Posey walked during game or not") +
  # Custoize the y-axis
  ylab("Percentage of games won") +
  # Remove dark background
  theme_bw() +
  # Additional paramaters for displaying plot
  theme(text=element_text(size=18), title=element_text(size=18),
        panel.border = element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"),
        legend.position="none", legend.key=element_blank(),
        strip.background = element_rect(color="white", fill="white"))

# Write figure to a pdf in the 'figures' folder
pdf("figures/posey_walked.pdf")
posey_walked.plot
# Close pdf call
dev.off()






