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

# Factor -- pol.
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

# More detailed. 

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

# Topla preporuka --- interkaciju uvek posmatrati prvo preko grafika (mnogo je intuitivnija interpretacija!).

# Sta je interakcija dve varijable?! 

# Najjednostavnija definicija: Interaction effects occur when the effect of one variable depends on the value of another variable.

# Sta znaci ako vam ja kazem da su frekvencija reci i duzina u interakciji?!

interaction.plot(FILLER, SEX, LENGTH)
grid()

interaction.plot(SEX, FILLER, LENGTH)
grid()

# Prilikom interpretacije voditi racuna o brojkama i graficima.

interaction.plot(SEX, FILLER, LENGTH, ylim=c(0, 1000))
interaction.plot(FILLER, SEX, LENGTH, ylim=c(0, 1000))
interaction.plot(SEX, FILLER, LENGTH, ylim=range(LENGTH))
interaction.plot(SEX, FILLER, LENGTH, ylim=range(LENGTH))

########################## Koeficijenti korelacije i linearna regresija (ovo cu redukovati, posto ovo vec spada u interferencijalnu statistiku)

# Obe varijable interval/racio nivo merenja.

rm(list=ls(all=TRUE))

# Ucitavamo novi set podata

ReactTime <- read.delim(file.choose())
str(ReactTime)
attach(ReactTime)

plot(MS_LEARNER~LENGTH, xlim=c(0, 15), ylim=c(0, 300), xlab="Word length in letters", ylab="Reaction time of learningers in ms")
grid()

# Setimo se price o korelacijama, kakva je ovo korelacija POZIVINA ili NEGATIVNA?!

# Postoji vise korelacija! Mi cemo se ovde baviti Pirsonovom produkt-moment korelacijom (cuveno, Pirsonovo r).

# Koja vam je mera ovde vazna?! Kovarijansa?! Kako i zasto?!

covariance <- sum((LENGTH-mean(LENGTH))*(MS_LEARNER-mean(MS_LEARNER)))/(length(MS_LEARNER)/1)
covariance <- cov(LENGTH, MS_LEARNER)
covariance
# [1] 79.28947

# Medjutim, ova mera vam nije bas interpretabilna.

cor(MS_LEARNER, LENGTH, method="pearson")
# [1] 0.9337171

########################## LINEARNA REGRESIJA (jako lose objasnjenja u ovom delu knjige, preskocicemo za sada, sledece nedelje se radi bas lekcija KORELACIJA i LINEARNA REGRESIJA).

# Od 147 do 156 nemojte citati, jako je lose objasnjeno u knjizi.
