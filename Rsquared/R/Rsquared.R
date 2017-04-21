#' Rsquared Function
#'
#' The Rsquared function calculates the mean of replicate absorbances, graphs time versus the absorbance mean in log scale, and returns to users the slope of the graph, the R-squared value, and other coefficient values.
#' @param x x = time, which can be any unit, but must be numeric
#' @param y y = absorbance values in a dataset; must be numeric
#' @param xname xname allows users to change the x-axis label; can be character and/or numeric
#' @param yname yname allows users to change the y-axis label; can be character and/or numeric
#' @param title title allows users to change the graph title; can be character and/or numeric
#' @return graph of time versus absorbance means on a log scale and the slope of the graph, the R-squared value, and other coefficient values.
#' @keywords absorbance
#' @export

Rsquared <- function(x, y, xname, yname, title) { #creates a function assigned as Rsquared
  Absorbance <- rowMeans(y) #calculates the mean of all the columns of each row of the dataset
  ifelse(Absorbance <= 0 , print("At least one absorbance value <= 0 is in data frame. These values must be excluded for log()."), FALSE) #if absorbance value is less than or equal to 0, R will print a "warning." If values greater than 0 exist, no warnings will be printed.
  log10 <- log(Absorbance) #calculates the log of the absorbance values
  num <- as.numeric(log10) #converts log10 values from data frame to numeric
  a <- ggplot() +
    geom_point(aes(x, num)) + #plots a scatter plot with x vs. num
    geom_line(aes(x, num)) + #plots a line plot with x vs. num
    xlab(deparse(substitute(xname))) + #lets users change x label to 'xname'
    ylab(deparse(substitute(yname))) + #lets users change y label to 'yname'
    ggtitle(deparse(substitute(title))) + #lets users change graph title to 'title'
    theme(plot.title = element_text(hjust = 0.5)) #centers graph title
  print(a) #prints graph
  b <- stats::lm(num ~ x) #provides users with slope of graph and R-squared value
  if(summary(b)$r.squared < 0.9) #if the multiple R-squared value is less than 0.90, the user will receive the warning below.
    warning("R squared is <0.9. May need to reevaluate time frame chosen for log phase. Non-log phase values should be excluded.")
  summary(b) #"prints" slope and R-squared values
}
