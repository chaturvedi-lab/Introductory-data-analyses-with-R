##try some operations
2+2
1536/317000
exp(pi)-pi
x <- 3
y <- 2
x+y
ls()
round(pi, 6)
round(pi,+ 6)

## read in the text file ####
mydata<-read.table("dummy.txt", header=T)

## load data from R ######
data(mtcars)
data(iris)

## read in data from the web #######
fl2000<-read.table("http://faculty.washington.edu/tlumley/data/FLvote.dat", header=TRUE)

##syntax
#create lists
mylist<-c(1,2,3,4)
mylist<-c(1:10)
mylist<-c("a","b","c","d")

#sanity checks
## load your data ###
data(iris)

## check the data ###
#check file data
head(iris)
#check data names
names(iris)
#check dataframe dimensions
dim(iris)
#check what a column looks like
#subsetting data by $ 
iris$Species
iris[,1]
iris[1,]

## check the $ operations on data ###
head(iris$Species)

## check column subsets on data ###
head(iris[,1])

#### subsets ##########
## First element
iris$Sepal.Length[1]

## All but first element
iris$Sepal.Length[-1]

## Elements 5 through 10
iris$Sepal.Length[5:10]

## Elements 5 and 7
iris$Sepal.Length[c(5,7)]

## Sepal length less than a value
iris$Sepal.Length[ iris$Sepal.Length < 5 ]

## Sepal length from species versicolor
iris$Sepal.Length[iris$Species == "versicolor"]


## some preliminary analyses #####
## take mean
mean(iris$Sepal.Width)
## take median
median(iris$Sepal.Width)
## check for variation
var(iris$Sepal.Width)
## take standard deviation
sd(iris$Sepal.Width)
##more
mean(iris$Petal.Length)
mean(iris$Petal.Length[iris$Species=="setosa"])

## boxplot
boxplot(formula = Petal.Length ~ Species, data = iris)

## Student’s t

setosa <- iris[iris$Species == "setosa", ]
versicolor <- iris[iris$Species == "versicolor", ]
dim(iris)
## [1] 150   5

iris[3, ]
setosa <- iris[iris$Species == "setosa", ]
# extract rows and columns
nrow(iris)
## [1] 150
nrow(setosa)
## [1] 50

# Compare Petal.Length of these two species
setosa.v.versicolor <- t.test(x = setosa$Petal.Length, y = versicolor$Petal.Length)
setosa.v.versicolor
## 
##  Welch Two Sample t-test
## 
## data:  setosa$Petal.Length and versicolor$Petal.Length
## t = -39.493, df = 62.14, p-value < 2.2e-16
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -2.939618 -2.656382
## sample estimates:
## mean of x mean of y 
##     1.462     4.260


## visualize data ##
install.packages("ggplot2")
library('ggplot2')
ggplot(iris, aes(x = Petal.Length, y = Sepal.Length, colour = Species)) + 
  geom_point() +
  ggtitle('Iris Species by Petal and Sepal Length')

# Density & Frequency analysis with the Histogram,

# Sepal length 
HisSl <- ggplot(data=iris, aes(x=SepalLengthCm))+
  geom_histogram(binwidth=0.2, color="black", aes(fill=Species)) + 
  xlab("Sepal Length (cm)") +  
  ylab("Frequency") + 
  theme(legend.position="none")+
  ggtitle("Histogram of Sepal Length")+
  geom_vline(data=iris, aes(xintercept = mean(SepalLengthCm)),linetype="dashed",color="grey")


# Sepal width
HistSw <- ggplot(data=iris, aes(x=SepalWidthCm)) +
  geom_histogram(binwidth=0.2, color="black", aes(fill=Species)) + 
  xlab("Sepal Width (cm)") +  
  ylab("Frequency") + 
  theme(legend.position="none")+
  ggtitle("Histogram of Sepal Width")+
  geom_vline(data=iris, aes(xintercept = mean(SepalWidthCm)),linetype="dashed",color="grey")


