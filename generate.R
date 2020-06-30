## proj.dir <- "~/RTM"
proj.dir <- "/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc/model_runs/20200629/base_varnewserology6day_matrices_20200626_deaths"

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
	date.data <- format(lubridate::today() - lubridate::days(1), "%Y%m%d")
	regions <- c("East_of_England", "London", "Midlands",
									  "North_East_and_Yorkshire", "North_West",
									  "South_East", "South_West")
	nr <- length(regions)
}
load(file.path(proj.dir, "tmp.RData"))
file.loc <- "/project/pandemic_flu/Wuhan_Coronavirus/public-RTM-reports/"

wd <- getwd()
setwd(file.loc)
index_file <- "iframe.html"
output_file <- paste0(date.data, ".html")
rmarkdown::render(file.path(proj.dir, 'R/output/report-updated.Rmd'), output_dir = file.loc,
				  clean = FALSE, intermediates_dir = file.loc,
				  output_options = list(
	mathjax = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML"
					),
				  output_file = output_file)


system(paste("rm", index_file))
system(paste("ln -s", output_file, index_file))
setwd(wd)
