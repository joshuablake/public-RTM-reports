library(lubridate)
library(plotly)

out.dir <- "/scratch/joshuab/rtm_for_pub/20211209"
out.dirx <- out.dir
out.dir.orig <- out.dir

load(file.path(out.dir, "tmp.RData"))
proj.dir.new <- "~/COVID/real-time-mcmc" ## ~/COVID/real-time-mcmc"
plot.dir <- "~/COVID/BSU_website_plots"
out.dir <- out.dirx
rm(proj.dir)
file.depth <- 5
source(file.path(proj.dir.new, "R/output/results_api.R"))
source(file.path(proj.dir.new, "R/output/plot_funcs.R"))

orca.fn <- orca
external <- TRUE
dth.dat <- filter(dth.dat, date <= ymd(date.data) - reporting.delay)
run.plots <- function() {
  infections %>% make.plots(ylab = "Number of infections") %>%
  orca.fn(paste0(date.data, "_infections.png"))

  noisy_deaths %>% make.plots(data = dth.dat, ylab = "Number of deaths") %>%
  orca.fn(paste0(date.data, "_deaths.png"))
}
# Use withr::with_dir as a workaround becase Orca doesn't support paths to files
# See: https://github.com/ropensci/plotly/issues/1310#issuecomment-428203982
## infections <- R.utils::extract(infections, 
withr::with_dir(plot.dir, run.plots())

