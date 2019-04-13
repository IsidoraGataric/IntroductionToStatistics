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

# Chi sqaure (works with qualitative data) -- data is first categorized, and then we get the frequencies over which we work (we have observed and marginal frequencies).

# Requirements for application:

#1. Only count on frequencies.
#2. The sum of the expected frequencies must be equal to the sum of the observed frequencies. We need to keep in mind that each respondent gives us only one answer.
#3. A sufficiently large sample.

# Yates correction (when there is a big difference between the observed and expected frequencies, so each difference is reduced by 0.5.

##################### Hi-kvadrat na jednom uzorku.

# Data set: hikvadrat_glasanje.txt

hi1uz <- read.delim(file.choose())
attach(hi1uz)
table(hi1uz)

test <- chisq.test(table(hi1uz)) 
test

#        Chi-squared test for given probabilities
#
#data:  table(hi1uz)
#X-squared = 8.5882, df = 2, p-value = 0.01365

##################### Chi-sqaure with two independent variables

# Data set: hikvadrat_glasanjepol.txt

hikvad2 <- read.delim(file.choose())
attach(hikvad2)
table(hikvad2)

test <- chisq.test(table(hikvad2)) 
test

# We would also get the same if we did this!?

test <- chisq.test(hikvad2$glasanje, hikvad2$pol) 
test

# If we have two independent samples, but we have an extremely small number of respondents, the Fisher exact test (like the chi-square, but for small samples) is needed.

fisher.test(table(hikvad2))
#        Fisher's Exact Test for Count Data
#
#data:  table(hikvad2)
#p-value = 0.07683
#alternative hypothesis: two.sided

##################### Chi-square for dependent samples

# Do you know what is difference between dependent and indepnendent sample?

# McNemar test.

# Data set: hikvadarat_ponovljena.txt

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
