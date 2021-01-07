---
title: "RMarkdown Practice"
author: "Gurshan Rai"
date: "1/6/2021"
output: 
  html_document: 
    keep_md: yes
---






```r
#install.packages("tidyverse")
library("tidyverse")
```

```r
ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar()
```

![](Markdown-Practice_files/figure-html/unnamed-chunk-2-1.png)<!-- -->
