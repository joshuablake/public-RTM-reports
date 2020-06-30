## proj.dir <- "~/RTM"
out.dir <- "/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc/model_runs/20200626/base_varserology6day_matrices_20200619_deaths"

load(file.path(out.dir, "tmp.RData"))
file.loc <- "~/public-RTM-reports/"

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
