##################### Intro to R!

# Installing the packages (definitely, you will not need this all yet).
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

# Mean.
a <- c(1, 2, 3)
mean(a)
# [1] 2

# What happens when you do not complete the code, but you run your code, and get the "+"?!
2-
# + 

# Add what you forgot, next to "+", and the function will be executed.
+ 3
#[1] -1

##################### Functions and arguments.

sqrt(x=5)
# [1] 2.236068

# Data storage. More precisely, storage of the sqrt function above the argument k=5 as an "a".
a <- sqrt(x=5)
print(a)
# [1] 2.236068

# ... you can do it like this ...
a
# [1] 2.236068

# Entering new values into an already existing data set.
a <- sqrt(x=9)
print(a)
# 3

a <- a + 2
# [1] 5

# Deleting data.

rm(a) # Delete this item (e.g. "a").
rm(list=ls(all=TRUE)) # Delete all data from the memory.

# We make some data set "some.data", in which we will write numbers from 1 to 10.
some.data <- c(1:10)

# However, we want to sample only 5 elements with equal probability (replace = TRUE)!
sample(x=some.data, size=5, replace=TRUE, prob=NULL)
# [1] 2 4 9 1 4

# Some variations on this topic.

sample(some.data)
sample(some.data, size=7)
sample(some.data, size=3)

# If everything goes wrong and R stops working, just type q () and close R and everything you have done so far.

##################### Vectors

# Generating vectors.

a <-sqrt(5)
a
# [1] 2.236068

# Do we make the difference between these code lines?

is.vector(a)
# [1] TRUE

is.factor(a)
# [1] FALSE

# Length.
length(a)
# 1

# Now we will make a set of data with multiple elements?

numbers <- c(1, 2, 3)
numbers
# [1] 1 2 3

# Loading all elements from two different data sets (numbers1, and numbers2).

numbers1 <- c(1, 2, 3); numbers2 <- c(4, 5, 6)
numbers <- c(numbers1, numbers2)
numbers

# A very similar function is APPEND (similar to C).

numbers <- append(numbers1, numbers2)
numbers

# Example.
evenmore <- c(7, 8)
numbers <- append(numbers, evenmore)
numbers

# Type of your data? (very important when processing data!). You'll work with both, textual and numerical data.

# Example 1 (numeric): We want to print only numbers 1 to 3.
numbers.num <- c(1, 2, 3) 
str(numbers.num)
# numbers.num[1:3] (optional)
# num [1:3] 1 2 3

# Example 2 (textual string): We want to print numbers from 4 to 6.
numbers.char <- c("four", "five", "six") 
nums.and.chars <- c(numbers.num, numbers.char)
str(nums.and.chars)
# nums.and.chars[1:6] (optional)
# [1] "1"    "2"    "3"    "four" "five" "six" 

# When we want to repeat the elements of our set several times (REP function).
numbers <- c(1, 2, 3)
x <- rep (numbers, 4)
x
# [1] 1 2 3 1 2 3 1 2 3 1 2 3

# If we do not want sequentially repeat .. then we add "each"!
numbers <- c(1, 2, 3)
x <- rep (numbers, each=4)
x
# [1] 1 1 1 1 2 2 2 2 3 3 3 3

# Sequential ordering of numbers can also be done via the function SEQ.
numbers <- seq(1, 5)
numbers

# Zadatak: Kako cemo da napravimo neki vektor (npr. neka se zove isto x!) koji sadrzi sekvencijalni skup parnih brojeva od 2 do 10, i koji ce da se ponavlja 6 puta)?

numbers <- seq(2, 10, 2)
x <- rep (numbers, 6)
x

# Ucitavanje i cuvanje vektora!
x<-scan(file=file.choose(), sep="\n")
# Read 5 items

# Alternativa (trebace nam kasnije)!
dat=read.table("02_exercises_vector1.txt", sep="\n")

# Zelimo tacno da vidimo sta je od podataka u matrici!
x
# [1] 1 2 3 4 5

# Primer iz knjige: kako da napravis vektor X i da ga sacuvas u postojeci set podataka!

x <- append(x, c("foxtrot", "golf"))
cat(x, file=file.choose())

# Editovanje vektora!

# Dakle, poredjaj mi od 3.4 do 3.6 u razlici od po 0.05!
a <- seq(3.4, 3.6, 0.05)
a

# Ako zelite manje detaljne informacije!
round(a, 1)
# [1] 3.4 3.4 3.5 3.5 3.6

# Ako zelite da preuzmete odredjene elemente iz vektora!
x <- c("a", "b", "c", "d", "e")
x[3]
# [1] "c"

# Vezbica: hajde zajedno da protumacimo sta ovo znaci!
y<-3
x[y]

z<-c(1, 3)
x[z]

z<-c(1:3)
x[z]

# Logicki izraz (necemo detaljno ovome!)!
x<-c(10:1)
x
# [1] 10  9  8  7  6  5  4  3  2  1

x==4
# [1] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE

x!=8
# [1]  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE

# Moze ovo x==4 i na duzi nacin!
which(x==4)
# [1] 7

# Da li je ovo nase y vektor!
is.vector(y)

# Koliko elemenata ima y (tj. koja je njegova duzina)!
length(y)

# Prisetimo se naseg skupa X!
x

# Hocemo da proverimo vise nekih elemenata (WHICH to nece moci)! Koristicemo %in%
c(1, 6, 11) %in% x
# [1]  TRUE  TRUE FALSE

# Hmmmm, a sta nam je ovaj FALSE, mozemo da sazanmo ako ukucamo MATCH!
match(c(1, 6, 11), x)
# [1] 10  5 NA

# Zamena elemenata u vektoru!
x <- 10:1
x[x>8] <- 12
x

# Vracanje X skupa na pocetni skup (od po 1 ponavljanje svakog elementa)!
x <- c(1, 2, 3, 2, 4, 3, 4, 5)
unique(x)
# [1] 1 2 3 4 5

# Imamo vise vektora i zelimo da ih POMNOZIMO!
x <- c(2, 3, 4)
y <- c(5, 6, 7)
x*y
# [1] 10 18 28

# Da li je R osetljiv na to sto vektori nisu jednake duzine!?
x <- c(2, 3, 4, 5, 6)
y <- c(8, 9)
x*y

#[1] 16 27 32 45 48
#Warning message:
#In x * y : longer object length is not a multiple of shorter object length

# Jeste, ali vam uradi ono sto ste mu zadali ako je to moguce!

# Ako imate puno podataka i zelite da ih sortirate!

x <- c(6, 7, 2, 4, 9)
y <- c(1, 3, 7)
sort(x)
sort(y)

# Mozete da definiste da li cete u rastucem ili opadajucem redu!

x <- c(6, 7, 2, 4, 9)
y <- c(1, 3, 7)
sort(x, decreasing=TRUE)
sort(y, decreasing=FALSE)

