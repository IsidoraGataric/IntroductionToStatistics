######### Ponavljanje prethodnog gradiva.

#################### TESTIRANJE RAZLIKA IZMEDJU GRUPA

# Opet imamo podelu na parametrijske i neparametrijske.

################# T-TEST

# Uslovi za primenu t-testa:
1. Normalnost ditribucije.
2. Dovoljno veliki uzorak.
3. Homogenost varijansi.
4. Nema autlajera.

# Da li se secate koji su nam uslovi za primenu neparametrijskih testova?

# T-test takodje razlikujemo za zavisne i nezavisne uzorke, testiramo razliku izmedju dve grupe.

# Ucitajmo matricu.

matrica <- read.delim(file.choose())
attach(matrica)
matrica

# T-test za dva nezavisna uzorka (ovo je malo apstraktan primer, ali zamislite da je ova varijabla SuffixAmbiguity recimo pol).

t.test(RT~SuffixAmbiguity)

#data:  RT by SuffixAmbiguity
#t = 0.66144, df = 35.082, p-value = 0.5127
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
# -52.28849 102.83395
#sample estimates:
#  mean in group ambiguous mean in group unambiguous 
#                 674.6818                  649.4091

# Interpretacija: Velicina t-testa (0.66), df (35.08), p (0.51), i nakon toga na osnovu Mean-ova vidite koja grupa je brza, koja sporija (iako nema statisticke razlike, ali isto bismo gledali i da je ima).

# T-test za jedan uzorak (jako retko se koristi, ali ako naletite da znate!).

# Koristite samo 1 varijablu (numericku), i recimo imate pretpostavku da iz prethodnog rada da je prosecno vreme citanje derivacionih imenica 500 ms (ovo je jako hipoteticko, ali radi lakseg objasnjenja). I sta sada? Treba vam neka razlika, nemate grupe, imate eksperiment i jednu varijablu?

t.test(RT,mu=500) # H: mu=500

#data:  RT
#t = 8.5382, df = 43, p-value = 8.31e-11
#alternative hypothesis: true mean is not equal to 500
#95 percent confidence interval:
# 623.7707 700.3202
#sample estimates:
#mean of x 
# 662.0455 

######### T-test za uparene uzorke.

upareni <- read.delim(file.choose())
attach(upareni)
upareni

t.test(RT1,RT2,paired=TRUE)

#        Paired t-test
#
#data:  RT1 and RT2
#t = 0.83689, df = 43, p-value = 0.4073
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
# -40.53031  98.03031
#sample estimates:
#mean of the differences 
#                  28.75 

################ Neparametrijski ekvivalenti

# Za jedan uzorak nema smisla (setimo se hi-kvadrata).

# Za dva nezavisna uzorka (Mann–Whitney U).

#Primer: imate onu nasu varijablu viseznacnost, ali umesto rt imate odgovore na likertu.

nonpar <- read.delim(file.choose())
attach(nonpar)
nonpar

wilcox.test(Likert1~SuffixAmbiguity)

#        Wilcoxon rank sum test with continuity correction
#
#data:  Likert1 by SuffixAmbiguity
#W = 197.5, p-value = 0.2898

# Za ponovljena merenja (Wilcoxon signed rank test).

wilcox.test(Likert1,Likert2,paired=TRUE)

#        Wilcoxon signed rank test with continuity correction
#
#data:  Likert1 and Likert2
#V = 384, p-value = 0.7276

############################### ANOVA

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

# Two-way ANOVA.
primer3 <- aov(RT ~ SuffixAmbiguity*SuffixFrequency, data=anova)
summary(primer3)

#                                Df Sum Sq Mean Sq F value Pr(>F)
#SuffixAmbiguity                  2   2039    1019   0.059  0.943
#SuffixFrequency                  1  14171   14171   0.823  0.370
#SuffixAmbiguity:SuffixFrequency  2  10604    5302   0.308  0.737
#Residuals                       38 654686   17229  

# Post-hoc (topla preporuka TukeyHSD, ali ne preorpucujem da radite ovo sami dok ne naucite sve dobro)

TukeyHSD(primer2)

posthoc <- read.delim(file.choose())
attach(posthoc)
posthoc

primer4 <- aov(RT ~ SuffixAmbiguity*Freq, data=anova)
summary(primer4)

TukeyHSD(primer4)

############## SLEDECI CAS CEMO RADITI MANOVU, OVO MORA DA SE NAUCI DA BI SE RAZUMELA MANOVA! Takodje, nastavicemo pricu o post.hocu kada se nauci sve ovo.

### Neparametrijski (nastavljno sledece nedelje).

# Kruskal–Wallis (one way).
# Friedman test (ponovljena merenja).
