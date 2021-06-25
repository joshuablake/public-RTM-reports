## proj.dir <- "~/RTM"
new.out.dir <- "/rds/user/pjb51/hpc-work/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc/model_runs/20210619/Prev410_cm6ons_IFR4bp_ONS60cutoff_25wk2_prev14-0PHE_matrices_20210618_timeuse_household_deaths"

new.file.loc <- "/rds/user/pjb51/hpc-work/project/pandemic_flu/Wuhan_Coronavirus/public-RTM-reports"
new.proj.dir <- "/rds/user/pjb51/hpc-work/project/pandemic_flu/Wuhan_Coronavirus/real-time-mcmc"
Rfile.loc <- file.path(new.proj.dir, "R/output")

wd <- getwd()
setwd(new.file.loc)
external <- TRUE
index_file <- "iframe.html"
output_file <- paste0(lubridate::today(), ".html")
out.dir <- new.out.dir
load(file.path(out.dir, "tmp.RData"))
out.dir <- new.out.dir

# Remove warnings
options(dplyr.summarise.inform = FALSE)
knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE
)

setwd(new.file.loc)
rmarkdown::render(file.path(new.proj.dir, 'R/output/report-updated.Rmd'),
		rmarkdown::html_document(lib_dir = file.path(new.file.loc, "libs"), self_contained = FALSE),
				  output_dir = new.file.loc,
				  intermediates_dir = new.file.loc,
				  output_options = list(
	mathjax = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML",
					),
				  output_file = output_file)

out.dir <- new.out.dir
setwd(new.file.loc)
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
