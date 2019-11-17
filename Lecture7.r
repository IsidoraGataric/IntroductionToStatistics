###################### Testing differences between groups

# Again, we have division into parametric and nonparametric tests.

###################### T-TEST

# Requirements for applying t-test:

#1. Normality of the ditribution (Gaussian distribution);
#2. A sufficiently large sample;
#3. Homogeneity of variance;
#4. Without outliers.

# T-test is also distinguished for dependent and independent samples, we test the difference between the two groups.

# Data set loading.
matrica <- read.delim(file.choose())
attach(matrica)
matrica

###################### T-test for two independent samples

t.test(RT~SuffixAmbiguity)
#data:  RT by SuffixAmbiguity
#t = 0.66144, df = 35.082, p-value = 0.5127
#alternative hypothesis: true difference in means is not equal to 0
#95 percent confidence interval:
# -52.28849 102.83395
#sample estimates:
#  mean in group ambiguous mean in group unambiguous 
#                 674.6818                  649.4091

# Interpretation: t-test value (0.66), df (35.08), p (0.51), and also you have to look to Mean for each group to see which Mean is higher. 

###################### T-test for one sample (very rarely used, but if you find that you know!)

# Analyze of values of one variable (e.g. Reaction time), which is numerical.

t.test(RT,mu=500) # H: mu=500
#data:  RT
#t = 8.5382, df = 43, p-value = 8.31e-11
#alternative hypothesis: true mean is not equal to 500
#95 percent confidence interval:
# 623.7707 700.3202
#sample estimates:
#mean of x 
# 662.0455 

###################### T-test for paired samples

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

###################### Non-parametric equivalents to t-test

###################### Mann–Whitney U (for two independent samples)

# For example: you have one categorical variable (Suffix ambiguity; 2 levels; categorical; independent variable), and you have some answers on Likert scale (ordinal; dependent variable).

nonpar <- read.delim(file.choose())
attach(nonpar)
nonpar

wilcox.test(Likert1~SuffixAmbiguity)
#        Wilcoxon rank sum test with continuity correction
#
#data:  Likert1 by SuffixAmbiguity
#W = 197.5, p-value = 0.2898

###################### Wilcoxon signed rank test (for paired samples)

wilcox.test(Likert1,Likert2,paired=TRUE)
#        Wilcoxon signed rank test with continuity correction
#
#data:  Likert1 and Likert2
#V = 384, p-value = 0.7276

###################### ANOVA

# The same requirements as for the t-test, with factor that having two or more levels (groups).

###################### One-way ANOVA

anova <- read.delim(file.choose())
attach(anova)
anova

primer1 <- aov(RT ~ SuffixAmbiguity, data=anova)
summary(primer1)
#                Df Sum Sq Mean Sq F value Pr(>F)
#SuffixAmbiguity  2   2039    1019   0.062   0.94
#Residuals       41 679461   16572

###################### ANCOVA

# Without interaction.
primer2 <- aov(RT ~ SuffixAmbiguity + SuffixFrequency, data=anova)
summary(primer2)
#                Df Sum Sq Mean Sq F value Pr(>F)
#SuffixAmbiguity  2   2039    1019   0.061  0.941
#SuffixFrequency  1  14171   14171   0.852  0.362
#Residuals       40 665290   16632  

###################### Two-way ANOVA

primer3 <- aov(RT ~ SuffixAmbiguity*SuffixFrequency, data=anova)
summary(primer3)
#                                Df Sum Sq Mean Sq F value Pr(>F)
#SuffixAmbiguity                  2   2039    1019   0.059  0.943
#SuffixFrequency                  1  14171   14171   0.823  0.370
#SuffixAmbiguity:SuffixFrequency  2  10604    5302   0.308  0.737
#Residuals                       38 654686   17229  

###################### Post-hoc (recommendation: TukeyHSD)

TukeyHSD(primer2)

posthoc <- read.delim(file.choose())
attach(posthoc)
posthoc

primer4 <- aov(RT ~ SuffixAmbiguity*Freq, data=anova)
summary(primer4)

TukeyHSD(primer4)

# Note: the continuation of this lesson is in the code for Lecture 8.
