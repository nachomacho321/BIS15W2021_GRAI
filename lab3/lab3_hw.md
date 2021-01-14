---
title: "Lab 3 Homework"
author: "Gurshan Rai"
date: "2021-01-13"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse

```r
library(tidyverse)
```

## Mammals Sleep
1. For this assignment, we are going to use built-in data on mammal sleep patterns. From which publication are these data taken from? Since the data are built-in you can use the help function in R.

The data is takn from  V. M. Savage and G. B. West.A quantitative, theoretical framework for understanding mammalian slee

```r
?msleep
```

```
## starting httpd help server ... done
```

```r
getwd()
```

```
## [1] "C:/Users/Gurshan Rai/OneDrive/Desktop/GitHub/BIS15W2021_GRAI/lab3"
```

2. Store these data into a new data frame `sleep`.

```r
sleep <- msleep
sleep
```

```
## # A tibble: 83 x 11
##    name  genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##    <chr> <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
##  1 Chee~ Acin~ carni Carn~ lc                  12.1      NA        NA      11.9
##  2 Owl ~ Aotus omni  Prim~ <NA>                17         1.8      NA       7  
##  3 Moun~ Aplo~ herbi Rode~ nt                  14.4       2.4      NA       9.6
##  4 Grea~ Blar~ omni  Sori~ lc                  14.9       2.3       0.133   9.1
##  5 Cow   Bos   herbi Arti~ domesticated         4         0.7       0.667  20  
##  6 Thre~ Brad~ herbi Pilo~ <NA>                14.4       2.2       0.767   9.6
##  7 Nort~ Call~ carni Carn~ vu                   8.7       1.4       0.383  15.3
##  8 Vesp~ Calo~ <NA>  Rode~ <NA>                 7        NA        NA      17  
##  9 Dog   Canis carni Carn~ domesticated        10.1       2.9       0.333  13.9
## 10 Roe ~ Capr~ herbi Arti~ lc                   3        NA        NA      21  
## # ... with 73 more rows, and 2 more variables: brainwt <dbl>, bodywt <dbl>
```

3. What are the dimensions of this data frame (variables and observations)? How do you know? Please show the *code* that you used to determine this below.  

The dimensions are 83 rows and 11 columns. We knows this by using the dim() function on our data frame. 


```r
dim(sleep)
```

```
## [1] 83 11
```

4. Are there any NAs in the data? How did you determine this? Please show your code.  

We know through observation there area NAs in the data. We prove this through code by using the is.na() function inside the which() function.


```r
sleep_NA <- which(is.na(sleep))
sleep_NA
```

```
##   [1] 174 221 223 224 229 235 239 334 338 340 348 359 361 366 370 373 375 377
##  [19] 382 386 389 390 393 397 398 400 401 405 407 408 410 411 412 413 414 415
##  [37] 499 506 508 519 525 534 539 542 543 545 549 550 551 554 555 558 563 568
##  [55] 573 574 578 580 582 583 584 589 591 592 594 596 597 600 602 605 607 608
##  [73] 611 612 613 614 616 617 618 620 622 625 626 627 628 630 632 633 634 636
##  [91] 637 638 639 640 641 642 643 644 646 647 650 651 653 656 657 659 661 662
## [109] 663 748 750 753 754 755 760 774 777 778 782 784 786 788 791 793 794 798
## [127] 800 803 804 806 807 808 812 819 823 827
```

5. Show a list of the column names is this data frame.

```r
names(sleep)
```

```
##  [1] "name"         "genus"        "vore"         "order"        "conservation"
##  [6] "sleep_total"  "sleep_rem"    "sleep_cycle"  "awake"        "brainwt"     
## [11] "bodywt"
```

6. How many herbivores are represented in the data?  

32 herbivores are represented in this data. 


```r
plant_based <- subset(sleep, vore == "herbi")
nrow(plant_based)
```

```
## [1] 32
```

```r
table(sleep$vore)
```

```
## 
##   carni   herbi insecti    omni 
##      19      32       5      20
```

7. We are interested in two groups; small and large mammals. Let's define small as less than or equal to 1kg body weight and large as greater than or equal to 200kg body weight. Make two new dataframes (large and small) based on these parameters.

```r
small <- subset(sleep, bodywt <= 1)
large <- subset(sleep, bodywt >= 200)
```

8. What is the mean weight for both the small and large mammals?

```r
complete_small <- small[complete.cases(small), ]
mean(complete_small$bodywt)
```

```
## [1] 0.2366364
```


```r
complete_large <- large[complete.cases(large), ]
mean(complete_large$bodywt)
```

```
## [1] 442.8337
```

9. Using a similar approach as above, do large or small animals sleep longer on average?  

We see that small animals sleep longer than average


```r
isTRUE( mean(small$sleep_total)> mean(large$sleep_total))
```

```
## [1] TRUE
```


10. Which animal is the sleepiest among the entire dataframe?

The sleepiest animal in the entire dataframe is the little brown bat.


```r
which(sleep$sleep_total == max(sleep$sleep_total), arr.ind = FALSE, useNames = TRUE)
```

```
## [1] 43
```


```r
sleep[43,1]
```

```
## # A tibble: 1 x 1
##   name            
##   <chr>           
## 1 Little brown bat
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
