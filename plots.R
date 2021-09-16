library(lubridate)
library(plotly)

out.dir <- "/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc-dev/model_runs/20210910_backup/Prev494_cm6ons_ONS60cutoff_IFR5bp_18wk2_prev14-0PHE_matrices_20210910_timeuse_household_deaths_chain2"
out.dir <- "/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc-dev/model_runs/20210507/Prev368_cm4ons_IFR3bp_ONS60cutoff_25wk2_prev14-5Jamie_matrices_20210507_timeuse_household_deaths"
out.dir.orig <- out.dir
load(file.path(out.dir, "tmp.RData"))
proj.dir.new <- "/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc-dev" ## ~/COVID/real-time-mcmc"
plot.dir <- "/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc-dev/BSU_website_plots"
out.dir <- out.dir.orig

source(file.path(proj.dir, "R/output/results_api.R"))
source(file.path(proj.dir, "R/output/plot_funcs.R"))

orca.fn <- orca

external <- TRUE
dth.dat <- filter(dth.dat, date <= ymd(date.data) - reporting.delay)
run.plots <- function() {
  infections %>%
    make.plots(ylab = "Number of infections") %>%
    orca.fn(paste0(date.data, "_infections.png"))
  
  noisy_deaths %>%
    make.plots(data = dth.dat, ylab = "Number of deaths") %>%
    orca.fn(paste0(date.data, "_deaths.png"))
}
# Use withr::with_dir as a workaround becase Orca doesn't support paths to files
# See: https://github.com/ropensci/plotly/issues/1310#issuecomment-428203982
withr::with_dir(plot.dir, run.plots())

