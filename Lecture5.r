########################## Descriptive statistics (bivariate)

# Installing the packages.
install.packages("car")
install.packages("amap")
install.packages("aod")
install.packages("cluster")
install.packages("effects")
install.packages("Hmisc")
install.packages("lattice")
install.packages("qcc")
install.packages("plotrix")
install.packages("rms")
install.packages("languageR")
install.packages("rpart")
install.packages("vcd")
install.packages("corpora")

########################## Frequencies and cross-tabs

# What is cross-tabulation? The "analysis" we do when we want to determine the frequency of each of the categories (for example, whether the same number of men and women produced by these three categories of FILLER variable).

# Factor -- sex.
# Dependent variable -- FILLER (3 kategorije). Both, DV & F are categorical variables.
UHM <- read.delim(file.choose())
attach(UHM)

freqs <- table(FILLER, SEX)
freqs
#         SEX
#FILLER    female male
#  silence    171  161
#  uh         161  233
#  uhm        170  104

# Percentages.
percentages <- prop.table(table(FILLER, SEX), margin=2)
percentages

#FILLER       female      male
#  silence 0.3406375 0.3232932
#  uh      0.3207171 0.4678715
#  uhm     0.3386454 0.2088353

# MARGIN = 1; MARGINE = 2?! Difference: margin 2 is a better option because it is the sum of all the levels of the variable, when the margin is 1 then you can see only the relationship between 2 levels of one factor (MALE vs. FEMALE), but not the ratio of that level to others (for e.g. MALE/SMOKE, MALE/NO-SMOKE, FEMALE/SMOKE, FEMALE/NO-SMOKE).
addmargins(freqs)

########################## Bar plots and mosaic plots

plot(FILLER~SEX)
plot(GENRE,FILLER)
plot(table(GENRE,FILLER))
mosaicplot(table(GENRE,FILLER))

########################## Spineplots

# These graphics are for cases where your DV is categorical (nominal) and IV (independent variable) is continuous (interval / ratios).
spineplot(FILLER~LENGTH)

########################## Line plots

fill.table <- prop.table(table(FILLER, SEX), 2)
fill.table
#         SEX
#FILLER       female      male
#  silence 0.3406375 0.3232932
#  uh      0.3207171 0.4678715
#  uhm     0.3386454 0.2088353

plot(fill.table[,1], ylim=c(0, 0.5), xlab="Disfluency", ylab="Prop", type="b")
points(fill.table[,2], type="b")

########################## Means

# Reverse case, DV is continuous (interval/ratios), IV/Factor is categorical (nominal). 
mean(LENGTH[SEX == "female"])
# [1] 928.3984
mean(LENGTH[SEX == "male"])
# [1] 901.5803
tapply(LENGTH, SEX, mean)
#  female     male 
#928.3984 901.5803 

########################## Boxplots

boxplot(LENGTH~GENRE, notch=TRUE, ylim=c(0, 1600))

########################## Interaction plots

interaction.plot(FILLER, SEX, LENGTH)
grid()
interaction.plot(SEX, FILLER, LENGTH)
grid()

interaction.plot(SEX, FILLER, LENGTH, ylim=c(0, 1000))
interaction.plot(FILLER, SEX, LENGTH, ylim=c(0, 1000))
interaction.plot(SEX, FILLER, LENGTH, ylim=range(LENGTH))
interaction.plot(SEX, FILLER, LENGTH, ylim=range(LENGTH))

########################## Correlation coefficients

# Both variables are interval level of measure. 
rm(list=ls(all=TRUE))

# Loading new data set.
ReactTime <- read.delim(file.choose())
str(ReactTime)
attach(ReactTime)

plot(MS_LEARNER~LENGTH, xlim=c(0, 15), ylim=c(0, 300), xlab="Word length in letters", ylab="Reaction time of learningers in ms")
grid()

covariance <- sum((LENGTH-mean(LENGTH))*(MS_LEARNER-mean(MS_LEARNER)))/(length(MS_LEARNER)/1)
covariance <- cov(LENGTH, MS_LEARNER)
covariance
# [1] 79.28947

# Pay attention on method, we calculated here Pearson correlation, but you have Spearman Rho, or Kendall Tau? We'll talk about it later.
cor(MS_LEARNER, LENGTH, method="pearson")
# [1] 0.9337171
