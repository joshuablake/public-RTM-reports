library(lubridate)
library(plotly)

out.dir <- "/rds/user/pjb51/hpc-work/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc-amgs/model_runs/20210507/Prev368_cm4ons_IFR3bp_ONS60cutoff_25wk2_prev14-5Jamie_matrices_20210507_timeuse_household_deaths"
out.dir.orig <- out.dir
load(file.path(out.dir, "tmp.RData"))
proj.dir.new <- "/rds/user/pjb51/hpc-work/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc-amgs"
plot.dir <- "./BSU_website_plots"
out.dir <- out.dir.orig

source(file.path(proj.dir.new, "R/output/results_api.R"))
source(file.path(proj.dir.new, "R/output/plot_funcs.R"))

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

