This is introductory course to do data analyses using the programming language R. We will use R Studio Cloud (https://rstudio.cloud/) to get aquainted with the R programming language and perform some basic data analyses with some dummy data. We will then use specific data to do statistical tests and visualize patterns in R.

**1. What is R?**

* R is a ‘programming environment for statistics and graphics’

* The base R has fewer prepackaged statistics procedure than SPSS or SAS, but it is much easier to extend with new procedures.

* There are over 6000 published extension packages for R, many aimed at genetics and genomics research.

**2. Using R**
R is a free implemention of S, for which John Chambers won the ACM Software Systems award.
For the S system, which has forever altered how people analyze, visualize, and manipulate data.
The downside is that using R effectively may require changing how you analyze, visualize, and manipulate data.
R is a command-line system, not a point-and-click system.

**3. A Calculator**
R can be used as a calculator. Here are a few things to try:

```bash
 2+2
1536/317000
exp(pi)-pi
x <- 3
y <- 2
x+y
ls()
round(pi, 6)
round(pi,+ 6)
```
**4. Scripts**
* We can use different kind of editors to write scripts for R.

* We can write it in text editor.

* We can write it in the terminal.

**5. Interface**

For longer analyses (and for this course), it’s better to type code into a script and then run it. In base R;
* Windows: File | New script, CTRL-R to run lines or regions
* Mac: File | New Document, command-return to run
* Some other text editors offer this: Emacs, Tinn, WinEDT,JGR, Eclipse. RStudio has a script editor and data viewer

**6. Reading in data - text, csv**
Ability to read in data is assumed. But to illustrate commands, and show some less-standard approaches, we’ll review reading in:
* Text files, comma separated files
* Other statistics packages datasets
* Web pages

```bash
## read in the text file ####
mydata<-read.table("dummy.txt", header=T)

## load data from R ######
data(mtcars)
data(iris)

## read in data from the web #######
fl2000<-read.table("http://faculty.washington.edu/tlumley/data/FLvote.dat", header=TRUE)
```
**7. Syntax**
Assigning a single vector (or anything else) to a variable uses the same syntax as assigning a whole data frame.
* c() is a function that makes a single vector from its arguments.
* names() is a function that accesses the variable names of a data frame

```bash
mylist<-c(1,2,3,4)
mylist<-c(1:10)
mylist<-c("a","b","c","d")

names(iris)

head(iris)
```

**8. Sanity checks -- Did it work?**
When you read in a data file or load data from R, you can do checks to make sure your data is loaded correctly.
* head() is a function that shows you that initial lines of the data frame
* dim() is a function that that gives you the dimensions of your data frame
* $ sign helps in seeing columns by column names
* Columns can be seen using [,1] and rows can be seen using [1,]

```bash
## load your data ###
data(iris)

## check the data ###
head(iris)
dim(iris)
iris$Species
iris[,1]
iris[1,]
```
**9. Where's my file?**
It is important to check your working directory in R. This is the place from where you will source in your data files and where your output files will be saved by default.

```bash
##check your present directory ###
getwd()

## set your working directory ###
setwd()
```
**10. Operating on data**
We assume you know how to use the $ sign, to indicate columns of interest in a dataset. From here onwards, we will work with iris data from R.

```bash
## check if you have the data loaded ###
head(iris)

## check the $ operations on data ###
head(iris$Species)

## check column subsets on data ###
head(iris[,1])
```
**11. Subsets**
Everything in R is a vector (but some have only one element). There are several ways to use [] to extract subsets

```bash
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
```

Positive indices select elements, negative indices drop elements
* 5:10 is the sequence from 5 to 10
* You need == to test equality, not just =
* with() temporarily sets up a data frame as the default place to look up variables.

**12. Data analyses**
Let us now try some computation on our data frame and try to do some statistical tests.

```bash
mean(iris$Sepal.Width)
median(iris$Sepal.Width)
var(iris$Sepal.Width)
sd(iris$Sepal.Width)
mean(iris$Petal.Length)
mean(iris$Petal.Length[iris$Species=="setosa"])
```
Boxplot
boxplot function uses the syntax y ~ group, where the reference to the left of the tilde (~) is the value to plot on the y-axis (here we are plotting the values of Petal.Length) and the reference to the right indicates how to group the data (here we group by the value in the Species column of iris). Find out more about the plot by typing ?boxplot into the console.

``` bash
boxplot(formula = Petal.Length ~ Species, data = iris)
```
Student’s t
We are going to start by doing a single comparison, looking at the petal lengths of two species. We use a t-test to ask whether or not the values for two species were likely drawn from two separate populations. Just looking at the data for two species of irises, it looks like the petal lengths are different, but are they significantly different?

```bash 
head(iris)
```
We’ll start by comparing the data of Iris setosa and Iris versicolor, so we need to create two new data objects, one corresponding to the I. setosa data and one for the I. versicolor data.

``` bash
setosa <- iris[iris$Species == "setosa", ]
versicolor <- iris[iris$Species == "versicolor", ]
``` 
OK, a lot happened with those two lines. Let’s take a look:

* iris is the data.frame we worked with before.
* iris$Species refers to one column in iris, that is, the column with the name of the species (setosa, versicolor, or virginica).
* The square brackets [<position 1>, <position 2>] are used to indicate a subset of the iris data. A data.frame is effectively a two-dimensional structure - it has some number of rows (the first dimension) and some number of columns (the second dimension). We can see how many rows and columns are in a data.frame with the dim command. dim(iris) prints out the number of rows (150) and the number of columns (5):

```bash
dim(iris)
## [1] 150   5
```

We use the square brackets to essentially give an address for the data we are interested in. We tell R which rows we want in the first position and which columns we want in the second position. If a dimension is left blank, then all rows/columns are returned. For example, this returns all columns for the third row of data in iris:

```bash
iris[3, ]

##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 3          4.7         3.2          1.3         0.2  setosa
```

So the code

```bash
setosa <- iris[iris$Species == "setosa", ]
```

We will extract all columns (because there is nothing after the comma) in the iris data for those rows where the value in the Species column is “setosa” and assign that information to a variable called setosa.

Comparing the iris data and the setosa data, we see that there are indeed fewer rows in the setosa data:

```bash
nrow(iris)
## [1] 150
nrow(setosa)
## [1] 50
```
Now to compare the two species, we call the t.test function in R, passing each set of data to x and y.

```bash
# Compare Petal.Length of these two species
setosa.v.versicolor <- t.test(x = setosa$Petal.Length, y = versicolor$Petal.Length)
```

The output of a t-test is a little different than an ANOVA; we only have to enter the name of the variable to see the results (in contrast, we had to use summary to see the significance of our ANOVA).

```
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
```
The results include:

* Test statistic, degrees of freedom, and p-value
* The confidence interval for the difference in means between the two data sets
* The means of each data set

So we reject the hypothesis that these species have the same petal lengths.

**13. Visualize the data**

```bash
library('ggplot2')
ggplot(iris, aes(x = Petal.Length, y = Sepal.Length, colour = Species)) + 
  geom_point() +
  ggtitle('Iris Species by Petal and Sepal Length')
```
Interesting! It looks like setosas are clearly different from the other two species. Versicolors and virginicas appear different too, however, it would be difficult to classify which is which on the border.

```bash
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
```

Notice the shape of the data, most attributes exhibit a normal distribution. You can see the measurements of very small flowers in the Petal width and length column.

Next with the bloxplot we will identify some outliers. As you can see some classes do not overlap at all (e.g. Petal Length) where as with other attributes there are hard to tease apart (Sepal Width).

```bash
ggplot(iris, aes(Species, PetalLengthCm, fill=Species)) + 
  geom_boxplot()+
  scale_y_continuous("Petal Length (cm)", breaks= seq(0,30, by=.5))+
  labs(title = "Iris Petal Length Box Plot", x = "Species")
```
Let's plot all the variables in a single visualization that will contain all the boxplots.

```bash
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
```

**14. Significance tests**

Let’s see what regression can do to classify this data using only Petal.Length and Sepal.Length as our explanatory variables. I’ll first create a dummy variable for versicolors. Then we’ll fit our model, and assume any observation who’s predicted probability is greater than one-half is a versicolor. Finally, we’ll examine our type 1 and type 2 errors.

```bash
iris[['Is.Versicolor']] <- as.numeric(iris[['Species']] == 'versicolor')
fit.lm <- lm(Is.Versicolor ~ Petal.Length + Sepal.Length, data = iris)
summary(fit.lm)
#> 
#> Call:
#> lm(formula = Is.Versicolor ~ Petal.Length + Sepal.Length, data = iris)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -0.6597 -0.3667 -0.1962  0.5520  0.7929 
#> 
#> Coefficients:
#>              Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)   1.11893    0.40693   2.750 0.006715 ** 
#> Petal.Length  0.14794    0.04328   3.419 0.000815 ***
#> Sepal.Length -0.22959    0.09226  -2.489 0.013940 *  
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.4569 on 147 degrees of freedom
#> Multiple R-squared:  0.07949,    Adjusted R-squared:  0.06696 
#> F-statistic: 6.347 on 2 and 147 DF,  p-value: 0.002271
iris[['Predict.Versicolor.lm']] <- as.numeric(predict(fit.lm) > 0.5)
## Plot predicted vs. actual values
table(iris[, c('Is.Versicolor', 'Predict.Versicolor.lm')])
#>              Predict.Versicolor.lm
#> Is.Versicolor  0  1
#>             0 89 11
#>             1 47  3
```

Looks like all the variables were significant with p < 0.05, but the model has poor predictive power. We correctly classified 92 species with only 3 true positives. That’s pretty bad. We could refine our model, but instead, let’s attempt logistical regression.

```bash
fit.logit <- glm(Is.Versicolor ~ Petal.Length + Sepal.Length, data = iris,
                 family = binomial(link = 'logit'))
summary(fit.logit)
#> 
#> Call:
#> glm(formula = Is.Versicolor ~ Petal.Length + Sepal.Length, family = binomial(link = "logit"), 
#>     data = iris)
#> 
#> Deviance Residuals: 
#>     Min       1Q   Median       3Q      Max  
#> -1.5493  -0.9437  -0.6451   1.2645   1.7894  
#> 
#> Coefficients:
#>              Estimate Std. Error z value Pr(>|z|)   
#> (Intercept)    3.0440     1.9752   1.541  0.12328   
#> Petal.Length   0.7369     0.2282   3.229  0.00124 **
#> Sepal.Length  -1.1262     0.4611  -2.443  0.01459 * 
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> (Dispersion parameter for binomial family taken to be 1)
#> 
#>     Null deviance: 190.95  on 149  degrees of freedom
#> Residual deviance: 178.32  on 147  degrees of freedom
#> AIC: 184.32
#> 
#> Number of Fisher Scoring iterations: 4
iris[['Predict.Versicolor.logit']] <- as.numeric(predict(fit.logit) > 0.5)
table(iris[, c('Is.Versicolor', 'Predict.Versicolor.logit')])
#>              Predict.Versicolor.logit
#> Is.Versicolor  0  1
#>             0 99  1
#>             1 50  0
```

Our model is far too conservative. It only predicted one versicolor! Both explanatory variables are significant with p < 0.05, however the intercept is not.
