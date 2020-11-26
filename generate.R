## proj.dir <- "~/RTM"
new.out.dir <- "/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc/model_runs/20201122/NoPrev_relax_shortsero_cm4_latestart_ifr_60cutoff_matrices_20201120_deaths"

new.file.loc <- "~/public-RTM-reports"
new.proj.dir <- "~/COVID/real-time-mcmc"
Rfile.loc <- file.path(new.proj.dir, "R/output")

wd <- getwd()
setwd(new.file.loc)
external <- TRUE
index_file <- "iframe.html"
output_file <- paste0(lubridate::today(), ".html")
out.dir <- new.out.dir
rmarkdown::render(file.path(new.proj.dir, 'R/output/report-updated.Rmd'), output_dir = new.file.loc,
				  intermediates_dir = new.file.loc,
				  output_options = list(
	mathjax = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML"
					),
				  output_file = output_file)

out.dir <- new.out.dir
Rfile.loc <- file.path(new.proj.dir, "R/output")
rmarkdown::render(file.path(new.proj.dir, 'R/output/report-updated.Rmd'), 
	rmarkdown::html_document(pandoc_args = "--self-contained"),
				  output_dir = new.file.loc,
				  intermediates_dir = new.file.loc,
				  output_options = list(
	mathjax = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML"
					),
				  output_file = "draft-pub.html")

system(paste("rm", index_file))
system(paste("ln -s", output_file, index_file))
setwd(wd)
