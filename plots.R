library(lubridate)
library(plotly)

out.dir <- "/scratch/joshuab/rtm_for_pub/20220815"
out.dirx <- out.dir
out.dir.orig <- out.dir

load(file.path(out.dir, "tmp.RData"))
proj.dir.new <- "/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc" ## ~/COVID/real-time-mcmc"
plot.dir <- "~/COVID/BSU_website_plots"
out.dir <- out.dirx
rm(proj.dir)
file.depth <- 5
source(file.path(proj.dir.new, "R/output/results_api.R"))
source(file.path(proj.dir.new, "R/output/plot_funcs.R"))

orca.fn <- orca
external <- TRUE
if (external && exists("dth.dat") && !is.null(dth.dat)) {
  dth.dat <- filter(dth.dat, date <= ymd(date.data) - reporting.delay)
  results_hash = NULL
} else if (exists("adm.sam") && !is.null(adm.sam)) {
  dth.dat <- adm.sam %>% rename(age = ages, value = admissions)
  if(external) dth.dat <- filter(dth.dat, date <= ymd(date.data) - reporting.delay)
  results_hash = NULL
}
run.plots <- function() {
  infections %>% make.plots(ylab = "Number of infections") %>%
  orca.fn(paste0(date.data, "_infections.png"))

  dth.file <- file.path(out.dir, "deaths_data.RData")
  if (is.null(dth.dat) && file.exists(dth.file)){
    load(dth.file)
  }
  if (!is.null(dth.dat) && !exists("adm.sam")){
    ## Below chunk is a temporary fix
    if("Region" %in% names(dth.dat)) dth.dat <- rename(dth.dat, region = Region)
    if("Age.Grp" %in% names(dth.dat)) dth.dat <- rename(dth.dat, age = Age.Grp)
    if("n" %in% names(dth.dat)) dth.dat <- rename(dth.dat, value = n)
    dth.dat <- dth.dat %>% filter(date <= start.date + end.hosp - 1)
    dth.dat$age <- recode(dth.dat$age, `>=75` = "75+", `0-44` = "<45")
  }
  if(exists("adm.sam")){
    dth.dat$age <- recode(dth.dat$age, "0-25" = "<25", "25-45" = "25-44", "45-65" = "45-64", "65-75" = "65-74")
    noisy_deaths %>% make.plots(data = dth.dat, ylab = "Number of hospitalisations") %>%
    orca.fn(paste0(date.data, "_hosp.png"))
  } else {
    noisy_deaths %>% make.plots(data = dth.dat, ylab = "Number of deaths") %>%
    orca.fn(paste0(date.data, "_deaths.png"))
  }
}
# Use withr::with_dir as a workaround becase Orca doesn't support paths to files
# See: https://github.com/ropensci/plotly/issues/1310#issuecomment-428203982
## infections <- R.utils::extract(infections,
withr::with_dir(plot.dir, run.plots())

