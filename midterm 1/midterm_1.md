---
title: "Midterm 1"
author: "Gurshan Rai"
date: "2021-01-26"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Be sure to **add your name** to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 12 total questions.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by **12:00p on Thursday, January 28**.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
library(janitor)
library(skimr)
```

## Questions
**1. (2 points) Briefly explain how R, RStudio, and GitHub work together to make work flows in data science transparent and repeatable. What is the advantage of using RMarkdown in this context?**  

Rstudio provides a clean and easy to use interface(GUI) for us to interact with the coding language R. In this context Rmarkdown allows us to come back to our work in a manner that is clean and easy to interpret by making a report than we can come back and reference later. We can upload all of these files created by Rstudio to Github where we can reference them in the future or use them to collaborate with others. 

**2. (2 points) What are the three types of `data structures` that we have discussed? Why are we using data frames for BIS 15L?**

The three types of data structures we have discussed are vectors, data matrices, and data frames. We are using data frames because they most similar to a spreadsheet and allow us to store data in different classes. Thus data frames allow us to store data that scientists attach to their work allowing us to interpret data and/or repeat experiments.

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

**3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.**

```r
elephants <- readr::read_csv("data/ElephantsMF.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   Age = col_double(),
##   Height = col_double(),
##   Sex = col_character()
## )
```

```r
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ Age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17...
## $ Height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204....
## $ Sex    <chr> "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", ...
```

**4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.**

```r
elephants <- janitor::clean_names(elephants)
elephants$sex <- as.factor(elephants$sex)
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17...
## $ height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204....
## $ sex    <fct> M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, ...
```


**5. (2 points) How many male and female elephants are represented in the data?**

```r
names(elephants)
```

```
## [1] "age"    "height" "sex"
```

```r
elephants %>% 
  count(sex, sort=T)
```

```
## # A tibble: 2 x 2
##   sex       n
##   <fct> <int>
## 1 F       150
## 2 M       138
```
**6. (2 points) What is the average age all elephants in the data?**

```r
elephants %>% 
  summarise(average_age=mean(age))
```

```
## # A tibble: 1 x 1
##   average_age
##         <dbl>
## 1        11.0
```

**7. (2 points) How does the average age and height of elephants compare by sex?**

```r
elephants %>% 
  group_by(sex) %>% 
  summarise(average_age=mean(age),
            average_height=mean(height))
```

```
## # A tibble: 2 x 3
##   sex   average_age average_height
## * <fct>       <dbl>          <dbl>
## 1 F           12.8            190.
## 2 M            8.95           185.
```

**8. (2 points) How does the average height of elephants compare by sex for individuals over 25 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.**

```r
elephants %>% 
  filter(age > "25") %>% 
  group_by(sex) %>% 
  summarise(average_old_height=mean(height),
            min_old_height=min(height),
            max_old_height=max(height))
```

```
## # A tibble: 2 x 4
##   sex   average_old_height min_old_height max_old_height
## * <fct>              <dbl>          <dbl>          <dbl>
## 1 F                   201.           123.           278.
## 2 M                   195.           136.           304.
```


For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

**9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.**

```r
vertebrates <- readr::read_csv("data/IvindoData_Dryadversion.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   HuntCat = col_character(),
##   LandUse = col_character()
## )
## i Use `spec()` for the full column specifications.
```

```r
tidy_vertebrates <- janitor::clean_names(vertebrates)
tidy_vertebrates$hunt_cat <- as.factor(tidy_vertebrates$hunt_cat)
tidy_vertebrates$land_use <- as.factor(tidy_vertebrates$land_use)
glimpse(tidy_vertebrates)
```

```
## Rows: 24
## Columns: 26
## $ transect_id              <dbl> 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 13, 14, 15, ...
## $ distance                 <dbl> 7.14, 17.31, 18.32, 20.85, 15.95, 17.47, 2...
## $ hunt_cat                 <fct> Moderate, None, None, None, None, None, No...
## $ num_households           <dbl> 54, 54, 29, 29, 29, 29, 29, 54, 25, 73, 46...
## $ land_use                 <fct> Park, Park, Park, Logging, Park, Park, Par...
## $ veg_rich                 <dbl> 16.67, 15.75, 16.88, 12.44, 17.13, 16.50, ...
## $ veg_stems                <dbl> 31.20, 37.44, 32.33, 29.39, 36.00, 29.22, ...
## $ veg_liana                <dbl> 5.78, 13.25, 4.75, 9.78, 13.25, 12.88, 8.3...
## $ veg_dbh                  <dbl> 49.57, 34.59, 42.82, 36.62, 41.52, 44.07, ...
## $ veg_canopy               <dbl> 3.78, 3.75, 3.43, 3.75, 3.88, 2.50, 4.00, ...
## $ veg_understory           <dbl> 2.89, 3.88, 3.00, 2.75, 3.25, 3.00, 2.38, ...
## $ ra_apes                  <dbl> 1.87, 0.00, 4.49, 12.93, 0.00, 2.48, 3.78,...
## $ ra_birds                 <dbl> 52.66, 52.17, 37.44, 59.29, 52.62, 38.64, ...
## $ ra_elephant              <dbl> 0.00, 0.86, 1.33, 0.56, 1.00, 0.00, 1.11, ...
## $ ra_monkeys               <dbl> 38.59, 28.53, 41.82, 19.85, 41.34, 43.29, ...
## $ ra_rodent                <dbl> 4.22, 6.04, 1.06, 3.66, 2.52, 1.83, 3.10, ...
## $ ra_ungulate              <dbl> 2.66, 12.41, 13.86, 3.71, 2.53, 13.75, 3.1...
## $ rich_all_species         <dbl> 22, 20, 22, 19, 20, 22, 23, 19, 19, 19, 21...
## $ evenness_all_species     <dbl> 0.793, 0.773, 0.740, 0.681, 0.811, 0.786, ...
## $ diversity_all_species    <dbl> 2.452, 2.314, 2.288, 2.006, 2.431, 2.429, ...
## $ rich_bird_species        <dbl> 11, 10, 11, 8, 8, 10, 11, 11, 11, 9, 11, 1...
## $ evenness_bird_species    <dbl> 0.732, 0.704, 0.688, 0.559, 0.799, 0.771, ...
## $ diversity_bird_species   <dbl> 1.756, 1.620, 1.649, 1.162, 1.660, 1.775, ...
## $ rich_mammal_species      <dbl> 11, 10, 11, 11, 12, 12, 12, 8, 8, 10, 10, ...
## $ evenness_mammal_species  <dbl> 0.736, 0.705, 0.650, 0.619, 0.736, 0.694, ...
## $ diversity_mammal_species <dbl> 1.764, 1.624, 1.558, 1.484, 1.829, 1.725, ...
```

**10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?**

```r
tidy_vertebrates %>% 
  group_by(hunt_cat) %>%
  filter(hunt_cat!="None") %>% 
  summarise(avg_bird_diversity=mean(diversity_bird_species),
            avg_mammal_diversity=mean(diversity_mammal_species))
```

```
## # A tibble: 2 x 3
##   hunt_cat avg_bird_diversity avg_mammal_diversity
##   <fct>                 <dbl>                <dbl>
## 1 High                   1.66                 1.74
## 2 Moderate               1.62                 1.68
```


**11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 5km from a village to sites that are greater than 20km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.**  


```r
tidy_vertebrates %>% 
  filter(distance<5) %>% 
  summarise(across(c(contains("ra")),mean))
```

```
## # A tibble: 1 x 7
##   transect_id ra_apes ra_birds ra_elephant ra_monkeys ra_rodent ra_ungulate
##         <dbl>   <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1        19.7    0.08     70.4      0.0967       24.1      3.66        1.59
```

```r
tidy_vertebrates %>% 
  filter(distance>20) %>% 
  summarise(across(c(contains("ra")),mean))
```

```
## # A tibble: 1 x 7
##   transect_id ra_apes ra_birds ra_elephant ra_monkeys ra_rodent ra_ungulate
##         <dbl>   <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1          11    7.21     44.5       0.557       40.1      2.68        4.98
```

```r
tidy_vertebrates %>% 
  filter(distance<5) %>% 
  summarise(across(c(ra_apes, ra_birds, ra_elephant, ra_monkeys, ra_ungulate),mean))
```

```
## # A tibble: 1 x 5
##   ra_apes ra_birds ra_elephant ra_monkeys ra_ungulate
##     <dbl>    <dbl>       <dbl>      <dbl>       <dbl>
## 1    0.08     70.4      0.0967       24.1        1.59
```

**12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`**

```r
tidy_vertebrates %>% 
  filter(ra_elephant>1) %>% 
  summarise(across(c(contains("veg")), mean))
```

```
## # A tibble: 1 x 6
##   veg_rich veg_stems veg_liana veg_dbh veg_canopy veg_understory
##      <dbl>     <dbl>     <dbl>   <dbl>      <dbl>          <dbl>
## 1     14.0      31.1      7.63    45.5       3.43           2.94
```

