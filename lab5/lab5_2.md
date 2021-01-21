---
title: "dplyr Superhero"
date: "2021-01-21"
output:
  html_document: 
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
---

## Breakout Rooms  
Please take 5-8 minutes to check over your answers to the HW in your group. If you are stuck, please remember that you can check the key in [Joel's repository](https://github.com/jmledford3115/BIS15LW2021_jledford).  

## Learning Goals  
*At the end of this exercise, you will be able to:*    
1. Develop your dplyr superpowers so you can easily and confidently manipulate dataframes.  
2. Learn helpful new functions that are part of the `janitor` package.  

## Instructions
For the second part of lab 5 today, we are going to spend time practicing the dplyr functions we have learned and add a few new ones. We will spend most of the time in our breakout rooms. Your lab 5 homework will be to knit and push this file to your repository.  

## Load the tidyverse

```r
library("tidyverse")
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.0 --
```

```
## v ggplot2 3.3.3     v purrr   0.3.4
## v tibble  3.0.4     v dplyr   1.0.2
## v tidyr   1.1.2     v stringr 1.4.0
## v readr   1.4.0     v forcats 0.5.0
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

## Load the superhero data
These are data taken from comic books and assembled by fans. The include a good mix of categorical and continuous data.  Data taken from: https://www.kaggle.com/claudiodavi/superhero-set  

Check out the way I am loading these data. If I know there are NAs, I can take care of them at the beginning. But, we should do this very cautiously. At times it is better to keep the original columns and data intact.  

```r
superhero_info <- readr::read_csv("data/heroes_information.csv", na = c("", "-99", "-"))
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   name = col_character(),
##   Gender = col_character(),
##   `Eye color` = col_character(),
##   Race = col_character(),
##   `Hair color` = col_character(),
##   Height = col_double(),
##   Publisher = col_character(),
##   `Skin color` = col_character(),
##   Alignment = col_character(),
##   Weight = col_double()
## )
```

```r
superhero_powers <- readr::read_csv("data/super_hero_powers.csv", na = c("", "-99", "-"))
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_logical(),
##   hero_names = col_character()
## )
## i Use `spec()` for the full column specifications.
```

```r
names(superhero_powers)
```

```
##   [1] "hero_names"                   "Agility"                     
##   [3] "Accelerated Healing"          "Lantern Power Ring"          
##   [5] "Dimensional Awareness"        "Cold Resistance"             
##   [7] "Durability"                   "Stealth"                     
##   [9] "Energy Absorption"            "Flight"                      
##  [11] "Danger Sense"                 "Underwater breathing"        
##  [13] "Marksmanship"                 "Weapons Master"              
##  [15] "Power Augmentation"           "Animal Attributes"           
##  [17] "Longevity"                    "Intelligence"                
##  [19] "Super Strength"               "Cryokinesis"                 
##  [21] "Telepathy"                    "Energy Armor"                
##  [23] "Energy Blasts"                "Duplication"                 
##  [25] "Size Changing"                "Density Control"             
##  [27] "Stamina"                      "Astral Travel"               
##  [29] "Audio Control"                "Dexterity"                   
##  [31] "Omnitrix"                     "Super Speed"                 
##  [33] "Possession"                   "Animal Oriented Powers"      
##  [35] "Weapon-based Powers"          "Electrokinesis"              
##  [37] "Darkforce Manipulation"       "Death Touch"                 
##  [39] "Teleportation"                "Enhanced Senses"             
##  [41] "Telekinesis"                  "Energy Beams"                
##  [43] "Magic"                        "Hyperkinesis"                
##  [45] "Jump"                         "Clairvoyance"                
##  [47] "Dimensional Travel"           "Power Sense"                 
##  [49] "Shapeshifting"                "Peak Human Condition"        
##  [51] "Immortality"                  "Camouflage"                  
##  [53] "Element Control"              "Phasing"                     
##  [55] "Astral Projection"            "Electrical Transport"        
##  [57] "Fire Control"                 "Projection"                  
##  [59] "Summoning"                    "Enhanced Memory"             
##  [61] "Reflexes"                     "Invulnerability"             
##  [63] "Energy Constructs"            "Force Fields"                
##  [65] "Self-Sustenance"              "Anti-Gravity"                
##  [67] "Empathy"                      "Power Nullifier"             
##  [69] "Radiation Control"            "Psionic Powers"              
##  [71] "Elasticity"                   "Substance Secretion"         
##  [73] "Elemental Transmogrification" "Technopath/Cyberpath"        
##  [75] "Photographic Reflexes"        "Seismic Power"               
##  [77] "Animation"                    "Precognition"                
##  [79] "Mind Control"                 "Fire Resistance"             
##  [81] "Power Absorption"             "Enhanced Hearing"            
##  [83] "Nova Force"                   "Insanity"                    
##  [85] "Hypnokinesis"                 "Animal Control"              
##  [87] "Natural Armor"                "Intangibility"               
##  [89] "Enhanced Sight"               "Molecular Manipulation"      
##  [91] "Heat Generation"              "Adaptation"                  
##  [93] "Gliding"                      "Power Suit"                  
##  [95] "Mind Blast"                   "Probability Manipulation"    
##  [97] "Gravity Control"              "Regeneration"                
##  [99] "Light Control"                "Echolocation"                
## [101] "Levitation"                   "Toxin and Disease Control"   
## [103] "Banish"                       "Energy Manipulation"         
## [105] "Heat Resistance"              "Natural Weapons"             
## [107] "Time Travel"                  "Enhanced Smell"              
## [109] "Illusions"                    "Thirstokinesis"              
## [111] "Hair Manipulation"            "Illumination"                
## [113] "Omnipotent"                   "Cloaking"                    
## [115] "Changing Armor"               "Power Cosmic"                
## [117] "Biokinesis"                   "Water Control"               
## [119] "Radiation Immunity"           "Vision - Telescopic"         
## [121] "Toxin and Disease Resistance" "Spatial Awareness"           
## [123] "Energy Resistance"            "Telepathy Resistance"        
## [125] "Molecular Combustion"         "Omnilingualism"              
## [127] "Portal Creation"              "Magnetism"                   
## [129] "Mind Control Resistance"      "Plant Control"               
## [131] "Sonar"                        "Sonic Scream"                
## [133] "Time Manipulation"            "Enhanced Touch"              
## [135] "Magic Resistance"             "Invisibility"                
## [137] "Sub-Mariner"                  "Radiation Absorption"        
## [139] "Intuitive aptitude"           "Vision - Microscopic"        
## [141] "Melting"                      "Wind Control"                
## [143] "Super Breath"                 "Wallcrawling"                
## [145] "Vision - Night"               "Vision - Infrared"           
## [147] "Grim Reaping"                 "Matter Absorption"           
## [149] "The Force"                    "Resurrection"                
## [151] "Terrakinesis"                 "Vision - Heat"               
## [153] "Vitakinesis"                  "Radar Sense"                 
## [155] "Qwardian Power Ring"          "Weather Control"             
## [157] "Vision - X-Ray"               "Vision - Thermal"            
## [159] "Web Creation"                 "Reality Warping"             
## [161] "Odin Force"                   "Symbiote Costume"            
## [163] "Speed Force"                  "Phoenix Force"               
## [165] "Molecular Dissipation"        "Vision - Cryo"               
## [167] "Omnipresent"                  "Omniscient"
```

```r
names(superhero_info)
```

```
##  [1] "name"       "Gender"     "Eye color"  "Race"       "Hair color"
##  [6] "Height"     "Publisher"  "Skin color" "Alignment"  "Weight"
```

## Data tidy
1. Some of the names used in the `superhero_info` data are problematic so you should rename them here.  

```r
corrected_superhero_info <- rename(superhero_info, gender = "Gender", eye_color = "Eye color", race = "Race", hair_color = "Hair color", height = "Height", publisher = "Publisher", skin_color = "Skin color", alignment = "Alignment", weight = "Weight")
corrected_superhero_info
```

```
## # A tibble: 734 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 A-Bo~ Male   yellow    Human No Hair       203 Marvel C~ <NA>       good     
##  2 Abe ~ Male   blue      Icth~ No Hair       191 Dark Hor~ blue       good     
##  3 Abin~ Male   blue      Unga~ No Hair       185 DC Comics red        good     
##  4 Abom~ Male   green     Huma~ No Hair       203 Marvel C~ <NA>       bad      
##  5 Abra~ Male   blue      Cosm~ Black          NA Marvel C~ <NA>       bad      
##  6 Abso~ Male   blue      Human No Hair       193 Marvel C~ <NA>       bad      
##  7 Adam~ Male   blue      <NA>  Blond          NA NBC - He~ <NA>       good     
##  8 Adam~ Male   blue      Human Blond         185 DC Comics <NA>       good     
##  9 Agen~ Female blue      <NA>  Blond         173 Marvel C~ <NA>       good     
## 10 Agen~ Male   brown     Human Brown         178 Marvel C~ <NA>       good     
## # ... with 724 more rows, and 1 more variable: weight <dbl>
```

Yikes! `superhero_powers` has a lot of variables that are poorly named. We need some R superpowers...

```r
head(superhero_powers)
```

```
## # A tibble: 6 x 168
##   hero_names Agility `Accelerated He~ `Lantern Power ~ `Dimensional Aw~
##   <chr>      <lgl>   <lgl>            <lgl>            <lgl>           
## 1 3-D Man    TRUE    FALSE            FALSE            FALSE           
## 2 A-Bomb     FALSE   TRUE             FALSE            FALSE           
## 3 Abe Sapien TRUE    TRUE             FALSE            FALSE           
## 4 Abin Sur   FALSE   FALSE            TRUE             FALSE           
## 5 Abominati~ FALSE   TRUE             FALSE            FALSE           
## 6 Abraxas    FALSE   FALSE            FALSE            TRUE            
## # ... with 163 more variables: `Cold Resistance` <lgl>, Durability <lgl>,
## #   Stealth <lgl>, `Energy Absorption` <lgl>, Flight <lgl>, `Danger
## #   Sense` <lgl>, `Underwater breathing` <lgl>, Marksmanship <lgl>, `Weapons
## #   Master` <lgl>, `Power Augmentation` <lgl>, `Animal Attributes` <lgl>,
## #   Longevity <lgl>, Intelligence <lgl>, `Super Strength` <lgl>,
## #   Cryokinesis <lgl>, Telepathy <lgl>, `Energy Armor` <lgl>, `Energy
## #   Blasts` <lgl>, Duplication <lgl>, `Size Changing` <lgl>, `Density
## #   Control` <lgl>, Stamina <lgl>, `Astral Travel` <lgl>, `Audio
## #   Control` <lgl>, Dexterity <lgl>, Omnitrix <lgl>, `Super Speed` <lgl>,
## #   Possession <lgl>, `Animal Oriented Powers` <lgl>, `Weapon-based
## #   Powers` <lgl>, Electrokinesis <lgl>, `Darkforce Manipulation` <lgl>, `Death
## #   Touch` <lgl>, Teleportation <lgl>, `Enhanced Senses` <lgl>,
## #   Telekinesis <lgl>, `Energy Beams` <lgl>, Magic <lgl>, Hyperkinesis <lgl>,
## #   Jump <lgl>, Clairvoyance <lgl>, `Dimensional Travel` <lgl>, `Power
## #   Sense` <lgl>, Shapeshifting <lgl>, `Peak Human Condition` <lgl>,
## #   Immortality <lgl>, Camouflage <lgl>, `Element Control` <lgl>,
## #   Phasing <lgl>, `Astral Projection` <lgl>, `Electrical Transport` <lgl>,
## #   `Fire Control` <lgl>, Projection <lgl>, Summoning <lgl>, `Enhanced
## #   Memory` <lgl>, Reflexes <lgl>, Invulnerability <lgl>, `Energy
## #   Constructs` <lgl>, `Force Fields` <lgl>, `Self-Sustenance` <lgl>,
## #   `Anti-Gravity` <lgl>, Empathy <lgl>, `Power Nullifier` <lgl>, `Radiation
## #   Control` <lgl>, `Psionic Powers` <lgl>, Elasticity <lgl>, `Substance
## #   Secretion` <lgl>, `Elemental Transmogrification` <lgl>,
## #   `Technopath/Cyberpath` <lgl>, `Photographic Reflexes` <lgl>, `Seismic
## #   Power` <lgl>, Animation <lgl>, Precognition <lgl>, `Mind Control` <lgl>,
## #   `Fire Resistance` <lgl>, `Power Absorption` <lgl>, `Enhanced
## #   Hearing` <lgl>, `Nova Force` <lgl>, Insanity <lgl>, Hypnokinesis <lgl>,
## #   `Animal Control` <lgl>, `Natural Armor` <lgl>, Intangibility <lgl>,
## #   `Enhanced Sight` <lgl>, `Molecular Manipulation` <lgl>, `Heat
## #   Generation` <lgl>, Adaptation <lgl>, Gliding <lgl>, `Power Suit` <lgl>,
## #   `Mind Blast` <lgl>, `Probability Manipulation` <lgl>, `Gravity
## #   Control` <lgl>, Regeneration <lgl>, `Light Control` <lgl>,
## #   Echolocation <lgl>, Levitation <lgl>, `Toxin and Disease Control` <lgl>,
## #   Banish <lgl>, `Energy Manipulation` <lgl>, `Heat Resistance` <lgl>, ...
```

## `janitor`
The [janitor](https://garthtarr.github.io/meatR/janitor.html) package is your friend. Make sure to install it and then load the library.  

```r
library("janitor")
```

```
## 
## Attaching package: 'janitor'
```

```
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

The `clean_names` function takes care of everything in one line! Now that's a superpower!

```r
superhero_powers <- janitor::clean_names(superhero_powers)
names(superhero_powers)
```

```
##   [1] "hero_names"                   "agility"                     
##   [3] "accelerated_healing"          "lantern_power_ring"          
##   [5] "dimensional_awareness"        "cold_resistance"             
##   [7] "durability"                   "stealth"                     
##   [9] "energy_absorption"            "flight"                      
##  [11] "danger_sense"                 "underwater_breathing"        
##  [13] "marksmanship"                 "weapons_master"              
##  [15] "power_augmentation"           "animal_attributes"           
##  [17] "longevity"                    "intelligence"                
##  [19] "super_strength"               "cryokinesis"                 
##  [21] "telepathy"                    "energy_armor"                
##  [23] "energy_blasts"                "duplication"                 
##  [25] "size_changing"                "density_control"             
##  [27] "stamina"                      "astral_travel"               
##  [29] "audio_control"                "dexterity"                   
##  [31] "omnitrix"                     "super_speed"                 
##  [33] "possession"                   "animal_oriented_powers"      
##  [35] "weapon_based_powers"          "electrokinesis"              
##  [37] "darkforce_manipulation"       "death_touch"                 
##  [39] "teleportation"                "enhanced_senses"             
##  [41] "telekinesis"                  "energy_beams"                
##  [43] "magic"                        "hyperkinesis"                
##  [45] "jump"                         "clairvoyance"                
##  [47] "dimensional_travel"           "power_sense"                 
##  [49] "shapeshifting"                "peak_human_condition"        
##  [51] "immortality"                  "camouflage"                  
##  [53] "element_control"              "phasing"                     
##  [55] "astral_projection"            "electrical_transport"        
##  [57] "fire_control"                 "projection"                  
##  [59] "summoning"                    "enhanced_memory"             
##  [61] "reflexes"                     "invulnerability"             
##  [63] "energy_constructs"            "force_fields"                
##  [65] "self_sustenance"              "anti_gravity"                
##  [67] "empathy"                      "power_nullifier"             
##  [69] "radiation_control"            "psionic_powers"              
##  [71] "elasticity"                   "substance_secretion"         
##  [73] "elemental_transmogrification" "technopath_cyberpath"        
##  [75] "photographic_reflexes"        "seismic_power"               
##  [77] "animation"                    "precognition"                
##  [79] "mind_control"                 "fire_resistance"             
##  [81] "power_absorption"             "enhanced_hearing"            
##  [83] "nova_force"                   "insanity"                    
##  [85] "hypnokinesis"                 "animal_control"              
##  [87] "natural_armor"                "intangibility"               
##  [89] "enhanced_sight"               "molecular_manipulation"      
##  [91] "heat_generation"              "adaptation"                  
##  [93] "gliding"                      "power_suit"                  
##  [95] "mind_blast"                   "probability_manipulation"    
##  [97] "gravity_control"              "regeneration"                
##  [99] "light_control"                "echolocation"                
## [101] "levitation"                   "toxin_and_disease_control"   
## [103] "banish"                       "energy_manipulation"         
## [105] "heat_resistance"              "natural_weapons"             
## [107] "time_travel"                  "enhanced_smell"              
## [109] "illusions"                    "thirstokinesis"              
## [111] "hair_manipulation"            "illumination"                
## [113] "omnipotent"                   "cloaking"                    
## [115] "changing_armor"               "power_cosmic"                
## [117] "biokinesis"                   "water_control"               
## [119] "radiation_immunity"           "vision_telescopic"           
## [121] "toxin_and_disease_resistance" "spatial_awareness"           
## [123] "energy_resistance"            "telepathy_resistance"        
## [125] "molecular_combustion"         "omnilingualism"              
## [127] "portal_creation"              "magnetism"                   
## [129] "mind_control_resistance"      "plant_control"               
## [131] "sonar"                        "sonic_scream"                
## [133] "time_manipulation"            "enhanced_touch"              
## [135] "magic_resistance"             "invisibility"                
## [137] "sub_mariner"                  "radiation_absorption"        
## [139] "intuitive_aptitude"           "vision_microscopic"          
## [141] "melting"                      "wind_control"                
## [143] "super_breath"                 "wallcrawling"                
## [145] "vision_night"                 "vision_infrared"             
## [147] "grim_reaping"                 "matter_absorption"           
## [149] "the_force"                    "resurrection"                
## [151] "terrakinesis"                 "vision_heat"                 
## [153] "vitakinesis"                  "radar_sense"                 
## [155] "qwardian_power_ring"          "weather_control"             
## [157] "vision_x_ray"                 "vision_thermal"              
## [159] "web_creation"                 "reality_warping"             
## [161] "odin_force"                   "symbiote_costume"            
## [163] "speed_force"                  "phoenix_force"               
## [165] "molecular_dissipation"        "vision_cryo"                 
## [167] "omnipresent"                  "omniscient"
```

## `tabyl`
The `janitor` package has many awesome functions that we will explore. Here is its version of `table` which not only produces counts but also percentages. Very handy! Let's use it to explore the proportion of good guys and bad guys in the `superhero_info` data.  

```r
tabyl(corrected_superhero_info, alignment)
```

```
##  alignment   n     percent valid_percent
##        bad 207 0.282016349    0.28473177
##       good 496 0.675749319    0.68225585
##    neutral  24 0.032697548    0.03301238
##       <NA>   7 0.009536785            NA
```

2. Notice that we have some neutral superheros! Who are they?

```r
filter(corrected_superhero_info, alignment == "neutral")
```

```
## # A tibble: 24 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Biza~ Male   black     Biza~ Black         191 DC Comics white      neutral  
##  2 Blac~ Male   <NA>      God ~ <NA>           NA DC Comics <NA>       neutral  
##  3 Capt~ Male   brown     Human Brown          NA DC Comics <NA>       neutral  
##  4 Copy~ Female red       Muta~ White         183 Marvel C~ blue       neutral  
##  5 Dead~ Male   brown     Muta~ No Hair       188 Marvel C~ <NA>       neutral  
##  6 Deat~ Male   blue      Human White         193 DC Comics <NA>       neutral  
##  7 Etri~ Male   red       Demon No Hair       193 DC Comics yellow     neutral  
##  8 Gala~ Male   black     Cosm~ Black         876 Marvel C~ <NA>       neutral  
##  9 Glad~ Male   blue      Stro~ Blue          198 Marvel C~ purple     neutral  
## 10 Indi~ Female <NA>      Alien Purple         NA DC Comics <NA>       neutral  
## # ... with 14 more rows, and 1 more variable: weight <dbl>
```

## `superhero_info`
3. Let's say we are only interested in the variables name, alignment, and "race". How would you isolate these variables from `superhero_info`?

```r
select(corrected_superhero_info, name, alignment, race)
```

```
## # A tibble: 734 x 3
##    name          alignment race             
##    <chr>         <chr>     <chr>            
##  1 A-Bomb        good      Human            
##  2 Abe Sapien    good      Icthyo Sapien    
##  3 Abin Sur      good      Ungaran          
##  4 Abomination   bad       Human / Radiation
##  5 Abraxas       bad       Cosmic Entity    
##  6 Absorbing Man bad       Human            
##  7 Adam Monroe   good      <NA>             
##  8 Adam Strange  good      Human            
##  9 Agent 13      good      <NA>             
## 10 Agent Bob     good      Human            
## # ... with 724 more rows
```

## Not Human
4. List all of the superheros that are not human.

```r
filter(corrected_superhero_info, race != "Human")
```

```
## # A tibble: 222 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abe ~ Male   blue      Icth~ No Hair       191 Dark Hor~ blue       good     
##  2 Abin~ Male   blue      Unga~ No Hair       185 DC Comics red        good     
##  3 Abom~ Male   green     Huma~ No Hair       203 Marvel C~ <NA>       bad      
##  4 Abra~ Male   blue      Cosm~ Black          NA Marvel C~ <NA>       bad      
##  5 Ajax  Male   brown     Cybo~ Black         193 Marvel C~ <NA>       bad      
##  6 Alien Male   <NA>      Xeno~ No Hair       244 Dark Hor~ black      bad      
##  7 Amazo Male   red       Andr~ <NA>          257 DC Comics <NA>       bad      
##  8 Angel Male   <NA>      Vamp~ <NA>           NA Dark Hor~ <NA>       good     
##  9 Ange~ Female yellow    Muta~ Black         165 Marvel C~ <NA>       good     
## 10 Anti~ Male   yellow    God ~ No Hair        61 DC Comics <NA>       bad      
## # ... with 212 more rows, and 1 more variable: weight <dbl>
```

## Good and Evil
5. Let's make two different data frames, one focused on the "good guys" and another focused on the "bad guys".

```r
good_guys <- corrected_superhero_info %>%
  filter(alignment == "good")
bad_guys <- corrected_superhero_info %>%
  filter(alignment == "bad")
```

6. For the good guys, use the `tabyl` function to summarize their "race".

```r
tabyl(good_guys, race)
```

```
##               race   n     percent valid_percent
##              Alien   3 0.006048387   0.010752688
##              Alpha   5 0.010080645   0.017921147
##             Amazon   2 0.004032258   0.007168459
##            Android   4 0.008064516   0.014336918
##             Animal   2 0.004032258   0.007168459
##          Asgardian   3 0.006048387   0.010752688
##          Atlantean   4 0.008064516   0.014336918
##         Bolovaxian   1 0.002016129   0.003584229
##              Clone   1 0.002016129   0.003584229
##             Cyborg   3 0.006048387   0.010752688
##           Demi-God   2 0.004032258   0.007168459
##              Demon   3 0.006048387   0.010752688
##            Eternal   1 0.002016129   0.003584229
##     Flora Colossus   1 0.002016129   0.003584229
##        Frost Giant   1 0.002016129   0.003584229
##      God / Eternal   6 0.012096774   0.021505376
##             Gungan   1 0.002016129   0.003584229
##              Human 148 0.298387097   0.530465950
##         Human-Kree   2 0.004032258   0.007168459
##      Human-Spartoi   1 0.002016129   0.003584229
##       Human-Vulcan   1 0.002016129   0.003584229
##    Human-Vuldarian   1 0.002016129   0.003584229
##    Human / Altered   2 0.004032258   0.007168459
##     Human / Cosmic   2 0.004032258   0.007168459
##  Human / Radiation   8 0.016129032   0.028673835
##      Icthyo Sapien   1 0.002016129   0.003584229
##            Inhuman   4 0.008064516   0.014336918
##    Kakarantharaian   1 0.002016129   0.003584229
##         Kryptonian   4 0.008064516   0.014336918
##            Martian   1 0.002016129   0.003584229
##          Metahuman   1 0.002016129   0.003584229
##             Mutant  46 0.092741935   0.164874552
##     Mutant / Clone   1 0.002016129   0.003584229
##             Planet   1 0.002016129   0.003584229
##             Saiyan   1 0.002016129   0.003584229
##           Symbiote   3 0.006048387   0.010752688
##           Talokite   1 0.002016129   0.003584229
##         Tamaranean   1 0.002016129   0.003584229
##            Ungaran   1 0.002016129   0.003584229
##            Vampire   2 0.004032258   0.007168459
##     Yoda's species   1 0.002016129   0.003584229
##      Zen-Whoberian   1 0.002016129   0.003584229
##               <NA> 217 0.437500000            NA
```

7. Among the good guys, Who are the Asgardians?

```r
good_guys %>%
  filter(race == "Asgardian")
```

```
## # A tibble: 3 x 10
##   name  gender eye_color race  hair_color height publisher skin_color alignment
##   <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Sif   Female blue      Asga~ Black         188 Marvel C~ <NA>       good     
## 2 Thor  Male   blue      Asga~ Blond         198 Marvel C~ <NA>       good     
## 3 Thor~ Female blue      Asga~ Blond         175 Marvel C~ <NA>       good     
## # ... with 1 more variable: weight <dbl>
```

8. Among the bad guys, who are the male humans over 200 inches in height?

```r
bad_guys %>%
  filter(height > 200) %>%
  arrange(height)
```

```
## # A tibble: 25 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Doct~ Male   brown     Human Brown         201 Marvel C~ <NA>       bad      
##  2 Doct~ Male   brown     <NA>  Brown         201 Marvel C~ <NA>       bad      
##  3 King~ Male   blue      Human No Hair       201 Marvel C~ <NA>       bad      
##  4 Than~ Male   red       Eter~ No Hair       201 Marvel C~ purple     bad      
##  5 Abom~ Male   green     Huma~ No Hair       203 Marvel C~ <NA>       bad      
##  6 Bane  Male   <NA>      Human <NA>          203 DC Comics <NA>       bad      
##  7 Liza~ Male   red       Human No Hair       203 Marvel C~ <NA>       bad      
##  8 Ultr~ Male   red       Andr~ <NA>          206 Marvel C~ silver     bad      
##  9 Fren~ Female brown     <NA>  Black         211 Marvel C~ <NA>       bad      
## 10 Omeg~ Male   red       <NA>  Blond         211 Marvel C~ <NA>       bad      
## # ... with 15 more rows, and 1 more variable: weight <dbl>
```

9. OK, so are there more good guys or bad guys that are bald (personal interest)?

```r
tabyl(good_guys, hair_color)
```

```
##        hair_color   n     percent valid_percent
##            Auburn  10 0.020161290   0.026178010
##             black   3 0.006048387   0.007853403
##             Black 108 0.217741935   0.282722513
##             blond   2 0.004032258   0.005235602
##             Blond  85 0.171370968   0.222513089
##              Blue   1 0.002016129   0.002617801
##             Brown  55 0.110887097   0.143979058
##     Brown / Black   1 0.002016129   0.002617801
##     Brown / White   4 0.008064516   0.010471204
##             Green   7 0.014112903   0.018324607
##              Grey   2 0.004032258   0.005235602
##            Indigo   1 0.002016129   0.002617801
##           Magenta   1 0.002016129   0.002617801
##           No Hair  37 0.074596774   0.096858639
##            Orange   2 0.004032258   0.005235602
##    Orange / White   1 0.002016129   0.002617801
##              Pink   1 0.002016129   0.002617801
##            Purple   1 0.002016129   0.002617801
##               Red  40 0.080645161   0.104712042
##       Red / White   1 0.002016129   0.002617801
##            Silver   3 0.006048387   0.007853403
##  Strawberry Blond   4 0.008064516   0.010471204
##             White  10 0.020161290   0.026178010
##            Yellow   2 0.004032258   0.005235602
##              <NA> 114 0.229838710            NA
```

```r
tabyl(bad_guys, hair_color)
```

```
##        hair_color  n     percent valid_percent
##            Auburn  3 0.014492754   0.019480519
##             Black 42 0.202898551   0.272727273
##      Black / Blue  1 0.004830918   0.006493506
##             blond  1 0.004830918   0.006493506
##             Blond 11 0.053140097   0.071428571
##              Blue  1 0.004830918   0.006493506
##             Brown 27 0.130434783   0.175324675
##            Brownn  1 0.004830918   0.006493506
##              Gold  1 0.004830918   0.006493506
##             Green  1 0.004830918   0.006493506
##              Grey  3 0.014492754   0.019480519
##           No Hair 35 0.169082126   0.227272727
##            Purple  3 0.014492754   0.019480519
##               Red  9 0.043478261   0.058441558
##        Red / Grey  1 0.004830918   0.006493506
##      Red / Orange  1 0.004830918   0.006493506
##  Strawberry Blond  3 0.014492754   0.019480519
##             White 10 0.048309179   0.064935065
##              <NA> 53 0.256038647            NA
```


```r
corrected_superhero_info %>%
  tabyl(alignment, hair_color)
```

```
##  alignment Auburn black Black Black / Blue blond Blond Blue Brown Brown / Black
##        bad      3     0    42            1     1    11    1    27             0
##       good     10     3   108            0     2    85    1    55             1
##    neutral      0     0     8            0     0     1    1     4             0
##       <NA>      0     0     0            0     0     2    0     0             0
##  Brown / White Brownn Gold Green Grey Indigo Magenta No Hair Orange
##              0      1    1     1    3      0       0      35      0
##              4      0    0     7    2      1       1      37      2
##              0      0    0     0    0      0       0       3      0
##              0      0    0     0    0      0       0       0      0
##  Orange / White Pink Purple Red Red / Grey Red / Orange Red / White Silver
##               0    0      3   9          1            1           0      0
##               1    1      1  40          0            0           1      3
##               0    0      1   2          0            0           0      0
##               0    0      0   0          0            0           0      1
##  Strawberry Blond White Yellow NA_
##                 3    10      0  53
##                 4    10      2 114
##                 0     2      0   2
##                 0     1      0   3
```

10. Let's explore who the really "big" superheros are. In the `superhero_info` data, which have a height over 300 or weight over 450?

```r
corrected_superhero_info %>%
  filter(height > 300 | weight > 450)
```

```
## # A tibble: 14 x 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Bloo~ Female blue      Human Brown       218   Marvel C~ <NA>       bad      
##  2 Dark~ Male   red       New ~ No Hair     267   DC Comics grey       bad      
##  3 Fin ~ Male   red       Kaka~ No Hair     975   Marvel C~ green      good     
##  4 Gala~ Male   black     Cosm~ Black       876   Marvel C~ <NA>       neutral  
##  5 Giga~ Female green     <NA>  Red          62.5 DC Comics <NA>       bad      
##  6 Groot Male   yellow    Flor~ <NA>        701   Marvel C~ <NA>       good     
##  7 Hulk  Male   green     Huma~ Green       244   Marvel C~ green      good     
##  8 Jugg~ Male   blue      Human Red         287   Marvel C~ <NA>       neutral  
##  9 MODOK Male   white     Cybo~ Brownn      366   Marvel C~ <NA>       bad      
## 10 Onsl~ Male   red       Muta~ No Hair     305   Marvel C~ <NA>       bad      
## 11 Red ~ Male   yellow    Huma~ Black       213   Marvel C~ red        neutral  
## 12 Sasq~ Male   red       <NA>  Orange      305   Marvel C~ <NA>       good     
## 13 Wolf~ Female green     <NA>  Auburn      366   Marvel C~ <NA>       good     
## 14 Ymir  Male   white     Fros~ No Hair     305.  Marvel C~ white      good     
## # ... with 1 more variable: weight <dbl>
```

11. Just to be clear on the `|` operator,  have a look at the superheros over 300 in height...

```r
corrected_superhero_info %>%
  filter(height > 300)
```

```
## # A tibble: 8 x 10
##   name  gender eye_color race  hair_color height publisher skin_color alignment
##   <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Fin ~ Male   red       Kaka~ No Hair      975  Marvel C~ green      good     
## 2 Gala~ Male   black     Cosm~ Black        876  Marvel C~ <NA>       neutral  
## 3 Groot Male   yellow    Flor~ <NA>         701  Marvel C~ <NA>       good     
## 4 MODOK Male   white     Cybo~ Brownn       366  Marvel C~ <NA>       bad      
## 5 Onsl~ Male   red       Muta~ No Hair      305  Marvel C~ <NA>       bad      
## 6 Sasq~ Male   red       <NA>  Orange       305  Marvel C~ <NA>       good     
## 7 Wolf~ Female green     <NA>  Auburn       366  Marvel C~ <NA>       good     
## 8 Ymir  Male   white     Fros~ No Hair      305. Marvel C~ white      good     
## # ... with 1 more variable: weight <dbl>
```

12. ...and the superheros over 450 in weight. Bonus question! Why do we not have 16 rows in question #10?

We don't have 16 rows in question #10 because the '|' operator selects for and/or both conditions are true. There appear to be superheroes that meet both conditions, so they appear in our answers to #11 and #12. However, they can only appear once in #10, even though they meet the condition more than once. 

```r
corrected_superhero_info %>%
  filter(weight > 450)
```

```
## # A tibble: 8 x 10
##   name  gender eye_color race  hair_color height publisher skin_color alignment
##   <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Bloo~ Female blue      Human Brown       218   Marvel C~ <NA>       bad      
## 2 Dark~ Male   red       New ~ No Hair     267   DC Comics grey       bad      
## 3 Giga~ Female green     <NA>  Red          62.5 DC Comics <NA>       bad      
## 4 Hulk  Male   green     Huma~ Green       244   Marvel C~ green      good     
## 5 Jugg~ Male   blue      Human Red         287   Marvel C~ <NA>       neutral  
## 6 Red ~ Male   yellow    Huma~ Black       213   Marvel C~ red        neutral  
## 7 Sasq~ Male   red       <NA>  Orange      305   Marvel C~ <NA>       good     
## 8 Wolf~ Female green     <NA>  Auburn      366   Marvel C~ <NA>       good     
## # ... with 1 more variable: weight <dbl>
```

## Height to Weight Ratio
13. It's easy to be strong when you are heavy and tall, but who is heavy and short? Which superheros have the lowest height to weight ratio?

```r
corrected_superhero_info %>%
  mutate(hw_ratio = height/weight) %>%
  arrange(hw_ratio)
```

```
## # A tibble: 734 x 11
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Giga~ Female green     <NA>  Red          62.5 DC Comics <NA>       bad      
##  2 Utga~ Male   blue      Fros~ White        15.2 Marvel C~ <NA>       bad      
##  3 Dark~ Male   red       New ~ No Hair     267   DC Comics grey       bad      
##  4 Jugg~ Male   blue      Human Red         287   Marvel C~ <NA>       neutral  
##  5 Red ~ Male   yellow    Huma~ Black       213   Marvel C~ red        neutral  
##  6 Sasq~ Male   red       <NA>  Orange      305   Marvel C~ <NA>       good     
##  7 Hulk  Male   green     Huma~ Green       244   Marvel C~ green      good     
##  8 Bloo~ Female blue      Human Brown       218   Marvel C~ <NA>       bad      
##  9 Than~ Male   red       Eter~ No Hair     201   Marvel C~ purple     bad      
## 10 A-Bo~ Male   yellow    Human No Hair     203   Marvel C~ <NA>       good     
## # ... with 724 more rows, and 2 more variables: weight <dbl>, hw_ratio <dbl>
```

## `superhero_powers`
Have a quick look at the `superhero_powers` data frame.  

```r
str(superhero_powers)
```

```
## tibble [667 x 168] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ hero_names                  : chr [1:667] "3-D Man" "A-Bomb" "Abe Sapien" "Abin Sur" ...
##  $ agility                     : logi [1:667] TRUE FALSE TRUE FALSE FALSE FALSE ...
##  $ accelerated_healing         : logi [1:667] FALSE TRUE TRUE FALSE TRUE FALSE ...
##  $ lantern_power_ring          : logi [1:667] FALSE FALSE FALSE TRUE FALSE FALSE ...
##  $ dimensional_awareness       : logi [1:667] FALSE FALSE FALSE FALSE FALSE TRUE ...
##  $ cold_resistance             : logi [1:667] FALSE FALSE TRUE FALSE FALSE FALSE ...
##  $ durability                  : logi [1:667] FALSE TRUE TRUE FALSE FALSE FALSE ...
##  $ stealth                     : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ energy_absorption           : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ flight                      : logi [1:667] FALSE FALSE FALSE FALSE FALSE TRUE ...
##  $ danger_sense                : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ underwater_breathing        : logi [1:667] FALSE FALSE TRUE FALSE FALSE FALSE ...
##  $ marksmanship                : logi [1:667] FALSE FALSE TRUE FALSE FALSE FALSE ...
##  $ weapons_master              : logi [1:667] FALSE FALSE TRUE FALSE FALSE FALSE ...
##  $ power_augmentation          : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ animal_attributes           : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ longevity                   : logi [1:667] FALSE TRUE TRUE FALSE FALSE FALSE ...
##  $ intelligence                : logi [1:667] FALSE FALSE TRUE FALSE TRUE TRUE ...
##  $ super_strength              : logi [1:667] TRUE TRUE TRUE FALSE TRUE TRUE ...
##  $ cryokinesis                 : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ telepathy                   : logi [1:667] FALSE FALSE TRUE FALSE FALSE FALSE ...
##  $ energy_armor                : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ energy_blasts               : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ duplication                 : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ size_changing               : logi [1:667] FALSE FALSE FALSE FALSE FALSE TRUE ...
##  $ density_control             : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ stamina                     : logi [1:667] TRUE TRUE TRUE FALSE TRUE FALSE ...
##  $ astral_travel               : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ audio_control               : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ dexterity                   : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ omnitrix                    : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ super_speed                 : logi [1:667] TRUE FALSE FALSE FALSE TRUE TRUE ...
##  $ possession                  : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ animal_oriented_powers      : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ weapon_based_powers         : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ electrokinesis              : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ darkforce_manipulation      : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ death_touch                 : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ teleportation               : logi [1:667] FALSE FALSE FALSE FALSE FALSE TRUE ...
##  $ enhanced_senses             : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ telekinesis                 : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ energy_beams                : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ magic                       : logi [1:667] FALSE FALSE FALSE FALSE FALSE TRUE ...
##  $ hyperkinesis                : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ jump                        : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ clairvoyance                : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ dimensional_travel          : logi [1:667] FALSE FALSE FALSE FALSE FALSE TRUE ...
##  $ power_sense                 : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ shapeshifting               : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ peak_human_condition        : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ immortality                 : logi [1:667] FALSE FALSE TRUE FALSE FALSE TRUE ...
##  $ camouflage                  : logi [1:667] FALSE TRUE FALSE FALSE FALSE FALSE ...
##  $ element_control             : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ phasing                     : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ astral_projection           : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ electrical_transport        : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ fire_control                : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ projection                  : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ summoning                   : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ enhanced_memory             : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ reflexes                    : logi [1:667] FALSE FALSE TRUE FALSE FALSE FALSE ...
##  $ invulnerability             : logi [1:667] FALSE FALSE FALSE FALSE TRUE TRUE ...
##  $ energy_constructs           : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ force_fields                : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ self_sustenance             : logi [1:667] FALSE TRUE FALSE FALSE FALSE FALSE ...
##  $ anti_gravity                : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ empathy                     : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ power_nullifier             : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ radiation_control           : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ psionic_powers              : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ elasticity                  : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ substance_secretion         : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ elemental_transmogrification: logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ technopath_cyberpath        : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ photographic_reflexes       : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ seismic_power               : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ animation                   : logi [1:667] FALSE FALSE FALSE FALSE TRUE FALSE ...
##  $ precognition                : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ mind_control                : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ fire_resistance             : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ power_absorption            : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ enhanced_hearing            : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ nova_force                  : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ insanity                    : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ hypnokinesis                : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ animal_control              : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ natural_armor               : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ intangibility               : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ enhanced_sight              : logi [1:667] FALSE FALSE TRUE FALSE FALSE FALSE ...
##  $ molecular_manipulation      : logi [1:667] FALSE FALSE FALSE FALSE FALSE TRUE ...
##  $ heat_generation             : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ adaptation                  : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ gliding                     : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ power_suit                  : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ mind_blast                  : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ probability_manipulation    : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ gravity_control             : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ regeneration                : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##  $ light_control               : logi [1:667] FALSE FALSE FALSE FALSE FALSE FALSE ...
##   [list output truncated]
##  - attr(*, "spec")=
##   .. cols(
##   ..   hero_names = col_character(),
##   ..   Agility = col_logical(),
##   ..   `Accelerated Healing` = col_logical(),
##   ..   `Lantern Power Ring` = col_logical(),
##   ..   `Dimensional Awareness` = col_logical(),
##   ..   `Cold Resistance` = col_logical(),
##   ..   Durability = col_logical(),
##   ..   Stealth = col_logical(),
##   ..   `Energy Absorption` = col_logical(),
##   ..   Flight = col_logical(),
##   ..   `Danger Sense` = col_logical(),
##   ..   `Underwater breathing` = col_logical(),
##   ..   Marksmanship = col_logical(),
##   ..   `Weapons Master` = col_logical(),
##   ..   `Power Augmentation` = col_logical(),
##   ..   `Animal Attributes` = col_logical(),
##   ..   Longevity = col_logical(),
##   ..   Intelligence = col_logical(),
##   ..   `Super Strength` = col_logical(),
##   ..   Cryokinesis = col_logical(),
##   ..   Telepathy = col_logical(),
##   ..   `Energy Armor` = col_logical(),
##   ..   `Energy Blasts` = col_logical(),
##   ..   Duplication = col_logical(),
##   ..   `Size Changing` = col_logical(),
##   ..   `Density Control` = col_logical(),
##   ..   Stamina = col_logical(),
##   ..   `Astral Travel` = col_logical(),
##   ..   `Audio Control` = col_logical(),
##   ..   Dexterity = col_logical(),
##   ..   Omnitrix = col_logical(),
##   ..   `Super Speed` = col_logical(),
##   ..   Possession = col_logical(),
##   ..   `Animal Oriented Powers` = col_logical(),
##   ..   `Weapon-based Powers` = col_logical(),
##   ..   Electrokinesis = col_logical(),
##   ..   `Darkforce Manipulation` = col_logical(),
##   ..   `Death Touch` = col_logical(),
##   ..   Teleportation = col_logical(),
##   ..   `Enhanced Senses` = col_logical(),
##   ..   Telekinesis = col_logical(),
##   ..   `Energy Beams` = col_logical(),
##   ..   Magic = col_logical(),
##   ..   Hyperkinesis = col_logical(),
##   ..   Jump = col_logical(),
##   ..   Clairvoyance = col_logical(),
##   ..   `Dimensional Travel` = col_logical(),
##   ..   `Power Sense` = col_logical(),
##   ..   Shapeshifting = col_logical(),
##   ..   `Peak Human Condition` = col_logical(),
##   ..   Immortality = col_logical(),
##   ..   Camouflage = col_logical(),
##   ..   `Element Control` = col_logical(),
##   ..   Phasing = col_logical(),
##   ..   `Astral Projection` = col_logical(),
##   ..   `Electrical Transport` = col_logical(),
##   ..   `Fire Control` = col_logical(),
##   ..   Projection = col_logical(),
##   ..   Summoning = col_logical(),
##   ..   `Enhanced Memory` = col_logical(),
##   ..   Reflexes = col_logical(),
##   ..   Invulnerability = col_logical(),
##   ..   `Energy Constructs` = col_logical(),
##   ..   `Force Fields` = col_logical(),
##   ..   `Self-Sustenance` = col_logical(),
##   ..   `Anti-Gravity` = col_logical(),
##   ..   Empathy = col_logical(),
##   ..   `Power Nullifier` = col_logical(),
##   ..   `Radiation Control` = col_logical(),
##   ..   `Psionic Powers` = col_logical(),
##   ..   Elasticity = col_logical(),
##   ..   `Substance Secretion` = col_logical(),
##   ..   `Elemental Transmogrification` = col_logical(),
##   ..   `Technopath/Cyberpath` = col_logical(),
##   ..   `Photographic Reflexes` = col_logical(),
##   ..   `Seismic Power` = col_logical(),
##   ..   Animation = col_logical(),
##   ..   Precognition = col_logical(),
##   ..   `Mind Control` = col_logical(),
##   ..   `Fire Resistance` = col_logical(),
##   ..   `Power Absorption` = col_logical(),
##   ..   `Enhanced Hearing` = col_logical(),
##   ..   `Nova Force` = col_logical(),
##   ..   Insanity = col_logical(),
##   ..   Hypnokinesis = col_logical(),
##   ..   `Animal Control` = col_logical(),
##   ..   `Natural Armor` = col_logical(),
##   ..   Intangibility = col_logical(),
##   ..   `Enhanced Sight` = col_logical(),
##   ..   `Molecular Manipulation` = col_logical(),
##   ..   `Heat Generation` = col_logical(),
##   ..   Adaptation = col_logical(),
##   ..   Gliding = col_logical(),
##   ..   `Power Suit` = col_logical(),
##   ..   `Mind Blast` = col_logical(),
##   ..   `Probability Manipulation` = col_logical(),
##   ..   `Gravity Control` = col_logical(),
##   ..   Regeneration = col_logical(),
##   ..   `Light Control` = col_logical(),
##   ..   Echolocation = col_logical(),
##   ..   Levitation = col_logical(),
##   ..   `Toxin and Disease Control` = col_logical(),
##   ..   Banish = col_logical(),
##   ..   `Energy Manipulation` = col_logical(),
##   ..   `Heat Resistance` = col_logical(),
##   ..   `Natural Weapons` = col_logical(),
##   ..   `Time Travel` = col_logical(),
##   ..   `Enhanced Smell` = col_logical(),
##   ..   Illusions = col_logical(),
##   ..   Thirstokinesis = col_logical(),
##   ..   `Hair Manipulation` = col_logical(),
##   ..   Illumination = col_logical(),
##   ..   Omnipotent = col_logical(),
##   ..   Cloaking = col_logical(),
##   ..   `Changing Armor` = col_logical(),
##   ..   `Power Cosmic` = col_logical(),
##   ..   Biokinesis = col_logical(),
##   ..   `Water Control` = col_logical(),
##   ..   `Radiation Immunity` = col_logical(),
##   ..   `Vision - Telescopic` = col_logical(),
##   ..   `Toxin and Disease Resistance` = col_logical(),
##   ..   `Spatial Awareness` = col_logical(),
##   ..   `Energy Resistance` = col_logical(),
##   ..   `Telepathy Resistance` = col_logical(),
##   ..   `Molecular Combustion` = col_logical(),
##   ..   Omnilingualism = col_logical(),
##   ..   `Portal Creation` = col_logical(),
##   ..   Magnetism = col_logical(),
##   ..   `Mind Control Resistance` = col_logical(),
##   ..   `Plant Control` = col_logical(),
##   ..   Sonar = col_logical(),
##   ..   `Sonic Scream` = col_logical(),
##   ..   `Time Manipulation` = col_logical(),
##   ..   `Enhanced Touch` = col_logical(),
##   ..   `Magic Resistance` = col_logical(),
##   ..   Invisibility = col_logical(),
##   ..   `Sub-Mariner` = col_logical(),
##   ..   `Radiation Absorption` = col_logical(),
##   ..   `Intuitive aptitude` = col_logical(),
##   ..   `Vision - Microscopic` = col_logical(),
##   ..   Melting = col_logical(),
##   ..   `Wind Control` = col_logical(),
##   ..   `Super Breath` = col_logical(),
##   ..   Wallcrawling = col_logical(),
##   ..   `Vision - Night` = col_logical(),
##   ..   `Vision - Infrared` = col_logical(),
##   ..   `Grim Reaping` = col_logical(),
##   ..   `Matter Absorption` = col_logical(),
##   ..   `The Force` = col_logical(),
##   ..   Resurrection = col_logical(),
##   ..   Terrakinesis = col_logical(),
##   ..   `Vision - Heat` = col_logical(),
##   ..   Vitakinesis = col_logical(),
##   ..   `Radar Sense` = col_logical(),
##   ..   `Qwardian Power Ring` = col_logical(),
##   ..   `Weather Control` = col_logical(),
##   ..   `Vision - X-Ray` = col_logical(),
##   ..   `Vision - Thermal` = col_logical(),
##   ..   `Web Creation` = col_logical(),
##   ..   `Reality Warping` = col_logical(),
##   ..   `Odin Force` = col_logical(),
##   ..   `Symbiote Costume` = col_logical(),
##   ..   `Speed Force` = col_logical(),
##   ..   `Phoenix Force` = col_logical(),
##   ..   `Molecular Dissipation` = col_logical(),
##   ..   `Vision - Cryo` = col_logical(),
##   ..   Omnipresent = col_logical(),
##   ..   Omniscient = col_logical()
##   .. )
```

14. How many superheros have a combination of accelerated healing, durability, and super strength?

```r
superhero_powers %>%
  filter(accelerated_healing == TRUE & durability == TRUE & super_strength == TRUE) %>%
  nrow()
```

```
## [1] 97
```

## `kinesis`
15. We are only interested in the superheros that do some kind of "kinesis". How would we isolate them from the `superhero_powers` data?



```r
superhero_powers %>%
  select(hero_names, contains("kinesis")) %>% 
  filter_all(any_vars(.==TRUE))
```

```
## # A tibble: 112 x 10
##    hero_names cryokinesis electrokinesis telekinesis hyperkinesis hypnokinesis
##    <chr>      <lgl>       <lgl>          <lgl>       <lgl>        <lgl>       
##  1 Alan Scott FALSE       FALSE          FALSE       FALSE        TRUE        
##  2 Amazo      TRUE        FALSE          FALSE       FALSE        FALSE       
##  3 Apocalypse FALSE       FALSE          TRUE        FALSE        FALSE       
##  4 Aqualad    TRUE        FALSE          FALSE       FALSE        FALSE       
##  5 Beyonder   FALSE       FALSE          TRUE        FALSE        FALSE       
##  6 Bizarro    TRUE        FALSE          FALSE       FALSE        TRUE        
##  7 Black Abb~ FALSE       FALSE          TRUE        FALSE        FALSE       
##  8 Black Adam FALSE       FALSE          TRUE        FALSE        FALSE       
##  9 Black Lig~ FALSE       TRUE           FALSE       FALSE        FALSE       
## 10 Black Mam~ FALSE       FALSE          FALSE       FALSE        TRUE        
## # ... with 102 more rows, and 4 more variables: thirstokinesis <lgl>,
## #   biokinesis <lgl>, terrakinesis <lgl>, vitakinesis <lgl>
```

16. Pick your favorite superhero and let's see their powers!

```r
superhero_powers %>% 
  filter(hero_names == "Thor") %>% 
  select_if(all_vars(.==TRUE))
```

```
## Warning: The `.predicate` argument of `select_if()` can't contain quosures. as of dplyr 0.8.3.
## Please use a one-sided formula, a function, or a function name.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_warnings()` to see where this warning was generated.
```

```
## # A tibble: 1 x 18
##   agility accelerated_hea~ durability flight longevity super_strength stamina
##   <lgl>   <lgl>            <lgl>      <lgl>  <lgl>     <lgl>          <lgl>  
## 1 TRUE    TRUE             TRUE       TRUE   TRUE      TRUE           TRUE   
## # ... with 11 more variables: super_speed <lgl>, weapon_based_powers <lgl>,
## #   teleportation <lgl>, enhanced_senses <lgl>, magic <lgl>,
## #   element_control <lgl>, reflexes <lgl>, invulnerability <lgl>,
## #   toxin_and_disease_resistance <lgl>, weather_control <lgl>, odin_force <lgl>
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  
