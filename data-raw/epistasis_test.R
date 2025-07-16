## code to prepare `DATASET` dataset goes here

library(tidyverse)

d4 <- read_csv("data-raw/day_4_areas.csv")

d17 <- read_csv("data-raw/day_17_areas.csv")

dups <- d17$six_pack[duplicated(d17$six_pack)]

d17 <- d17 %>%
  filter(!(six_pack %in% dups))

germ <- read_csv("data-raw/germ_and_id.csv")

height <- read_csv("data-raw/heights.csv")

dups <- height$plant[duplicated(height$plant)]

height <- height %>%
  filter(!(plant %in% dups)) %>%
  select(six_pack = plant, height) %>%
  mutate(height = as.numeric(height),
         six_pack = gsub("\\.", "_", six_pack)) %>%
  drop_na(height)


phenotypes <- germ %>%
  drop_na(six_pack) %>%
  filter(germ_day==3) %>%
  left_join(d4, by = join_by(tray_id)) %>%
  left_join(d17, by = join_by(six_pack)) %>%
  left_join(height, by = join_by(six_pack)) %>%
  select(germ_day, day_4, day_17, height, line) %>%
  drop_na(day_4) %>%
  mutate(rgr = (log(day_17) - log(day_4))/(17-4)) %>%
  #drop_na(rgr) %>%
  select(day_4, day_17, rgr, height, line)


usethis::use_data(phenotypes, overwrite = TRUE)
