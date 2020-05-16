library(plotly)
file.loc <- "~/public-RTM-reports/"
proj.dir <- "~/RTM"


args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
  date.data <- format((lubridate::today() - lubridate::days(1)), "%Y%m%d")
  regions <- c("East_of_England", "London", "Midlands",
               "North_East_and_Yorkshire", "North_West",
               "South_East", "South_West")
  nr <- length(regions)
}
source(file.path(proj.dir, "config.R"))
Rfile.loc <- file.path(proj.dir, "R/output")
source(file.path(Rfile.loc, "results_api.R"))
QUANTILES = c(0.025, 0.5, 0.975)

make.plots <- function(projections, ylab = "", data = NULL, y.format = ".3s") {
  Eng_projection <- sum.all(projections) %>% add.quantiles(NULL, QUANTILES)
  Eng_data <- sum.all.data(data)
  plot.height <- 420 + 150
  date <- ymd(date.data)
  lines <- list(
    list(
      type = "line", 
      y0 = 0, 
      y1 = 1, 
      yref = "paper",
      x0 = ymd(date.data), 
      x1 = ymd(date.data), 
      line = list(color = "red"),
      hoverinfo = "Today"
    ),
    list(
      type = "line", 
      y0 = 0, 
      y1 = 1, 
      yref = "paper",
      x0 = ymd(20200323), 
      x1 = ymd(20200323), 
      line = list(color = "blue"),
      hoverinfo = "Lockdown"
    )
  )
  plot <- Eng_projection %>%
    pivot_wider(names_from = quantile) %>%
    plot_ly(x = ~date, width = 800, height = plot.height) %>%
    add_ribbons(ymin = ~`0.025`, ymax = ~`0.975`, color = I("lightblue2"), alpha = 0.25) %>%
    add_lines(y = ~`0.5`, color = I("black")) %>%
    layout(shapes = lines, showlegend = FALSE, xaxis = list(title = "Date"),
           yaxis = list(title = ylab))
  if (is.null(data)) return(plot)
  plot %>%
    add_markers(
      data = Eng_data,
      x = ~date,
      y = ~True,
      color = I("red"),
    )
}

make.plots(infections, ylab = "Number of infections")
make.plots(noisy_deaths, data = dth.dat, ylab = "Number of deaths")
