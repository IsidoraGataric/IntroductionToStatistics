##################### Distribution testing and chi-square

# Why is it important for us to test the distribution normality?

# Remember two tests: Wilk-Shapiro & Kolmogorov-Smirnov.

# Data for test: statling.txt

# Note: When you start to GAMMs/GLMER etc. you have one function "powerTransform" which tells you whether RTs needs to be transformed by log transformation or by inversion transformation.

matrica <- read.delim(file.choose())
attach(matrica)

#First test: W-S test.
shapiro.test(RT)
#        Shapiro-Wilk normality test
#
#data:  RT
#W = 0.90328, p-value = 0.001375

# Second test: K-S test.
ks.test(jitter(matrica$RT), "pnorm", mean(matrica$RT), sd(matrica$RT))
#        One-sample Kolmogorov-Smirnov test
#
#data:  jitter(matrica$RT)
#D = 0.16668, p-value = 0.1546
#alternative hypothesis: two-sided

# The function "jitter" allows randomization of this numerical vector.

# Note: Cramér's V is a measure of association between two nominal variables, giving a value between 0 and +1 (inclusive). This measure is related to the Chi-square.

##################### Chi-square and non-parametric test

# Some differences between parametric and non-parametric tests:

#1. NPs do not require normal distribution.
#2. They (NPs) are used for the nominal and the ordinated variables.
#3. Works with qualitative data.
#4. They have more robustness ("injuries of the condition").
#5. NPS defect: very weak tests (1/3 weaker in comparision to parametric tests).

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
