# ShinyApp

# run app
devtools::install_github("BirgitKarlhuber/Lab5", force=TRUE)
shiny::runGitHub("BirgitKarlhuber/ShinyApp", subdir="R/ShinyApp.R")

# maybe necessary
install.packages("shiny")
install.packages("shinythemes")
install.packages("dplyr")
install.packages("ggplot2")
