library(readxl)
library(tidyverse)

#### Prep sediment metadata ####

experimentTypeID_vector <- c("2. Situkuyok", "1. TKL873", "3. WCBP1P2")
names(experimentTypeID_vector) <- c("PCaMM_situkuyok", "PCaMM_TKL873", "PCaMM_WCBP1P2")
incubation_metadata <- read_xlsx("../metadata/PCaMM_incubations_metadata.xlsx",
                                 sheet = "incubationInfo",
                                 skip = 1) %>%
  mutate(start_point = lubridate::ymd_hm(paste(startDate, startTime)),
         experimentTypeID = experimentTypeID_vector[experimentTypeID]) %>%
  select(incubationID, experimentTypeID, treatment, start_point)

# Sediments
sediment_container_info <- read_xlsx("../metadata/PCaMM_incubations_metadata.xlsx",
                                     sheet = "containerInfo_sed_Hg",
                                     skip = 1) %>%
  mutate(end_point = lubridate::ymd_hm(paste(myd(dateKilled), timeKilled)))

sediment_metadata <- right_join(sediment_container_info,
                                incubation_metadata) %>%
  select(containerID, incubationID, experimentTypeID, depth_cm, verticalLocation, sideOfIncubation, treatment, start_point, end_point)



#### Prep porewater metadata ####
PW_container_info <- read_xlsx("../metadata/PCaMM_incubations_metadata.xlsx",
                               sheet = "containerInfo_PW") %>%
  mutate(end_point = lubridate::ymd_hm(paste(mdy(dateKilled), timeKilled)))
PW_metadata <- right_join(PW_container_info,
                          incubation_metadata) %>%
  select(containerID, incubationID, experimentTypeID, treatment, start_point, end_point)



#### Prep BONCAT metadata ####
# BONCAT_container_info <- read_xlsx("metadata/PCaMM_incubations_metadata.xlsx",
#                                sheet = "containerInfo_BONCAT",
#                                skip = 1) %>%
#   mutate(end_point = lubridate::ymd_hm(paste(mdy(dateKilled), timeKilled)))



