######### Intro to R!

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

# On je vasu funkciju izvrsio, ali je sacuvao nije neki zaseban element (nazovimo to tako!). Ovako cemo cuvati i neke svoje matrice ili subsetove!
a <- sqrt(x=5)
print(a)
# [1] 2.236068

# Ili samo ...
a
# [1] 2.236068

# Upisivanje novih vrednosti u vec postojeci data structure!
a <- sqrt(x=9)
print(a)
# 3

a <- a + 2
# [1] 5

# Ako zelimo sve ovo da obrisemo i da pisemo nesto novo!

rm(a) #Obrisi mi taj element (matricu ili bilo stra drugo)
rm(list=ls(all=TRUE)) #izbrisi sve podatke iz memorije (ovo nemojte koristiti, ako bas ne morate da sakrijete nesto :-D).

# Pravimo neki set podataka "some.data" u kojem ce da nam se nalaze svi brojevi od 1 do 10.
some.data <- c(1:10)

# Medjutim, mi zelimo da uzorkujemo samo 5 elemenata sa podjednakom verovatnocom i sa replace=TRUE!
sample(x=some.data, size=5, replace=TRUE, prob=NULL)
# [1] 2 4 9 1 4

# Kako da skratimo ovu funkciju (pogledati u knjizi)!

some.data
sample(some.data)

# Da li pravimo razliku izmedju ove dve linije koda? Koja je razlika?

sample(some.data, size=7)
sample(some.data, size=3)

# Ako vam sve krene po zlu i R nece da radi, samo ukucate q() i zatvori vam se R i sve sto ste do sada uradili.

########## Vectors

# Generisanje vektora

a <-sqrt(5)
a
# [1] 2.236068

is.vector(a)
# [1] TRUE

is.factor(a)
# [1] FALSE

# Da li pravimo razliku?

length(a)
# 1

# Zasto 1? Da li to svi razumemo? Sada cemo da kreiramo vektor sa vise elemenata.

numbers <- c(1, 2, 3)
numbers
# [1] 1 2 3

# Primer kada imate numbers1 i numbers2, a zelite da ocitate podatke i iz jedne i iz druge! (Ovo je malo komplikovanije u knjizi objasnjeno!

numbers1 <- c(1, 2, 3); numbers2 <- c(4, 5, 6)
numbers <- c(numbers1, numbers2)
numbers

# Veoma slicna je funkcija APPEND (slicna funkciji C)!

numbers <- append(numbers1, numbers2)
numbers

# Primer kada se cesto koristi!
evenmore <- c(7, 8)
numbers <- append(numbers, evenmore)
numbers

# Data type (veoma vazno kada obradjujemo podatke!). Ukoliko zelimo da sabiramo neke elemente moramo voditi da oni budu prepoznati kao numericki karakteri, ako zelimo sa neki spisak da dobijemo onda mozemo da radimo i sa stringovima tekstovnim.

# Primer 1 (numericki string): Zelimo da nam izbaci samo numerike od 1 do 3!
numbers.num <- c(1, 2, 3) 
str(numbers.num)
# numbers.num[1:3] (moze i bez ovog dela!)
# num [1:3] 1 2 3

# Primer 2 (tekstovni string): Zelimo da nam izbaci samo numerike od 1 do 3!
numbers.char <- c("four", "five", "six") 
nums.and.chars <- c(numbers.num, numbers.char)
str(nums.and.chars)
# nums.and.chars[1:6] (moze i bez ovog dela!)
# [1] "1"    "2"    "3"    "four" "five" "six" 

# Kada zelimo da ponovimo elemente naseg skupa po nekoliko puta (funkcija REP)
numbers <- c(1, 2, 3)
x <- rep (numbers, 4)
x
# [1] 1 2 3 1 2 3 1 2 3 1 2 3

# Ako ne zelimo ovako sekvencijalno da nam se zbir ponovi, nego prvo da nam navede sve 1, pa sve 2, pa sve 3 ... Onda dodajemo each = 4!
numbers <- c(1, 2, 3)
x <- rep (numbers, each=4)
x
# [1] 1 1 1 1 2 2 2 2 3 3 3 3

# Sekvencijalno redjanje brojeva moze i preko funckije SEQ! Probajte da promenite broj 5!
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











