# Petal length
HistPl <- ggplot(data=iris, aes(x=PetalLengthCm))+
  geom_histogram(binwidth=0.2, color="black", aes(fill=Species)) + 
  xlab("Petal Length (cm)") +  
  ylab("Frequency") + 
  theme(legend.position="none")+
  ggtitle("Histogram of Petal Length")+
  geom_vline(data=iris, aes(xintercept = mean(PetalLengthCm)),
             linetype="dashed",color="grey")



# Petal width
HistPw <- ggplot(data=iris, aes(x=PetalWidthCm))+
  geom_histogram(binwidth=0.2, color="black", aes(fill=Species)) + 
  xlab("Petal Width (cm)") +  
  ylab("Frequency") + 
  theme(legend.position="right" )+
  ggtitle("Histogram of Petal Width")+
  geom_vline(data=iris, aes(xintercept = mean(PetalWidthCm)),linetype="dashed",color="grey")


# Plot all visualizations
grid.arrange(HisSl + ggtitle(""),
             HistSw + ggtitle(""),
             HistPl + ggtitle(""),
             HistPw  + ggtitle(""),
             nrow = 2,
             top = textGrob("Iris Frequency Histogram", 
                            gp=gpar(fontsize=15))
)

## another boxplot
ggplot(iris, aes(Species, PetalLengthCm, fill=Species)) + 
  geom_boxplot()+
  scale_y_continuous("Petal Length (cm)", breaks= seq(0,30, by=.5))+
  labs(title = "Iris Petal Length Box Plot", x = "Species")


## all variables ####
BpSl <- ggplot(iris, aes(Species, SepalLengthCm, fill=Species)) + 
        geom_boxplot()+
        scale_y_continuous("Sepal Length (cm)", breaks= seq(0,30, by=.5))+
        theme(legend.position="none")



BpSw <-  ggplot(iris, aes(Species, SepalWidthCm, fill=Species)) + 
          geom_boxplot()+
          scale_y_continuous("Sepal Width (cm)", breaks= seq(0,30, by=.5))+
          theme(legend.position="none")



BpPl <- ggplot(iris, aes(Species, PetalLengthCm, fill=Species)) + 
        geom_boxplot()+
        scale_y_continuous("Petal Length (cm)", breaks= seq(0,30, by=.5))+
        theme(legend.position="none")
        


BpPw <-  ggplot(iris, aes(Species, PetalWidthCm, fill=Species)) + 
        geom_boxplot()+
        scale_y_continuous("Petal Width (cm)", breaks= seq(0,30, by=.5))+
        labs(title = "Iris Box Plot", x = "Species")



# Plot all visualizations
grid.arrange(BpSl  + ggtitle(""),
             BpSw  + ggtitle(""),
             BpPl + ggtitle(""),
             BpPw + ggtitle(""),
             nrow = 2,
             top = textGrob("Sepal and Petal Box Plot", 
                            gp=gpar(fontsize=15))
)

## regression
iris[['Is.Versicolor']] <- as.numeric(iris[['Species']] == 'versicolor')
fit.lm <- lm(Is.Versicolor ~ Petal.Length + Sepal.Length, data = iris)
summary(fit.lm)

fit.logit <- glm(Is.Versicolor ~ Petal.Length + Sepal.Length, data = iris,
                 family = binomial(link = 'logit'))
summary(fit.logit)

iris[['Predict.Versicolor.logit']] <- as.numeric(predict(fit.logit) > 0.5)
table(iris[, c('Is.Versicolor', 'Predict.Versicolor.logit')])

## One-way ANOVA

ANOVA <- aov(Sepal.Width ~ Species, data=iris) # (DV ~ IV, data=dataset)
summary(ANOVA) # View results of the ANOVA test

## Post-hoc Tests ##

TukeyHSD(ANOVA)

### Pairwise T-Test

pairwise.t.test(iris$Sepal.Width, iris$Species, p.adj="bonferroni", paired=FALSE)
