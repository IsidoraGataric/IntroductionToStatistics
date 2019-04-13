############## Deskriptivna statistika (bivarijatna)!

# Ucitavanje paketa (nije neophodno, ali ako se zapuca negde).

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

########################## Frekvencija i kros-tabs

# Sta je kros-tab (iliti, kros-tabulacija)? "Analiza" koju radimo kada zelimo da utvrdimo frekvenciju svake od kategorije (npr. da li podjednak broj muskaraca i zena u produkciji ove tri kategorije filera). Nezavisna i zavisna varijabla?

NV -- pol.
ZV -- FILLER (3 kategorije).

# Dve kategorijalne varijable (FILLER (silence, uh, uhm) i pol (muski/zenski).

UHM <- read.delim(file.choose())
attach(UHM)

freqs <- table(FILLER, SEX)
freqs
#         SEX
#FILLER    female male
#  silence    171  161
#  uh         161  233
#  uhm        170  104

# Procenti.

percentages <- prop.table(table(FILLER, SEX), margin=2)
percentages

#FILLER       female      male
#  silence 0.3406375 0.3232932
#  uh      0.3207171 0.4678715
#  uhm     0.3386454 0.2088353

# MARGIN = 1; MARGINE = 2 ?! Razlika: margin 2 je bolja opcija zato sto je suma svih nivoa varijable (1), a kada se stavi 1 onda je za svaki nivo se gleda odnos MUSKARCI/ZENE, ali ne i odnos tog nivoa sa ostalima (nekada bas ovo i zelite, zavisi).

# Nesto detaljnije podatke.

addmargins(freqs)

####################### Bar plots and mosaic plots

# Hajde da prikazemo vizuelno nase varijable.
plot(FILLER~SEX)

plot(GENRE,FILLER)
plot(table(GENRE,FILLER))
mosaicplot(table(GENRE,FILLER))

####################### Spineplots

# Ovi grafici su za slucajeve kada vam je ZV kategorijalna (nominalna), a NV kontinuirana (interval/racio).

spineplot(FILLER~LENGTH)

####################### Line plots

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

# Obrnut slucaj, ZV je kontinuirana (interval/racio), NV kategorijalna (nominalna).

mean(LENGTH[SEX == "female"])
# [1] 928.3984
mean(LENGTH[SEX == "male"])
# [1] 901.5803

# Kako Gris kaze, ovo je primitivan nacin racunanja (ahahaha, strana 141)! Ali da, definitivno postoji bolja varijanta.

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

####################################### LINEARNA REGRESIJA (jako lose objasnjenja u ovom delu knjige, preskocicemo za sada, sledece nedelje se radi bas lekcija KORELACIJA i LINEARNA REGRESIJA).

# Od 147 do 156 nemojte citati, jako je lose objasnjeno u knjizi.
