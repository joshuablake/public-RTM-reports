## proj.dir <- "~/RTM"
out.dir <- "/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc/model_runs/20201009/NoPrev_shortsero_ifr_60cutoff6day_matrices_20201009_deaths"

file.loc <- "~/public-RTM-reports"
proj.dir <- "~/real-time-mcmc"
Rfile.loc <- file.path(proj.dir, "R/output")

wd <- getwd()
setwd(file.loc)
external <- TRUE
index_file <- "iframe.html"
output_file <- paste0(lubridate::today(), ".html")
rmarkdown::render(file.path(proj.dir, 'R/output/report-updated.Rmd'), output_dir = file.loc,
				  intermediates_dir = file.loc,
				  output_options = list(
	mathjax = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML"
					),
				  output_file = output_file)


system(paste("rm", index_file))
system(paste("ln -s", output_file, index_file))
setwd(wd)
