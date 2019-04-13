######################### Descriptive statistics

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

# Loading data set.

UHM <- read.delim(file.choose())
str(UHM)
# 'data.frame':   1000 obs. of  5 variables:
#  $ CASE  : int  1 2 3 4 5 6 7 8 9 10 ...
#  $ SEX   : Factor w/ 2 levels "female","male": 2 1 1 1 2 1 2 2 1 2 ...
#  $ FILLER: Factor w/ 3 levels "silence","uh",..: 3 1 1 3 2 2 1 3 3 3 ...
#  $ GENRE : Factor w/ 2 levels "dialog","monolog": 2 2 1 1 1 1 1 2 2 2 ...
#  $ LENGTH: int  1014 1188 889 265 465 1278 671 1079 643 1165 ...
attach(UHM)

# Simple TABLE function allows us to get an insight into the number of data for each category of variables from the data set (that variable FILLER (uh, uhm, silence)).

table(FILLER)
# FILLER
# silence      uh     uhm 
#     332     394     274 

# If you want to get percentages, then divided table(FILLER) with the length of the same variable (length (FILLER)), or just insret prop.table(table(FILLER)).

table(FILLER)/length(FILLER)
# FILLER
# silence      uh     uhm 
#     332     394     274 

prop.table(table(FILLER))
# FILLER
# silence      uh     uhm 
#   0.332   0.394   0.274 

######################### Scatterplots and line plots

# Example 1.
plot(FILLER)

# Example 2. 

a <- c(1, 3, 5, 2, 4)
b <- 1:5

plot(a)
plot(b)

# if the graph is defined in this way, "a" is on the x axis, and "b" is on the y axis. 
plot(a, b)

# If we want to specify a type of graphics, then we type "type = .... (so some letter)" ("l" (line); "p" (points); "b" (both)).
plot(b, a, type="b")
plot(b, a, type="l")

# You can do this and much more complicated.
plot(b, a, xlab="A vector b", ylab="A vector b", xlim=c(0, 8), ylim=c(0,8), type="b")

# Different types of graphics.

m <- 1:5
n <- 5:1
x <- 6:10
y <- 6:10
plot(m, n, type="b")
points(x, y, type ="b")
grid()

# Min and Max, in this example when you use data of different types. 
plot(m, n, type="b", xlim=c(0, max(m, x)), ylim=c(0, max(n, y)), xlab="Vectors m and x", ylab="Vectors n and y")
grid()
points(x, y, type="b")

######################### Pie chart

pie(table(FILLER), col=c("grey20", "grey50", "grey80"))

######################### Bar plot

# Useful when you have nominal/ordinal variable(s).

barplot(table(FILLER), col=c("gray40", "grey60", "grey80"), names.arg=c("Silence", "uh", "uhm"), space=0)
text(c(0.5, 1.5, 2.5), table(FILLER)/2, labels=table(FILLER))

mids <- barplot(table(FILLER), col=c("grey40", "grey60", "grey80"))
text(mids, table(FILLER), labels=table(FILLER), pos=1)

######################### Histogram

# Useful when you have racio/interval variable(s).
hist(LENGTH)
hist(LENGTH, main="", xlab="Length in ms", ylab="Frequency", xlim=c(0, 2000), ylim=c(0, 100), col="grey80")
hist(LENGTH, main="", xlab="Length in ms", ylab="Density", freq=FALSE, xlim=c(0, 2000), col="grey50")
lines(density(LENGTH))

######################### Measures of central tendency

# Mode.

which.max(table(FILLER))
# uh 
#  2 

max(table(FILLER))
# [1] 394

# Median.

median(LENGTH)
# [1] 897

# Mean.

mean(LENGTH)
# [1] 915.043

######################### Dispersion measures

# Never interpret CT measures without some dispersion measures. What measure have we mentioned so far ?! For each data type (and each MCT) there is some appropriate dispersion measure.

Mean -- SD/variance.
Mode -- relative entropy.
Median -- quartiles.

town1 <- c(-5, -12, 5, 12, 15, 18, 22, 23, 20, 16, 8, 1)
town2 <- c(6, 7, 8, 9, 10, 12, 16, 15, 11, 9, 8, 7)
mean(town1)
mean(town2)

# Relative entropy (each entropy is marked with H).

article <- c(164, 33, 103)
perc <- article/sum(article)
hrel <-- sum(perc*log(perc))/log(length(perc))
hrel

# Range.

range(LENGTH)

# Qaurtile/Quantile.

a <- 1:100
#  0%  25%  50%  75% 100% 
#   1   25   50   75  100

quantile(town2)
#   0%   25%   50%   75%  100% 
# 6.00  7.75  9.00 11.25 16.00 

# The larger difference between 1 and 4 quarters is, the Heterogeneous group is. 

# Interpretation:

quantile(LENGTH, probs=c(0.25, 0.5, 0.75, 1))

# 25%  50%  75% 100% 
# 583  897 1242 1600 

# SD (Standard deviation).

# A measure that tells us how many individual observations deviate from AS, this measure is squared, then all the values obtained are summed and eventually divided by n-1 (Bassel's correction).

sd(town1)
sd(town2)

# Step by step.

town1
town1-mean(town1)
(town1-mean(town1))^2
sum((town1-mean(town1))^2)
sum((town1-mean(town1))^2)/(length(town1)-1)
sqrt(sum((town1-mean(town1))^2)/(length(town1)-1))

# Variance.

# It counts over SD (and represents normalized SD, so we can compare it with other data sets).

sd(town1)/mean(town1)
sd(town1*10)/mean(town1*10)

# Summary function.

summary(town1)

#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -12.00    4.00   13.50   10.25   18.50   23.00

# Boxplots (tell us about dispersion of the data).

boxsum <- boxplot(town1, town2, notch=TRUE, names=c("Town1", "Town2"))
text(1:2, c(mean(town1), mean(town2)), c("+", "+"))
