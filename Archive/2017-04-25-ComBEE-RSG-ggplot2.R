#2017-04-25 ComBEE R Study Group: ggplot2/cowplot

#Load packages
library(dplyr)
library(ggplot2)
library(knitr)

#Load in the data
fielddata <- read.csv("~/Desktop/McMahon-Lab/Lab-Data/Environmental-Data/Data/2016-Field-Data.csv")
mendotabuoy <- read.csv("~/Desktop/McMahon-Lab/Lab-Data/Environmental-Data/Data/mendota_buoy_data.csv")

#Surveying the data: Field Data for Lake Mendota, Sparkling Lake, and Trout Bog Lake
head(fielddata)
colnames(fielddata)
dim(fielddata)
summary(fielddata)

#Counts of each observation type in list form
table(fielddata$Lake)

#Select rows with Lake Mendota
mendotafield <- filter(fielddata, Lake=="Mendota")
head(mendotafield)
dim(mendotafield) #check that rows of Mendota = count of table Lake types

#Sparkling Lake separated dataframe
sparklingfield <- filter(fielddata, Lake=="Sparkling")
head(sparklingfield)
dim(sparklingfield)

#TroutBog separated dataframe
troutbogfield <- filter(fielddata, Lake=="TroutBog")
head(troutbogfield)
dim(troutbogfield)

#Test my data merging skills to see if I can put the data back together at a similar place
#Instead of putting it back together, to have dataset with just TroutBog and Mendota, filtered out
#Sparkling Lake with dplyr, easier than merge and trying to filter two observations of same vector
nosparkling <- fielddata %>% filter(Lake != "Sparkling")

#View something with just a certain few columns using dplyr pipes, filters, and select
head(nosparkling)
nosparkling %>% head() %>% select(Depth, Temperature)
nosparkling %>% head() %>% select(Lake, Depth, Temperature)

#Plots of separate lakes with differing factors at timepoints
#Mendota chlorophyll
colnames(mendotafield)
mendotafield %>% 
ggplot(mendotafield) + geom_col(aes(x=Timepoint, y=Chlorophyll), fill="slateblue")
help(geom_bar)
head(mendotafield)
#TroutBog chlorophyll
ggplot(troutbogfield) + geom_col(aes(x=Timepoint, y=Chlorophyll), fill="violet")

#Facet chlorophyll vs timpepoint by lake
ggplot(fielddata) + geom_col(aes(x=Timepoint, y=Chlorophyll), fill="slateblue") + facet_wrap(~Lake) + labs(title = "Wisconsin Lakes Chlorophyll Production")
head(fielddata)

#Facet phycocyanin vs timepoint by lake
ggplot(fielddata) + geom_col(aes(x=Timepoint, y=Phycocyanin), fill="green") + facet_wrap(~Lake) + labs(title="Wisconsin Lakes Phycocyanin Production")

#Facet protein production 
colnames(fielddata)
ggplot(fielddata) + geom_col(aes(x=Timepoint, y=Production), fill="orange") + facet_wrap(~Lake) + labs(title = "Wisconsin Lakes Protein Production")

#Facet temperature
ggplot(fielddata) + geom_col(aes(x=Timepoint, y=Temperature), fill="red") + facet_wrap(~Lake) + labs(title="Wisconsin Lakes Temperatures")



#BDS Examples

#Write results out to a .txt file 
#First assign some results to a certain variable
summary <- summary(data1)
#Then use writeLines to write out to a text file
writeLines(summary, "summarydata.txt")

#Adding columns centromere and diversity scaled up
data1$cent <- data1$start >= 25800000 & data1$end <= 29700000
data1$diversity <- data1$Pi / (10*1000)

#Add position = midpoint
data1$position <- (data1$end + data1$start) /2

#GGPLOT
#ggplot with pipes, make sure to load in dplyr
plot1 <- data1 %>% ggplot(aes(x=position, y=diversity)) + geom_point(color="slateblue", size=0.5)
plot1
head(data1)

#Map color aesthetic with the cent column
plot1 + geom_point(aes(color=cent))

#Make some points transparent so not overplotting
plot1 + geom_point(alpha=0.01) #This did a weird color thing with transparency 
#Doing what the book says: 
ggplot(data1) + geom_point(aes(x=position,y=diversity), alpha=0.01)

#Density of diversity, using geom_density, to solve overplotting issue
ggplot(data1) + geom_density(aes(x=diversity),fill="black")
ggplot(data1) + geom_density(aes(x=diversity),fill="slateblue")
#Create separate density plots by mapping the color to different columns
ggplot(data1) + geom_density(aes(x=diversity, fill=cent), alpha=0.4)

#Smoothing features
#superimpose a smooth curve 
ggplot(data1, aes(x=depth, y=total.SNPs)) + geom_point() + geom_smooth()

