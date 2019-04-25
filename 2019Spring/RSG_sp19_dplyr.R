"""
tutorial from: https://genomicsclass.github.io/book/pages/dplyr_tutorial.html
"""

#Rstudio
#dplyr
#dplyr cheat sheet
#downlaod msleep.csv (on github)
#git
install.packages('[package]')

setwd('[WD]')

getwd()

msleep<-read.csv('[PATH]', header = [TRUE/FALSE])

#check out msleep -- how can we check that msleep loaded properly?
"""
Functions in dplyr:
select()  - pull out columns
filter()  - filter rows
arrange() - re-arrange/sort rows
mutate()  - make new columns
summarise() - summarise columns
group_by()  - allows group operations 
"""

#What's a 'tibble'????
#`dplyr` and other packages in tidyverse 
#Some useful advantages over dataframe:
###Only prints first 10 rows of data
###Type printed above column
###Never converts strings to factors
###Some nuanced subsetting differences
#More info here: https://blog.rstudio.com/2016/03/24/tibble-1-0-0/

###`select()` (select columns)
#select the msleep, name and sleep_total columns (base and dplyr)


#select all columns except a specific column (base and dplyr)


#select a range of columns (base and dplyr)


#select only columns starting with "sleep" using starts_with("[thing]") argument



##additionally ends_with(), contains(), matches(regex), one_of(vector of names)



###`filter()` (filter rows)

#single filter:
#retain rows where total sleep is >= 16 (base and dplyr)

#>1 filter:
#retain rows with total sleep >=16 and body weight >=1

#retain only rows with species in the orders Perissodactlya and Primate using %in%



##COMBINING FILTERS -- what if we want to pull out some columns, and then filter some rows?

#nest functions or use intermediate objects



#OR the pipe operator %>% for neater syntax


#make a dataframe containing only domesticated species, only containing taxonomic info



#Use arrange() to order this by order



#Make a new column called rem_proportion, which is the proportion of sleep time spent in REM
#Make a column called bodywt_grams, which converts Kg measurements to g

#in base R


msleep %>%
  mutate(rem_proportion = sleep_rem / sleep_total) %>%
  head



#Make a summary tibble containint min, max and avg sleep times




#Make a tibble with these same summaries, but grouped by taxonomic order




