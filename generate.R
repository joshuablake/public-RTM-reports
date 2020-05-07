## Location of this script
thisFile <- function() {
        cmdArgs <- commandArgs(trailingOnly = FALSE)
        needle <- "--file="
        match <- grep(needle, cmdArgs)
        if (length(match) > 0) {
                # Rscript
                return(normalizePath(sub(needle, "", cmdArgs[match])))
        } else {
                # 'source'd via R console
                return(normalizePath(sys.frames()[[1]]$ofile))
        }
}

## Where are various directories?
file.loc <- dirname(thisFile())
proj.dir <- "~/RTM"

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
	date.data <- (today() - days(1)) %>% format("%Y%m%d"
	regions <- c("East_of_England", "London", "Midlands",
									  "North_East_and_Yorkshire", "North_West",
									  "South_East", "South_West")
	nr <- length(regions)
}
source(file.path(proj.dir, "config.R"))
source(file.path(proj.dir, "R/data/utils.R"))

Rfile.loc <- file.path(proj.dir, "R/output")

rmarkdown::render(file.path(Rfile.loc, 'report-updated.Rmd'), output_dir = file.loc,
				  clean = FALSE, intermediates_dir = file.loc)