#2017-03-01: Starting with Merging and Combining Data
#Using the %in% operator to check if vector's values are in another vector
c(3,4,-1) %in% c(1,3,4,8)
#Use %in% to specify the rows in a dataframe to select by
#Use the dataset chrX_rmsk.txt
reps <- read.delim("~/Desktop/Programming/bds-wd/chapter-08-r/Data/chrX_rmsk.txt.gz", header=TRUE)
head(reps,3)
class(reps$repClass)
levels(reps$repClass)
#create vector common_repclass using %in%
common_repclass <- c("SINE", "LINE", "LTR", "DNA", "Simple_repeat")
reps[reps$repClass %in% common_repclass, ]
#Calculating the 5 most common repeat classes to create vectors manually 
sort(table(reps$repClass), decreasing=TRUE)[5:1]
top5_repclass <- names(sort(table(reps$repClass), decreasing=TRUE)[1:5])
top5_repclass
# %in% is simplified for match(), can return T/F, whereas match returns first occurrence 
#If match can't find the x element in y, it returns NA
#Directionality of match: x - what searching for, y = haystack (x,y)
match(c("A", "C","E","A"), c("A", "B", "A", "E"))
#Merging two datasets to explore recombination rate around a sequence motif in repeats
mtfs <- read.delim("~/Desktop/Programming/bds-wd/chapter-08-r/Data/motif_recombrates.txt", header=TRUE)
head(mtfs,3)
rpts <- read.delim("~/Desktop/Programming/bds-wd/chapter-08-r/Data/motif_repeats.txt", header=TRUE)
head(rpts,3)
#We want to merge the column name in rpts with mtfs, we know what each repeat of motif it has
# Link = position of each motif, the chromosome ID and motif start position, chr and motif_start
#Merge the two columns into a single string with paste()
mtfs$pos <-paste(mtfs$chr, mtfs$motif_start, sep="-")
rpts$pos <-paste(rpts$chr, rpts$motif_start, sep="-")
head(mtfs,2)
head(rpts,2)
#Here, you created a column $pos in both the mtfs and rpts that combined the chr name 
#and also the motif_start, which was the common link between the two dataframes
#by pasting into a new column and separating with -, give something common to merge together
#Now have a common KEY
#To then merge the data, validate that the keys overlap before merging, use table() and %in%
table(mtfs$pos %in% rpts$pos)
#match to find where the $pos occurs in each, and create an indexing vector
index <- match(mtfs$pos, rpts$pos)
#If motif positions do not have corresponding entry in repeats, they are NA, which is not
table(is.na(index))
#Use the index vector to merg into mtfs 
mtfs$repeat_name <- rpts$name[index]
#Another way is to skip the assigning with the index, and use directly:
mtfs$repeat_name <- rpts$name[match(mtfs$pos, rpts$pos)]
#Validate
head(mtfs[!is.na(mtfs$repeat_name), ], 3)
#Remove the NAs where motifs don't have entries in rpts
mtfs_inner <- mtfs[!is.na(mtfs$repeat_name), ]
nrow(mtfs_inner)
#Merge function
recm <- merge(mtfs, rpts, by.x="pos", by.y="pos")
head(recm,2)
#Merge takes the two dataframes, x and y, and joins by columns that are the key 
recm <- merge(mtfs, rpts, by.x="pos", by.y="pos", all.x=TRUE)


#Faceting with ggplot
#I've merged the two datasets, now explore
#Facet= view grouped data by creating separate adjacent plots
#Recombination rate and distance to a motif with mtf dataframe
colnames(mtfs)
plot1 <- ggplot(mtfs,aes(x=dist,y=recom)) + geom_point(size=1)
plot1 <- plot1 + geom_smooth(method="loess", se=FALSE, span=1/10)
plot1
#Turned off geom_smooth standared error, adjust smoothing with span, method to loess
plot2 <- plot1 + geom_smooth()
plot2
plot3 <- plot1 + geom_smooth(se=FALSE)
plot3
plot4 <- plot1 + geom_smooth(se=FALSE, method="loess")
plot4
plot5 <- plot1 + geom_smooth(method="loess", se=FALSE, span=1/5)
plot5
plot6 <- plot1 + geom_smooth(method="loess", se=FALSE, span=1/10)
plot6
#Large amount of heterogeneity maybe not accounting for, wash out signal. Facet out
unique(mtfs$motif)
#Noticeable differences of motifs on recombination?
ggplot(mtfs,aes(x=dist, y=recom)) + geom_point(size=1) + geom_smooth(aes(color=motif), method="loess", se=FALSE, span=1/10)
#Color by motif with smoothing feature, or facet the different motifs: 
plotorig <- ggplot(mtfs,aes(x=dist, y=recom)) + geom_point(size=1, color="grey")
plotsmoother <- plotorig + geom_smooth(method="loess", se=FALSE, span=1/10)
plotfacet <- plotsmoother + facet_wrap(~ motif)
plotfacet
#Two ways to facet: facet_wrap and facet_grid
#Wrap takes the column and creates a panel for each level, wraps around horizontally
#Grid allows for finer control of the facet to specify the column to use for vertical and horizontal facet
#Using facet_grid:
plotorig2 <- ggplot(mtfs, aes(x=dist, y=recom)) + geom_point(size=0.5, color="red")
plotsmoother2 <- plotorig2 + geom_smooth(method="loess", se=FALSE, span=1/16)
plotfacetgrid <- plotsmoother2 + facet_grid(repeat_name ~ motif)
plotfacetgrid
# ~ is used with wrap and grid to specify the model formula 
# Can also change the scale argument to be free
plotfree <- ggplot(mtfs, aes(x=dist, y=recom)) + geom_point(size=0.5, color="green")
plotfreesmooth <- plotfree + geom_smooth(method="loess", se=FALSE, span=1/10)
plotfreewrap <- plotfreesmooth + facet_wrap(~ motif, scale="free_y")
plotfreewrap
#Use facet to look at data when grouped by chromosome
plotchr <- ggplot(mtfs,aes(x=dist, y=recom)) + geom_point(size=0.5, color="violet")
plotchrsmooth <- plotchr + geom_smooth(method="loess", se=FALSE, span=1/10) 
plotchrwrap <- plotchrsmooth + facet_wrap(~ chr, scale="free_y")
plotchrwrap