if (!require("pacman")) install.packages("pacman"); library(pacman); pacman::p_load(tidyverse, reshape2)
n=88
dat <- data.frame(patient_id = 1:n, 
           hospital_id = sample(1:5, size=n, replace=TRUE, prob=rep(1/5,5)), # 5 hospitals
           year = sample(2005:2015, size=n, replace=TRUE, prob=rep(1/11, 11)), # years 2005-2015
           age = rnorm(n, mean=65, sd=5),
           female = rbinom(size=1, n, prob=0.5))
# this step creates a simulated dataset with 'n' patients in it
# the simulated dataset has variables for patient_id, hospital_id, year of operation, age, and sex.

hospital_freq <- with(dat, table(hospital_id, year)) %>% 
  reshape2::melt(., id="hospital_id", value.name="hospital_frequency") # this creates a frequency table of number of operations by each hospital each year

dat2 <- left_join(dat, hospital_freq, by=c("hospital_id", "year")) # merges the original dataset with the frequency table, basically adding a covariate for hospital volume
