######################### Descriptive statistics

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

# Ucitavanje seta podataka.

UHM <- read.delim(file.choose())
str(UHM)
# 'data.frame':   1000 obs. of  5 variables:
#  $ CASE  : int  1 2 3 4 5 6 7 8 9 10 ...
#  $ SEX   : Factor w/ 2 levels "female","male": 2 1 1 1 2 1 2 2 1 2 ...
#  $ FILLER: Factor w/ 3 levels "silence","uh",..: 3 1 1 3 2 2 1 3 3 3 ...
#  $ GENRE : Factor w/ 2 levels "dialog","monolog": 2 2 1 1 1 1 1 2 2 2 ...
#  $ LENGTH: int  1014 1188 889 265 465 1278 671 1079 643 1165 ...
attach(UHM)

# Vrlo jednostavna funkcij TABLE nam omogucava da dobijemo uvid u broj podataka za svaku kategoriju varijable iz seta podataka (ona varijabla FILLER (uh, uhm, silence)). 

table(FILLER)
# FILLER
# silence      uh     uhm 
#     332     394     274 

# Ako zelite da dobijete %, onda ubacite podeljeno sa duzinom od iste varijable /length(FILLER), ili (JOS BOLJE) prop.table(table(FILLER)).

table(FILLER)/length(FILLER)
# FILLER
# silence      uh     uhm 
#     332     394     274 

prop.table(table(FILLER))
# FILLER
# silence      uh     uhm 
#   0.332   0.394   0.274 

# Kod deskritpivne statistike je preporucljivo koristiti graficke prikaze, mnogo su pregledniji.

##################### Scatterplots and line plots

# Ova dva tipa grafika su najcesce koriscena u jezickim istrazivanjima (deskriptivna statistika).

# Iako ovoga nema u knjizi, ajde da plot-ujemo ovo sto smo racunali, sta vidimo?!
plot(FILLER)

# Crtanje jednog fiktivnog line-grapha (ovo je dosta konfuzno u knjizi objasnjeno, fora je u koriscenju "c" funkcije).

a <- c(1, 3, 5, 2, 4)
b <- 1:5

plot(a)
plot(b)

# Kada ukucamo ovako, sta vidimo da se desava? Sta je "a", sta je "b"?
plot(a, b)

# Ako zelimo da specifikujemo tip grafika, onda kucamo "type= .... (pa neko slovo)". Najsonovnija slova: "l" (line); "p" (points); "b" (both).
plot(b, a, type="b")
plot(b, a, type="l")

# Naravno, ovo mozete mnogo da zakomplikujete npr. sledecim kodom.
plot(b, a, xlab="A vector b", ylab="A vector b", xlim=c(0, 8), ylim=c(0,8), type="b")

# Za sta nam sluzi xlab, ylab, xlim, ylim?!

# 4 grafika na 1 slici, mnogo vise podataka. Sta vidimo?!

m <- 1:5
n <- 5:1
x <- 6:10
y <- 6:10
plot(m, n, type="b")
points(x, y, type ="b")
grid()

# Zasto ne prikaze x i y?! Zato sto su m i n razlicitog opsega (da ne kazem, too small) za x i y.

# Jedno od potencijalnih resenja (koje ja licno ne preoprucujem) ubacivanje min i max.
plot(m, n, type="b", xlim=c(0, max(m, x)), ylim=c(0, max(n, y)), xlab="Vectors m and x", ylab="Vectors n and y")
grid()
points(x, y, type="b")

# Sta je uradio?! 

###################### Pie chart

pie(table(FILLER), col=c("grey20", "grey50", "grey80"))

# Ove brojeve "gray20", "gray50" etc. mozete da izguglate.

###################### Bar plot

barplot(table(FILLER), col=c("gray40", "grey60", "grey80"), names.arg=c("Silence", "uh", "uhm"), space=0)
text(c(0.5, 1.5, 2.5), table(FILLER)/2, labels=table(FILLER))

# Da li se secate koji nam je prvi grafik ponudjen od strane R-a za ovu analizu?! Upravo bar chart, zasto?! :-)

mids <- barplot(table(FILLER), col=c("grey40", "grey60", "grey80"))
text(mids, table(FILLER), labels=table(FILLER), pos=1)

###################### Histogram

