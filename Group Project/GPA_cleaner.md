---
title: "Cleaned GPAs"
author: "Gurshan Rai"
date: "3/1/2021"
output: 
  html_document: 
    keep_md: yes
---




```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.0 --
```

```
## v ggplot2 3.3.3     v purrr   0.3.4
## v tibble  3.0.6     v dplyr   1.0.4
## v tidyr   1.1.2     v stringr 1.4.0
## v readr   1.4.0     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(naniar)
```

##Calling 2021 GPA

```r
GPAs_2021 <- readr::read_csv("data/2021TermGPA.csv") %>% 
  janitor::clean_names()
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   Grade = col_double(),
##   `Rolling Cum GPA` = col_double(),
##   `Term 1` = col_double(),
##   `Term 2` = col_double()
## )
```
##Visualizing 2021 Data

```r
summary(GPAs_2021)
```

```
##      grade       rolling_cum_gpa     term_1          term_2     
##  Min.   :6.000   Min.   :0.500   Min.   :0.000   Min.   :0.000  
##  1st Qu.:6.000   1st Qu.:1.829   1st Qu.:1.429   1st Qu.:1.429  
##  Median :7.000   Median :2.457   Median :2.286   Median :2.286  
##  Mean   :6.918   Mean   :2.514   Mean   :2.309   Mean   :2.280  
##  3rd Qu.:8.000   3rd Qu.:3.217   3rd Qu.:3.286   3rd Qu.:3.143  
##  Max.   :8.000   Max.   :4.000   Max.   :4.000   Max.   :4.000  
##                  NA's   :359     NA's   :11      NA's   :20
```
##What exactly is rolling cumulative GPA and why are so many values missing? Are the NA's in general reflective of truant students, students who switched schools, etc...?

```r
naniar::miss_var_summary(GPAs_2021)
```

```
## # A tibble: 4 x 3
##   variable        n_miss pct_miss
##   <chr>            <int>    <dbl>
## 1 rolling_cum_gpa    359    39.5 
## 2 term_2              20     2.20
## 3 term_1              11     1.21
## 4 grade                0     0
```
##Calling 1920 GPA

```r
GPAs_1920 <- readr::read_csv("data/1920TermGPA.csv") %>% 
  janitor::clean_names()
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   Grade = col_double(),
##   `Rolling Cum GPA` = col_double(),
##   `Term 1` = col_double(),
##   `Term 2` = col_double()
## )
```
##Visualizing 1920 Data

```r
summary(GPAs_1920)
```

```
##      grade       rolling_cum_gpa     term_1          term_2     
##  Min.   :6.000   Min.   :0.536   Min.   :0.571   Min.   :0.429  
##  1st Qu.:6.000   1st Qu.:2.289   1st Qu.:2.571   1st Qu.:2.286  
##  Median :7.000   Median :2.800   Median :3.000   Median :2.857  
##  Mean   :7.008   Mean   :2.784   Mean   :2.939   Mean   :2.785  
##  3rd Qu.:8.000   3rd Qu.:3.301   3rd Qu.:3.571   3rd Qu.:3.429  
##  Max.   :8.000   Max.   :4.000   Max.   :4.000   Max.   :4.000  
##                  NA's   :364     NA's   :25      NA's   :56
```

```r
miss_var_summary(GPAs_1920)
```

```
## # A tibble: 4 x 3
##   variable        n_miss pct_miss
##   <chr>            <int>    <dbl>
## 1 rolling_cum_gpa    364    38.2 
## 2 term_2              56     5.88
## 3 term_1              25     2.63
## 4 grade                0     0
```

