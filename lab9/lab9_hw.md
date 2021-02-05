---
title: "Lab 9 Homework"
author: "Gurshan Rai"
date: "2021-02-04"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
```

For this homework, we will take a departure from biological data and use data about California colleges. These data are a subset of the national college scorecard (https://collegescorecard.ed.gov/data/). Load the `ca_college_data.csv` as a new object called `colleges`.

```r
colleges <- readr::read_csv("data/ca_college_data.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   INSTNM = col_character(),
##   CITY = col_character(),
##   STABBR = col_character(),
##   ZIP = col_character(),
##   ADM_RATE = col_double(),
##   SAT_AVG = col_double(),
##   PCIP26 = col_double(),
##   COSTT4_A = col_double(),
##   C150_4_POOLED = col_double(),
##   PFTFTUG1_EF = col_double()
## )
```

The variables are a bit hard to decipher, here is a key:  

INSTNM: Institution name  
CITY: California city  
STABBR: Location state  
ZIP: Zip code  
ADM_RATE: Admission rate  
SAT_AVG: SAT average score  
PCIP26: Percentage of degrees awarded in Biological And Biomedical Sciences  
COSTT4_A: Annual cost of attendance  
C150_4_POOLED: 4-year completion rate  
PFTFTUG1_EF: Percentage of undergraduate students who are first-time, full-time degree/certificate-seeking undergraduate students  

1. Use your preferred function(s) to have a look at the data and get an idea of its structure. Make sure you summarize NA's and determine whether or not the data are tidy. You may also consider dealing with any naming issues.

```r
summary(colleges)
```

```
##     INSTNM              CITY              STABBR              ZIP           
##  Length:341         Length:341         Length:341         Length:341        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     ADM_RATE         SAT_AVG         PCIP26           COSTT4_A    
##  Min.   :0.0807   Min.   : 870   Min.   :0.00000   Min.   : 7956  
##  1st Qu.:0.4581   1st Qu.: 985   1st Qu.:0.00000   1st Qu.:12578  
##  Median :0.6370   Median :1078   Median :0.00000   Median :16591  
##  Mean   :0.5901   Mean   :1112   Mean   :0.01981   Mean   :26685  
##  3rd Qu.:0.7461   3rd Qu.:1237   3rd Qu.:0.02457   3rd Qu.:39289  
##  Max.   :1.0000   Max.   :1555   Max.   :0.21650   Max.   :69355  
##  NA's   :240      NA's   :276    NA's   :35        NA's   :124    
##  C150_4_POOLED     PFTFTUG1_EF    
##  Min.   :0.0625   Min.   :0.0064  
##  1st Qu.:0.4265   1st Qu.:0.3212  
##  Median :0.5845   Median :0.5016  
##  Mean   :0.5705   Mean   :0.5577  
##  3rd Qu.:0.7162   3rd Qu.:0.8117  
##  Max.   :0.9569   Max.   :1.0000  
##  NA's   :221      NA's   :53
```


```r
naniar::miss_var_summary(colleges)
```

```
## # A tibble: 10 x 3
##    variable      n_miss pct_miss
##    <chr>          <int>    <dbl>
##  1 SAT_AVG          276     80.9
##  2 ADM_RATE         240     70.4
##  3 C150_4_POOLED    221     64.8
##  4 COSTT4_A         124     36.4
##  5 PFTFTUG1_EF       53     15.5
##  6 PCIP26            35     10.3
##  7 INSTNM             0      0  
##  8 CITY               0      0  
##  9 STABBR             0      0  
## 10 ZIP                0      0
```


```r
colleges_tidy <- colleges %>% 
  janitor::clean_names() %>% 
  rename(institution = "instnm", state = "stabbr", pct_bio_completion = "pcip26", total_cost = "costt4_a", pct_completion_rate = "c150_4_pooled", pct_traditional_students = "pftftug1_ef")
  

colleges
```

```
## # A tibble: 341 x 10
##    INSTNM CITY  STABBR ZIP   ADM_RATE SAT_AVG PCIP26 COSTT4_A C150_4_POOLED
##    <chr>  <chr> <chr>  <chr>    <dbl>   <dbl>  <dbl>    <dbl>         <dbl>
##  1 Gross~ El C~ CA     9202~       NA      NA 0.0016     7956        NA    
##  2 Colle~ Visa~ CA     9327~       NA      NA 0.0066     8109        NA    
##  3 Colle~ San ~ CA     9440~       NA      NA 0.0038     8278        NA    
##  4 Ventu~ Vent~ CA     9300~       NA      NA 0.0035     8407        NA    
##  5 Oxnar~ Oxna~ CA     9303~       NA      NA 0.0085     8516        NA    
##  6 Moorp~ Moor~ CA     9302~       NA      NA 0.0151     8577        NA    
##  7 Skyli~ San ~ CA     9406~       NA      NA 0          8580         0.233
##  8 Glend~ Glen~ CA     9120~       NA      NA 0.002      9181        NA    
##  9 Citru~ Glen~ CA     9174~       NA      NA 0.0021     9281        NA    
## 10 Fresn~ Fres~ CA     93741       NA      NA 0.0324     9370        NA    
## # ... with 331 more rows, and 1 more variable: PFTFTUG1_EF <dbl>
```

2. Which cities in California have the highest number of colleges?

```r
colleges_tidy %>%
  count(city, sort=T)
```

```
## # A tibble: 161 x 2
##    city              n
##    <chr>         <int>
##  1 Los Angeles      24
##  2 San Diego        18
##  3 San Francisco    15
##  4 Sacramento       10
##  5 Berkeley          9
##  6 Oakland           9
##  7 Claremont         7
##  8 Pasadena          6
##  9 Fresno            5
## 10 Irvine            5
## # ... with 151 more rows
```

3. Based on your answer to #2, make a plot that shows the number of colleges in the top 10 cities.

```r
colleges_tidy %>%
  count(city, sort=T) %>% 
  top_n(10, n) %>% 
  filter(city!= "Riverside" & city!= "San Jose") %>% 
  ggplot(aes(x= city, y=n))+
  geom_col()
```

![](lab9_hw_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

4. The column `COSTT4_A` is the annual cost of each institution. Which city has the highest average cost? Where is it located?

```r
#names(colleges_tidy)
colleges_tidy %>%
  group_by(city) %>% 
  summarise(city_costs = mean(total_cost, na.rm = T)) %>% 
  arrange(desc(city_costs))
```

```
## # A tibble: 161 x 2
##    city                city_costs
##    <chr>                    <dbl>
##  1 Claremont                66498
##  2 Malibu                   66152
##  3 Valencia                 64686
##  4 Orange                   64501
##  5 Redlands                 61542
##  6 Moraga                   61095
##  7 Atherton                 56035
##  8 Thousand Oaks            54373
##  9 Rancho Palos Verdes      50758
## 10 La Verne                 50603
## # ... with 151 more rows
```

5. Based on your answer to #4, make a plot that compares the cost of the individual colleges in the most expensive city. Bonus! Add UC Davis here to see how it compares :>).

```r
colleges_tidy %>% 
  #filter(total_cost=="NA") %>% 
  filter(city=="Claremont" | institution == "University of California-Davis") %>% 
  ggplot(aes(x=institution, y=total_cost))+
  geom_col()
```

```
## Warning: Removed 2 rows containing missing values (position_stack).
```

![](lab9_hw_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

6. The column `ADM_RATE` is the admissions rate by college and `C150_4_POOLED` is the four-year completion rate. Use a scatterplot to show the relationship between these two variables. What do you think this means?

```r
#names(colleges_tidy)
ggplot(data=colleges_tidy, mapping= aes(x=adm_rate, y=pct_completion_rate))+
  geom_point()+
  geom_smooth(method=lm, se=T)
```

```
## `geom_smooth()` using formula 'y ~ x'
```

```
## Warning: Removed 251 rows containing non-finite values (stat_smooth).
```

```
## Warning: Removed 251 rows containing missing values (geom_point).
```

![](lab9_hw_files/figure-html/unnamed-chunk-10-1.png)<!-- -->
There is a correlation between a higher admission rate and a lower percent completion.

7. Is there a relationship between cost and four-year completion rate? (You don't need to do the stats, just produce a plot). What do you think this means?

```r
ggplot(data=colleges_tidy, mapping= aes(x=total_cost, y=pct_completion_rate))+
  geom_point()+
  geom_smooth(method=lm, se=T)
```

```
## `geom_smooth()` using formula 'y ~ x'
```

```
## Warning: Removed 225 rows containing non-finite values (stat_smooth).
```

```
## Warning: Removed 225 rows containing missing values (geom_point).
```

![](lab9_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->
There is a correlation between inreasing cost and increasing completion rates.

8. The column titled `INSTNM` is the institution name. We are only interested in the University of California colleges. Make a new data frame that is restricted to UC institutions. You can remove `Hastings College of Law` and `UC San Francisco` as we are only interested in undergraduate institutions.


Remove `Hastings College of Law` and `UC San Francisco` and store the final data frame as a new object `univ_calif_final`.

```r
univ_calif_final <- colleges_tidy %>% 
  filter(stringr::str_detect(institution, 'University of California-') ) %>% 
  filter(institution != "University of California-Hastings College of Law" & institution != "University of California-San Francisco")

univ_calif_final
```

```
## # A tibble: 8 x 10
##   institution city  state zip   adm_rate sat_avg pct_bio_complet~ total_cost
##   <chr>       <chr> <chr> <chr>    <dbl>   <dbl>            <dbl>      <dbl>
## 1 University~ La J~ CA    92093    0.357    1324            0.216      31043
## 2 University~ Irvi~ CA    92697    0.406    1206            0.107      31198
## 3 University~ Rive~ CA    92521    0.663    1078            0.149      31494
## 4 University~ Los ~ CA    9009~    0.180    1334            0.155      33078
## 5 University~ Davis CA    9561~    0.423    1218            0.198      33904
## 6 University~ Sant~ CA    9506~    0.578    1201            0.193      34608
## 7 University~ Berk~ CA    94720    0.169    1422            0.105      34924
## 8 University~ Sant~ CA    93106    0.358    1281            0.108      34998
## # ... with 2 more variables: pct_completion_rate <dbl>,
## #   pct_traditional_students <dbl>
```

Use `separate()` to separate institution name into two new columns "UNIV" and "CAMPUS".

```r
univ_calif_wider <- univ_calif_final %>% 
  separate(institution, into = c("univ", "campus"), sep = "-")
```

9. The column `ADM_RATE` is the admissions rate by campus. Which UC has the lowest and highest admissions rates? Produce a numerical summary and an appropriate plot.

```r
univ_calif_wider %>% 
  summarise(most_admits=max(adm_rate),
            least_admit=min(adm_rate))
```

```
## # A tibble: 1 x 2
##   most_admits least_admit
##         <dbl>       <dbl>
## 1       0.663       0.169
```

```r
univ_calif_wider %>% 
  arrange(desc(adm_rate))
```

```
## # A tibble: 8 x 11
##   univ  campus city  state zip   adm_rate sat_avg pct_bio_complet~ total_cost
##   <chr> <chr>  <chr> <chr> <chr>    <dbl>   <dbl>            <dbl>      <dbl>
## 1 Univ~ River~ Rive~ CA    92521    0.663    1078            0.149      31494
## 2 Univ~ Santa~ Sant~ CA    9506~    0.578    1201            0.193      34608
## 3 Univ~ Davis  Davis CA    9561~    0.423    1218            0.198      33904
## 4 Univ~ Irvine Irvi~ CA    92697    0.406    1206            0.107      31198
## 5 Univ~ Santa~ Sant~ CA    93106    0.358    1281            0.108      34998
## 6 Univ~ San D~ La J~ CA    92093    0.357    1324            0.216      31043
## 7 Univ~ Los A~ Los ~ CA    9009~    0.180    1334            0.155      33078
## 8 Univ~ Berke~ Berk~ CA    94720    0.169    1422            0.105      34924
## # ... with 2 more variables: pct_completion_rate <dbl>,
## #   pct_traditional_students <dbl>
```


```r
univ_calif_wider %>% 
  ggplot(aes(x=campus, y=adm_rate))+
  geom_col()
```

![](lab9_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

10. If you wanted to get a degree in biological or biomedical sciences, which campus confers the majority of these degrees? Produce a numerical summary and an appropriate plot.

```r
univ_calif_wider %>% 
  summarise(most_bio=max(pct_bio_completion),
            least_admit=min(pct_bio_completion))
```

```
## # A tibble: 1 x 2
##   most_bio least_admit
##      <dbl>       <dbl>
## 1    0.216       0.105
```

```r
univ_calif_wider %>% 
  arrange(desc(pct_bio_completion))
```

```
## # A tibble: 8 x 11
##   univ  campus city  state zip   adm_rate sat_avg pct_bio_complet~ total_cost
##   <chr> <chr>  <chr> <chr> <chr>    <dbl>   <dbl>            <dbl>      <dbl>
## 1 Univ~ San D~ La J~ CA    92093    0.357    1324            0.216      31043
## 2 Univ~ Davis  Davis CA    9561~    0.423    1218            0.198      33904
## 3 Univ~ Santa~ Sant~ CA    9506~    0.578    1201            0.193      34608
## 4 Univ~ Los A~ Los ~ CA    9009~    0.180    1334            0.155      33078
## 5 Univ~ River~ Rive~ CA    92521    0.663    1078            0.149      31494
## 6 Univ~ Santa~ Sant~ CA    93106    0.358    1281            0.108      34998
## 7 Univ~ Irvine Irvi~ CA    92697    0.406    1206            0.107      31198
## 8 Univ~ Berke~ Berk~ CA    94720    0.169    1422            0.105      34924
## # ... with 2 more variables: pct_completion_rate <dbl>,
## #   pct_traditional_students <dbl>
```


```r
univ_calif_wider %>% 
  ggplot(aes(x=campus, y=pct_bio_completion))+
  geom_col()
```

![](lab9_hw_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

## Knit Your Output and Post to [GitHub](https://github.com/FRS417-DataScienceBiologists)
