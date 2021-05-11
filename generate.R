## proj.dir <- "~/RTM"
new.out.dir <- "/project/pandemic_flu/Wuhan_Coronavirus/Josh/model_runs/20210125/PrevCevik_60cutoff_prev14_last_break_10_days_matrices_20210122_deaths"

new.file.loc <- "/project/pandemic_flu/Wuhan_Coronavirus/public-RTM-reports"
new.proj.dir <- "/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc"
Rfile.loc <- file.path(new.proj.dir, "R/output")

wd <- getwd()
setwd(new.file.loc)
external <- TRUE
index_file <- "iframe.html"
output_file <- paste0(lubridate::today(), ".html")
out.dir <- new.out.dir

# Remove warnings
options(dplyr.summarise.inform = FALSE)
knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE
)
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
