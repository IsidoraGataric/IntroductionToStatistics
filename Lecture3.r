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

# Let's remember it as a factor.

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

# Cuvanje ovog faktora u neki vec postojeci .txt fajl (pogledati .txt nakon ovoga).
cat(a, sep="\n", file=file.choose())

# Zasto nam R daje neke brojeve 1, 2, 3?! Zato sto on samo prepoznaje nivoe nekog faktora (nismo mu definisali da nam je to neki vektor sa tekstualnim podacima).
cat(as.vector(a), sep="\n", file=file.choose())

# Editing factors

# Pravljenje faktora (moze i bez ovoga 1:3!)

x <- factor(rep(c("long", "intmed", "short"), 1:3))
x
# [1] long   intmed intmed short  short  short 
# Levels: intmed long short

x <- relevel(x, "short")
x
# [1] long   intmed intmed short  short  short 
# Levels: short intmed long

# E sada, ako zelimo da nam ovo bude poredjano od poslednjeg nivoa (treceg) do pocetnog (prvog).

x <- factor(x, levels=levels(x)[3:1])
x
# [1] long   intmed intmed short  short  short 
# Levels: long intmed short

# Promena imena nekog nivoa. 
levels(x)[2] <- "intermed"
x
# [1] long     intermed intermed short    short    short   
# Levels: long intermed short

# Promena jednog odredjenog elementa, ne celog nivoa.
x[3] <- "short"
x
# [1] long     intermed short    short    short    short   
# Levels: long intermed short

# Ako zelimo da ubacimo neki novi faktora.
x <- factor(rep(c("long", "intermed", "short"), c(1, 1, 4)), levels=c("long", "intermed", "short"))
x <- factor(x, levels=c(levels(x), "supershort"))
x
# [1] long     intermed short    short    short    short   
# Levels: long intermed short supershort

# Promena jednog odredjenog elementa, ne celog nivoa.
x[6] <- "supershort"
# [1] long       intermed   short      short      short      supershort
# Levels: long intermed short supershort

# Treba da se izbrise neki level pre daljih koraka, to radimo ovako:
x[6] <- "short"
x <- factor(x)
x
# [1] long     intermed short    short    short    short   
# Levels: long intermed short

# Prikazi mi numericki level tog faktora (setimo se onoga 1:3)!
as.numeric(x)
# [1] 1 2 3 3 3 3

########## Data Frames

# Generating data frames (sastoji se od raznih vektora i faktora).

rm(list=ls(all=TRUE))
POS <- c("adj", "adv", "n", "conj", "prep")
TOKENFREQ <- c(421, 337, 1411, 458, 455)
TYPEFREQ <- c(271, 103, 735, 18, 37)
CLASS <- c("open", "open", "open", "closed", "closed")

# Kreiramo nas prvi data frame.

x <- data.frame(POS, TOKENFREQ, TYPEFREQ, CLASS)
x
#    POS TOKENFREQ TYPEFREQ  CLASS
# 1  adj       421      271   open
# 2  adv       337      103   open
# 3    n      1411      735   open
# 4 conj       458       18 closed
# 5 prep       455       37 closed

# Ovo vam je korisnije, jer vam daje mogucnost da vidite tipove podataka.
str(x)
# 'data.frame':   5 obs. of  4 variables:
#  $ POS      : Factor w/ 5 levels "adj","adv","conj",..: 1 2 4 3 5
#  $ TOKENFREQ: num  421 337 1411 458 455
#  $ TYPEFREQ : num  271 103 735 18 37
#  $ CLASS    : Factor w/ 2 levels "closed","open": 2 2 2 1 1

# Loading and saving data frames.

# Ucitavanje vec postojecih data frameova (malo duze objasnjenje u knjizi, ovde cemo samo jedan primer).

a2 <- read.table(file.choose(), header=TRUE, sep="\t", quote="", comment.char="", row.names=1)
a2 
str(a2)

# Upisivanje podataka u postojece data frames.
write.table(a2, file.choose(), quote=FALSE, sep="\t", col.names=NA)

# Editing data frames (ucitavanje matrice sa ovim DELIM skracuje taj put).
rm(list=ls(all=TRUE))
a <- read.delim(file.choose())
a

#    POS TOKENFREQ TYPEFREQ  CLASS
# 1  adj       421      271   open
# 2  adv       337      103   open
# 3    n      1411      735   open
# 4 conj       458       18 closed
# 5 prep       455       37 closed

# Prikazi mi samo kolonu TOKENFREQ!
a$TOKENFREQ

# Pozovanje samo odredjenih slucajeva, redova i kolona.

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

# Malo kompleksnije funkcije i argumenti, sa WHICH.

which(a[,2]>450)
#[1] 3 4 5

# Pristupi koloni nekoj odredjenoj (ps. Na strani 90 (ali i na 92!) u Grisu imate gresku u kucanju, CLASS mora uvek velikim).
attach(a)
CLASS
# [1] open   open   open   closed closed
# Levels: closed open

# Promena vrednosti u okviru CLASS.
CLASS[4] <- NA;
CLASS

#Prikazi mi a.
a

# Vrati CLASS NA na pocetnu vrednost.
CLASS[4] <- "closed"

# Rad na samo jednom delu data frame.
b <- a[CLASS=="open",]
b
#  POS TOKENFREQ TYPEFREQ CLASS
#1 adj       421      271  open
#2 adv       337      103  open
#3   n      1411      735  open

# Ili jos bolje (preporucujem!) napravite subset.
b <-subset(a, CLASS=="open")
b
#  POS TOKENFREQ TYPEFREQ CLASS
#1 adj       421      271  open
#2 adv       337      103  open
#3   n      1411      735  open

# Ista fora, malo kompleksniji primer.
b <-subset(a, POS %in% c("adj", "adv"))
b
#  POS TOKENFREQ TYPEFREQ CLASS
#1 adj       421      271  open
#2 adv       337      103  open

# Sortirao je sve te slucajeve po CLASS (ovo nije vazno uopste, nego pratimo njegovu knjigu).
a[order(CLASS, -TOKENFREQ),]
#    POS TOKENFREQ TYPEFREQ  CLASS
# 4 conj       458       18 closed
# 5 prep       455       37 closed
# 3    n      1411      735   open
# 1  adj       421      271   open
# 2  adv       337      103   open

# Kada se sortira po vise nekih kriterijuma.
order.index <- order(-rank(CLASS), -rank(POS))
a[order.index, ]
#   POS TOKENFREQ TYPEFREQ  CLASS
#3    n      1411      735   open
#2  adv       337      103   open
#1  adj       421      271   open
#5 prep       455       37 closed
#4 conj       458       18 closed