# Najcesce koristimo kada prikazujemo frekvencije interval/racio variajbli (dok bar-charts koristimo kod nominal/ordinal varijabli).

hist(LENGTH)
hist(LENGTH, main="", xlab="Length in ms", ylab="Frequency", xlim=c(0, 2000), ylim=c(0, 100), col="grey80")
hist(LENGTH, main="", xlab="Length in ms", ylab="Density", freq=FALSE, xlim=c(0, 2000), col="grey50")
lines(density(LENGTH))

####################### Mere centralne tendencija

# Da li se secamo sta je Mod? Medijan(a)? AS? SD?

# Mod (ova nije intuitivna fukncija za racunanje).

which.max(table(FILLER))
# uh 
#  2 

max(table(FILLER))
# [1] 394

# Medijan.

median(LENGTH)
# [1] 897

# Aritmeticka sredina.

mean(LENGTH)
# [1] 915.043

####################### Mere disperzije

# Mere CT nikada nemojte interpretirati bez nekih mera disperzije pride. Koju meru smo do sada spominjali?! Za svaki tip podataka (i svaku MCT) postoji neka odgovarajuca mera disperzije.

Mean -- SD/varijansa.
Mode -- relativna entropija (negde cete da procitate relativna frekvencija TO NIJE ISTO!).
Median -- interkvartalni raspon.

town1 <- c(-5, -12, 5, 12, 15, 18, 22, 23, 20, 16, 8, 1)
town2 <- c(6, 7, 8, 9, 10, 12, 16, 15, 11, 9, 8, 7)
mean(town1)
mean(town2)

# Relativna entropija (svaka entropija se obelezava sa H).

RE je jednaka 1 kada su svi nivoi neke kategorijalne varijable jednako frekventni (ZASTO?!), a 0 je kada svi imaju vrednost 1 i identican varijabilitet (nema ga). Kada je neizvesnost veca? Kada je manja?

article <- c(164, 33, 103)
perc <- article/sum(article)
hrel <-- sum(perc*log(perc))/log(length(perc))
hrel

# Strana (120), brojate sta ce da se desi ako stavite brojeve 300, 0, 0 ... Da li postoji logaritam od nule(setimo se formulse sa strane 120).

# Rang

# Najjednostavnija mera disperzije kod interval/racio, ali nije dovoljna (zbog problema sa autlajerima).

range(LENGTH)

# Kvantila/kvartil.

a <- 1:100
#  0%  25%  50%  75% 100% 
#   1   25   50   75  100

quantile(town2)
#   0%   25%   50%   75%  100% 
# 6.00  7.75  9.00 11.25 16.00 

# Sto je veca razlika izmedju 1 i 4 kvartila, to je HTEROGENIJI SKUP (dakle, velika je disperzija).

# Interpretacija:

quantile(LENGTH, probs=c(0.25, 0.5, 0.75, 1))

# 25%  50%  75% 100% 
# 583  897 1242 1600 

# 25% vrednosti je manje od 583 (ili jedanko).

# SD

# Mera koja nam govori koliko pojedinacne opservacije odstupaju od AS, ova mera se kvadrira, onda se sumiraju sve dobijene vrednosti i na kraju se deli sa n-1 (Bassel's correction).

sd(town1)
sd(town2)

# Step by step!

town1
town1-mean(town1)
(town1-mean(town1))^2
sum((town1-mean(town1))^2)
sum((town1-mean(town1))^2)/(length(town1)-1)
sqrt(sum((town1-mean(town1))^2)/(length(town1)-1))

# Iako je svi koriste i SD ima svoje mane (zavisi od AS distribucije).

sd(town1)
sd(town1*10)

# Koeficijent varijacije (ja volim ovu meru).

# Racuna se preko SD (i predstavlja prakticno normalizovanu SD, da bismo mogli da je poredimo sa drugim setovima podataka).

sd(town1)/mean(town1)
sd(town1*10)/mean(town1*10)

# Summary funkcija.

summary(town1)

#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -12.00    4.00   13.50   10.25   18.50   23.00

# Boxplots (jako korisni uz summary, govore nam o disperziji podataka).

boxsum <- boxplot(town1, town2, notch=TRUE, names=c("Town1", "Town2"))
text(1:2, c(mean(town1), mean(town2)), c("+", "+"))
