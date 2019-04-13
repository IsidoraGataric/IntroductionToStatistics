#################### Intro to R.

# Installing the packages (definitely, you will not need this all yet).
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

# Repeat the entire code from the previous lecture (Lecture2.r), it is very closely related to this one.

#################### Factors

# Creating vector and factor (from this vector).

rm(list=ls(all=TRUE))
x <- c(rep("male", 5), rep("female", 5))
y <- factor(x)
y

# [1] male   male   male   male   male   female female female female female
# Levels: female male

is.factor(y)

# [1] TRUE

# When this can be very useful for us?! When we have some numbers, and we need to make intervals (factor levels) of these numbers and therefore we also make a factor of numerical data.

cut(1:9, 3) 
# [1] (0.992,3.67] (0.992,3.67] (0.992,3.67] (3.67,6.33]  (3.67,6.33] 
# [6] (3.67,6.33]  (6.33,9.01]  (6.33,9.01]  (6.33,9.01] 
# Levels: (0.992,3.67] (3.67,6.33] (6.33,9.01]

x <- cut(1:9, 3)
x
y <- factor(x)
y
is.factor(y)

# Loading and saving factors!

a <- factor(c("alpha", "charly", "bravo"))
a 
# [1] alpha  charly bravo
# Levels: alpha bravo charly

# Save this factor in some existing .txt file.
cat(a, sep="\n", file=file.choose())

# Why does R give us numbers 1, 2, 3 ?! Because he only recognizes the levels of some factor (we did not define him as a vector with textual data).
cat(as.vector(a), sep="\n", file=file.choose())

# Editing factors

# Defining and printing vectors.

x <- factor(rep(c("long", "intmed", "short"), 1:3))
x
# [1] long   intmed intmed short  short  short 
# Levels: intmed long short

x <- relevel(x, "short")
x
# [1] long   intmed intmed short  short  short 
# Levels: short intmed long

# If we want this to be sorted from the last level (third) to the first (first).

x <- factor(x, levels=levels(x)[3:1])
x
# [1] long   intmed intmed short  short  short 
# Levels: long intmed short

# Rename of the existing level.
levels(x)[2] <- "intermed"
x
# [1] long     intermed intermed short    short    short   
# Levels: long intermed short

# Changing one particular element from the data set.
x[3] <- "short"
x
# [1] long     intermed short    short    short    short   
# Levels: long intermed short

# If we want to insert some new factor.
x <- factor(rep(c("long", "intermed", "short"), c(1, 1, 4)), levels=c("long", "intermed", "short"))
x <- factor(x, levels=c(levels(x), "supershort"))
x
# [1] long     intermed short    short    short    short   
# Levels: long intermed short supershort

########## Data Frames

# Generating data frames.

rm(list=ls(all=TRUE))
POS <- c("adj", "adv", "n", "conj", "prep")
TOKENFREQ <- c(421, 337, 1411, 458, 455)
TYPEFREQ <- c(271, 103, 735, 18, 37)
CLASS <- c("open", "open", "open", "closed", "closed")

# Creating of data frame.

x <- data.frame(POS, TOKENFREQ, TYPEFREQ, CLASS)
x
#    POS TOKENFREQ TYPEFREQ  CLASS
# 1  adj       421      271   open
# 2  adv       337      103   open
# 3    n      1411      735   open
# 4 conj       458       18 closed
# 5 prep       455       37 closed

# This is very useful, because it gives you the ability to see type of data.
str(x)
# 'data.frame':   5 obs. of  4 variables:
#  $ POS      : Factor w/ 5 levels "adj","adv","conj",..: 1 2 4 3 5
#  $ TOKENFREQ: num  421 337 1411 458 455
#  $ TYPEFREQ : num  271 103 735 18 37
#  $ CLASS    : Factor w/ 2 levels "closed","open": 2 2 2 1 1

# Loading and saving data frames.

# Loading already existing data frames (a bit longer explanation in the book, we will only present here one example).

a2 <- read.table(file.choose(), header=TRUE, sep="\t", quote="", comment.char="", row.names=1)
a2 
str(a2)

# Insert data into existing data frames.
write.table(a2, file.choose(), quote=FALSE, sep="\t", col.names=NA)

# Editing data frames.
rm(list=ls(all=TRUE))
a <- read.delim(file.choose())
a

#    POS TOKENFREQ TYPEFREQ  CLASS
# 1  adj       421      271   open
# 2  adv       337      103   open
# 3    n      1411      735   open
# 4 conj       458       18 closed
# 5 prep       455       37 closed

# Show me the column TOKENFREQ!
a$TOKENFREQ

# Print some specific cases, rows, and columns.

a[2,3]
# [1] 103

a[2,]
# POS TOKENFREQ TYPEFREQ CLASS
# 2 adv       337      103  open

a[,3]
# [1] 271 103 735  18  37

a[2:3, 3:4]
#  TYPEFREQ CLASS
#2      103  open
#3      735  open

# Function WHICH.

which(a[,2]>450)
#[1] 3 4 5

# Access the column CLASS.
attach(a)
CLASS
# [1] open   open   open   closed closed
# Levels: closed open

# Changing values within CLASS.
CLASS[4] <- NA;
CLASS

# Print me "a" data set.
a

# Return CLASS to the starting values.
CLASS[4] <- "closed"

# Work on only one part of the data frame.
b <- a[CLASS=="open",]
b
#  POS TOKENFREQ TYPEFREQ CLASS
#1 adj       421      271  open
#2 adv       337      103  open
#3   n      1411      735  open

# Or even better (I recommend!!!!) create a subset, and you can do what you want on it.
b <-subset(a, CLASS=="open")
b
#  POS TOKENFREQ TYPEFREQ CLASS
#1 adj       421      271  open
#2 adv       337      103  open
#3   n      1411      735  open

# Similar as previously described.
b <-subset(a, POS %in% c("adj", "adv"))
b
#  POS TOKENFREQ TYPEFREQ CLASS
#1 adj       421      271  open
#2 adv       337      103  open

# He sorted all these cases by CLASS (this is not important).
a[order(CLASS, -TOKENFREQ),]
#    POS TOKENFREQ TYPEFREQ  CLASS
# 4 conj       458       18 closed
# 5 prep       455       37 closed
# 3    n      1411      735   open
# 1  adj       421      271   open
# 2  adv       337      103   open

# When sorted by several criteria.
order.index <- order(-rank(CLASS), -rank(POS))
a[order.index, ]
#   POS TOKENFREQ TYPEFREQ  CLASS
#3    n      1411      735   open
#2  adv       337      103   open
#1  adj       421      271   open
#5 prep       455       37 closed
#4 conj       458       18 closed

