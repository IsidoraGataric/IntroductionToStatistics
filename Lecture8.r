# Note: Continuation of the previous Lecture 7.

############################### MANOVA

manova <- read.delim(file.choose())
attach(manova)
manova

# We create a vector in which all dependent variables are found together (Y).

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

# You also have tests: "Pillai", "Hotelling-Lawley", and "Roy", but I recommend Wilks for smaller samples like the one we have in Social Sciences.

############################### Non-parametric equivalents

nonparamanova <- read.delim(file.choose())
attach(nonparamanova)
nonparamanova

############################### Kruskal-Wallis (ANOVA; non-paired samples)

kruskal.test(Rtword ~ SuffixAmbiguity, data = nonparamanova) 

#        Kruskal-Wallis rank sum test
#
#data:  Rtword by SuffixAmbiguity
#Kruskal-Wallis chi-squared = 11.255, df = 2, p-value = 0.003598

# Note: You have Friedman test for paired samples, but code does not work in this version of R, I will sent to you code for this version.

############################### CORRELATIONS

# When do we use correlation? When we want to investigate if there is a relation between two (and more) variables.

# We will learn about two correlations: the Pearson product moment correlation (Pearson's r), and the Spearman rank correlation coefficient Rho (Spearman's Rho). The first one is used when both variables are the interval/ratios of the measurement levels, and the other one when one of the variables is rank, and the other one is interval/ratio.

############################### Pearsons product moment correlation (Pearson's r)

cor.test(SuffixFrequency, SuffixProductivity, method="pearson")

#data:  SuffixFrequency and SuffixProductivity
#t = 17.707, df = 42, p-value < 2.2e-16
#alternative hypothesis: true correlation is not equal to 0
#95 percent confidence interval:
# 0.8904539 0.9665047
#sample estimates:
#      cor 
#0.9390806 

############################### Spearman rank correlation coefficient Rho (Spearman's Rho)

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

# Note: You also have Kendall rank correlation coefficient (Kendall's tau).

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

############################### REGRESSION

regresija <- read.delim(file.choose())
attach(regresija)
regresija

# Simple vs. Multiple Regression.

# Linear vs. Logistic Regression.

# Linear (Simple + Multiple).

reg1 <- lm(RT ~ SuffixFrequency, data=regresija)
print(reg1)
summary(reg1)

#Coefficients:
#                 Estimate Std. Error t value Pr(>|t|)    
#(Intercept)     6.480e+02  2.401e+01  26.991   <2e-16 ***
#SuffixFrequency 3.684e-03  3.860e-03   0.955    0.345  

# Residuals: should be as less as possible, residuals are errors.

reg2 <- lm(RT ~ SuffixFrequency + SuffixProductivity, data=regresija)
print(reg2)
summary(reg2)

#Coefficients:
#                    Estimate Std. Error t value Pr(>|t|)    
#(Intercept)        645.69607   25.66269  25.161   <2e-16 ***
#SuffixFrequency      0.00668    0.01136   0.588     0.56    
#SuffixProductivity  -0.03698    0.13162  -0.281     0.78    

# Logistics regression (dependent variable is binary).

reg3 <- glm(Accuracy ~ SuffixFrequency + SuffixProductivity, family=binomial, data=regresija)
print(reg3)
summary(reg3)

#Coefficients:
#                     Estimate Std. Error z value Pr(>|z|)
#(Intercept)         1.0096868  0.9482513   1.065    0.287
#SuffixFrequency    -0.0002775  0.0005595  -0.496    0.620
#SuffixProductivity  0.0152797  0.0162529   0.940    0.347

# PLEASE read a bit about interpretation of Logistics Regression results: https://datascienceplus.com/perform-logistic-regression-in-r/
