"""
tutorial from: https://genomicsclass.github.io/book/pages/dplyr_tutorial.html
"""

#Rstudio
#dplyr
#dplyr cheat sheet
#downlaod msleep.csv (on github)
#git
install.packages('[package]')

msleep<-read.csv('/Users/m/RStudyGroup/2019Spring/msleep.csv', header = TRUE)

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
#select the name and sleep_total columns from msleep(base and dplyr)

msleep_sub<-select(msleep, name, sleep_total)

#select all columns except a specific column (base and dplyr)

msleep_sub2<-msleep[,-4]

msleep_sub2<-select(msleep, -order)

#select a range of columns (base and dplyr)

msleep_sub3<-msleep[,1:4]

msleep_sub3<-select(msleep, name:order)

#select only columns starting with "sleep" using starts_with("[thing]") argument

msleep_sub4<-select(msleep, starts_with("sleep"))

##additionally ends_with(), contains(), matches(regex), one_of(vector of names)



###`filter()` (filter rows)

#single filter:
#retain rows where total sleep is >= 16 (base and dplyr)

msleep_sub5<-filter(msleep, sleep_total >= 16)

#>1 filter:
#retain rows with total sleep >=16 and body weight >=1

msleep_sub6<-filter(msleep, sleep_total >= 16, bodywt >= 1)

#retain only rows with species in the orders Perissodactlya and Primate using %in%

msleep_sub7<-filter(msleep, order %in% c('Perissodactyla', 'Primates'))

##COMBINING FILTERS -- what if we want to pull out some columns, and then filter some rows?

#nest functions or use intermediate objects

filter(select(msleep, name, genus, order, conservation), conservation == 'domesticated')


#OR the pipe operator %>% for neater syntax

#make a dataframe containing only domesticated species, only containing taxonomic info

msleep_sub8<-filter(msleep, conservation == 'domesticated') %>%
  select(name, genus, order, conservation) %>%
  arrange(order)

#Use arrange() to order this by order
#see above
msleep_sub9<-arrange(msleep_sub8, order)


#Make a new column called rem_proportion, which is the proportion of sleep time spent in REM
#Make a column called bodywt_grams, which converts Kg measurements to g

msleep_sub10<-mutate(msleep, rem_proportion = sleep_rem/sleep_total, bodywt_grams = bodywt * 1000)

#in base R


#Make a summary tibble containint min, max and avg sleep times




#Make a tibble with these same summaries, but grouped by taxonomic order




