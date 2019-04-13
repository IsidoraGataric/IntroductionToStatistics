##################### Distribution testing and chi-square

# Zasto nam je vazno da testiramo normalnost distribucije?

# Dva testa upamtite: Wilk-Shapiro & Kolmogorov-Smirnov! Jedan testira zakosenost, drugi zasiljenost.

# Da probamo na ovim podacim iz domaceg ... statling.txt!

# Note: Kada budete radili sa RTs u GAMMs/GLMER etc. imate jednu funkciju powerTransform(matrica$RT) koja ce vam reci da li vas RT treba da bude transformisan log transformacijom ili invers transformacijom (za ovo trebaju posebni paketi, to cemo kod regresije da pricamo).

matrica <- read.delim(file.choose())
attach(matrica)

# Prvo cemo da uradimo W-S test.
shapiro.test(RT)
#        Shapiro-Wilk normality test
#
#data:  RT
#W = 0.90328, p-value = 0.001375

# Prvo cemo da uradimo K-S test.
ks.test(jitter(matrica$RT), "pnorm", mean(matrica$RT), sd(matrica$RT))
#        One-sample Kolmogorov-Smirnov test
#
#data:  jitter(matrica$RT)
#D = 0.16668, p-value = 0.1546
#alternative hypothesis: two-sided

# jitter funckija omogucava randomizaciju tog numerickog vektora (odnosno, varijable).

# Cesto cete citati o necemu sto se zove Kramerov V (ili Kramerov Fi), to je mera koja nam govori o tome koliko jedna distribucija odskace od normalne (dakle, poredi dve distribucije). Ova mera u je osnovi dva prethodna testa.

##################### Chi-square and non-parametric test

# Pre nego sto krenemo samo da objasnimo razliku izmedju parametrijskih i neparametrijskih testova:

1. NP ne zahtevaju normalnu raspodelu.
2. Koriste se za nominalni i ordinalni nivo merenja (moze i na vise niveo (setite se price o RTs i njihovoj distribuciji!), ali to nema smisla, zato transformisemo podatke odredjenim matematickim transformacijama).
3. Rade sa kvalitativnim podacima.
4. Imaju vecu robustnost ("povrede usloga").
5. Mana velika: veoma slabi (1/3 jacine u odnosu na parametrijske testove).

----

# Hi vadrat (radi sa kvalitativnim podacima); podaci se prvo kategorisu, pa nakon toga dobijamo frekvencije nad kojima radimo (imamo opazene i marginalne frekvencije). Opazene su one unutar tabele, marginalne one koje dobijamo zbrajanjem frekvencija.
# Najbolje je prikazivati ih histogramom (kada se graficki prikazuju).

# Uslovi za primenu (ovo cemo raditi kod svakog sledeceg testa):

1. Racuna se samo na frekvencijama.
2. Suma ocekivanih frekvencija mora biti jednaka sumi opazenih frekvancija. Moramo voditi racuna da nam svaki ispitanika da samo jedan odgovor (ne moze nam neki Steva biti i pusac i nepusac).
3. Dovoljno veliki uzorak (OVO JE USTVARI NO1). 

# Yates-ova korekcija (kada je velika razlika izmedju opazenih i ocekivanih frekencija, pa se svaka razlika umanji za 0.5 (necemo ovome, ali cu vam napisati u prezentaciji da znate).

##################### Hi-kvadrat na jednom uzorku.

# Matrica: hikvadrat_glasanje.txt

hi1uz <- read.delim(file.choose())
attach(hi1uz)
table(hi1uz)

test <- chisq.test(table(hi1uz)) 
test

#        Chi-squared test for given probabilities
#
#data:  table(hi1uz)
#X-squared = 8.5882, df = 2, p-value = 0.01365

##################### Hi-kvadrat na dva nezavisna uzorka.

# Matrica: hikvadrat_glasanjepol.txt

hikvad2 <- read.delim(file.choose())
attach(hikvad2)
table(hikvad2)

test <- chisq.test(table(hikvad2)) 
test

# Isto bismo dobili i kada bismo uradili ovako ?!

test <- chisq.test(hikvad2$glasanje, hikvad2$pol) 
test

# Ako imamo dva nezavisna uzorka, ali imamo ekstremno mali broj ispitanika radi se FISEROV EGZAKTNI TEST (kao ekvivalent hi-kvadratu, ali za male uzorke)!

fisher.test(table(hikvad2))
#        Fisher's Exact Test for Count Data
#
#data:  table(hikvad2)
#p-value = 0.07683
#alternative hypothesis: two.sided

##################### Hi-kvadrat na zavisne uzorke.

# Da li razumemo razliku izmedju zavisnih i nezavisnih uzoraka?! Primer zavisnog uzorka: imamo 1 grupu studenata koji polazu dva testa (test 1 - sintaksa; test 2 - morfologija).

# Ovaj t-test se zove i McNemar-ov test.

# Matrica: hikvadarat_ponovljena.txt

ponovo <- read.delim(file.choose())
attach(ponovo)
table(ponovo)

chisq.test(table(ponovo))
#        Pearson's Chi-squared test with Yates' continuity correction
#
#data:  table(ponovo)
#X-squared = 9.4523, df = 1, p-value = 0.002109

addmargins(table(ponovo))
mcnemar.test(table(ponovo), correct=FALSE)

#        McNemar's Chi-squared test
#
#data:  table(ponovo)
#McNemar's chi-squared = 1.0889, df = 1, p-value = 0.2967
