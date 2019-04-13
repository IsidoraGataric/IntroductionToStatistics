# Reminder: ################# T-TEST

# Uslovi za primenu t-testa:
1. Normalnost ditribucije.
2. Dovoljno veliki uzorak.
3. Homogenost varijansi.
4. Nema autlajera.

############################### ANOVA & ANCOVA

# Ista pravila kao i kod t-testa, s tim sto NV mora imati dve ili vise grupa (obavezno, veci uzorak!).

# One-way ANOVA.

anova <- read.delim(file.choose())
attach(anova)
anova

primer1 <- aov(RT ~ SuffixAmbiguity, data=anova)
summary(primer1)

#                Df Sum Sq Mean Sq F value Pr(>F)
#SuffixAmbiguity  2   2039    1019   0.062   0.94
#Residuals       41 679461   16572

# ANCOVA (odavde vise nije ovako lako, morate biti malo mastoviti).

# Bez interakcije (nju cemo kod dole testirati, kod Two-way).
primer2 <- aov(RT ~ SuffixAmbiguity + SuffixFrequency, data=anova)
summary(primer2)

#                Df Sum Sq Mean Sq F value Pr(>F)
#SuffixAmbiguity  2   2039    1019   0.061  0.941
#SuffixFrequency  1  14171   14171   0.852  0.362
#Residuals       40 665290   16632  

# Two-way ANOVA (sa interakcijom).
primer3 <- aov(RT ~ SuffixAmbiguity*SuffixFrequency, data=anova)
summary(primer3)

#                                Df Sum Sq Mean Sq F value Pr(>F)
#SuffixAmbiguity                  2   2039    1019   0.059  0.943
#SuffixFrequency                  1  14171   14171   0.823  0.370
#SuffixAmbiguity:SuffixFrequency  2  10604    5302   0.308  0.737
#Residuals                       38 654686   17229  

# Post-hoc (topla preporuka TukeyHSD, ali ne preorpucujem da radite ovo sami dok ne naucite sve dobro)

posthoc <- read.delim(file.choose())
attach(posthoc)
posthoc

primer4 <- aov(RT ~ SuffixAmbiguity*Freq, data=anova)
summary(primer4)

TukeyHSD(primer4)

############################### MANOVA

manova <- read.delim(file.choose())
attach(manova)
manova

# Prvo napravimo jedan vektor u kom nam se nalaze sve zavisne varijable zajedno.

Y <- cbind(Rtword, Rtsentence)
fit <- manova(Y ~ SuffixAmbiguity*SuffixFrequency, data=manova)
summary(fit, test="Wilks")

#                                Df   Wilks approx F num Df den Df  Pr(>F)  
#SuffixAmbiguity                  2 0.90431  0.95420      4     74 0.43783  
#SuffixFrequency                  1 0.86553  2.87412      2     37 0.06914 .
#SuffixAmbiguity:SuffixFrequency  2 0.92873  0.69676      4     74 0.59660  
#Residuals                       38                                         
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# Imate jos i "Pillai", "Hotelling-Lawley", and "Roy", ali preporucujem Wilks-a za manje uzorke kao sto je nas (jezicki). 

### Neparametrijski ekvivalenti.

nonparamanova <- read.delim(file.choose())
attach(nonparamanova)
nonparamanova

# Kruskal–Wallis (anova; neponovljena merenja).

kruskal.test(Rtword ~ SuffixAmbiguity, data = nonparamanova) 

#        Kruskal-Wallis rank sum test
#
#data:  Rtword by SuffixAmbiguity
#Kruskal-Wallis chi-squared = 11.255, df = 2, p-value = 0.003598

# Dugujem vam Fridmanov test za ponovljena merenja, ali nisam uspela da sredim kod, nije hteo da mi proradi, pa cu vam nakonadno poslati to (kada budem slala celu skriptu).

############################### KORELACIJE

# Kada koristimo korelacije? Kada zelimo da utvrdimo da li postoji povezanost izmedju dve (i vise) varijabli.

# Radicemo dve korelacije koje se najcesce koriste: Pirsonova produkt moment korelacija (r) i Spirmanov koeficijent rang korelacije Ro. Prva se koristi kada su nam obe varijable interval/racio nivoa merenja, druga kada je jedna od varijabli rang nivoa.

# Reminder za Isidoru: prica o vaznosti normalne distribucije kod Pirson produkt moment korelacije.

# Pirsonova produkt moment korelacija (r)

cor.test(SuffixFrequency, SuffixProductivity, method="pearson")

#data:  SuffixFrequency and SuffixProductivity
#t = 17.707, df = 42, p-value < 2.2e-16
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
# 0.8904539 0.9665047
#sample estimates:
#      cor 
#0.9390806 

# Spirmanov koeficijent rang korelacije Ro

cor.test(NounLength, SuffixProductivity, method="spearman")

#        Spearman's rank correlation rho
#
#data:  NounLength and SuffixProductivity
#S = 14519, p-value = 0.8812
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#        rho 
#-0.02318915 
#
#Warning message:
#In cor.test.default(NounLength, SuffixProductivity, method = "spearman") :
#  Cannot compute exact p-value with ties

# Nije lose da znate da postoji i Kendal Tau koeficijent korelacije. Korisitmo ga kada imamo nize nivoe merenja od interval/racio; mnogo fleksibilnija po pitanju normalnosti raspodele.

cor.test(SuffixAmbiguity, SuffixProductivity, method="kendall")

transform(nonparamanova, SuffixProductivity = as.numeric(SuffixProductivity))

cor.test(NounLength, SuffixProductivity, method="kendall")

#       Kendall's rank correlation tau
#
#data:  NounLength and SuffixProductivity
#z = 0.052315, p-value = 0.9583
#alternative hypothesis: true tau is not equal to 0
#sample estimates:
#        tau 
#0.006070492 

############################### REGRESIJA

regresija <- read.delim(file.choose())
attach(regresija)
regresija

# Simple vs. Multiple Regression.

# Linearna vs. Logisticka.

# Linearna (Simple + Multiple).

reg1 <- lm(RT ~ SuffixFrequency, data=regresija)
print(reg1)
summary(reg1)

#Coefficients:
#                 Estimate Std. Error t value Pr(>|t|)    
#(Intercept)     6.480e+02  2.401e+01  26.991   <2e-16 ***
#SuffixFrequency 3.684e-03  3.860e-03   0.955    0.345  

# Reziduali: treba da bude sto manje, greska.

reg2 <- lm(RT ~ SuffixFrequency + SuffixProductivity, data=regresija)
print(reg2)
summary(reg2)

#Coefficients:
#                    Estimate Std. Error t value Pr(>|t|)    
#(Intercept)        645.69607   25.66269  25.161   <2e-16 ***
#SuffixFrequency      0.00668    0.01136   0.588     0.56    
#SuffixProductivity  -0.03698    0.13162  -0.281     0.78    

# Logisticka (ista fora, odmah cemo Multiple); negde cete cuti i LOGIT regression / LOGIT-PROBIT modeli etc.

reg3 <- glm(Accuracy ~ SuffixFrequency + SuffixProductivity, family=binomial, data=regresija)
print(reg3)
summary(reg3)

#Coefficients:
#                     Estimate Std. Error z value Pr(>|z|)
#(Intercept)         1.0096868  0.9482513   1.065    0.287
#SuffixFrequency    -0.0002775  0.0005595  -0.496    0.620
#SuffixProductivity  0.0152797  0.0162529   0.940    0.347

PROCITATI interpretaciju rezultata: https://datascienceplus.com/perform-logistic-regression-in-r/
