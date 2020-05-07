file.loc <- "."
proj.dir <- "~/RTM"

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
	date.data <- format(lubridate::today() - lubridate::days(1), "%Y%m%d")
	regions <- c("East_of_England", "London", "Midlands",
									  "North_East_and_Yorkshire", "North_West",
									  "South_East", "South_West")
	nr <- length(regions)
}
source(file.path(proj.dir, "config.R"))

Rfile.loc <- file.path(proj.dir, "R/output")

rmarkdown::render(file.path(Rfile.loc, 'report-updated.Rmd'), output_dir = file.loc,
				  clean = FALSE, intermediates_dir = file.loc,
				  output_options = list(
	mathjax = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML"
					),
				  output_file = paste0(date.data, ".html"))
