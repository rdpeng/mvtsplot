\name{mvtsplot}
\alias{mvtsplot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{A function for plotting multivariate time series data}
\description{
  A function for plotting multivariate time series data
}
\usage{
mvtsplot(x, group = NULL, xtime = NULL, norm = c("internal", "global"),
         levels = 3, smooth.df = NULL, margin = TRUE, sort = NULL,
         main = "", palette = "PRGn", rowstat = "median", xlim,
         bottom.ylim = NULL, right.xlim = NULL, gcol = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a matrix of N rows and P columns, where P is the number of
    time series and N is the number of observations per series}
  \item{group}{a length N vector indicating group membership of each row
  of the matrix (optional)}
  \item{xtime}{a length N vector containing the time index (optional)}
  \item{norm}{normalization technique (see Details)}
  \item{levels}{number of levels for mapping categories into colors}
  \item{smooth.df}{the number of degrees of freedom to be used for the
    spline smoother}
  \item{margin}{should the margin plots be shown (default = TRUE)}
  \item{sort}{a function computing a numerical statistic that can be
    used for ordering the rows (default is no sorting)}
  \item{main}{title for the plot}
  \item{palette}{name of the Color Brewer palette to be used}
  \item{rowstat}{a function computing a numerical statistic on the rows
    for displaying on the margin (default is \code{median})}
  \item{xlim}{limits for the x-axis}
  \item{bottom.ylim}{y-axis limits for the bottom margin}
  \item{right.xlim}{x-axis limits for the right margin}
  \item{gcol}{color for lines separating groups}
}
\details{
  For the normalization, specifying "internal" means that each time
  series is categorized into colors based on the range of values in each
  time series individually. Therefore, under this scenario, the same
  color in two different time series will have two different
  meanings. If "global" is specified, then each time series will be
  categorized based on the range of values for the entire collection of
  time series. In this case, the colors are comparable across series.
}
\references{
  Peng RD (2008). "A method for visualizing multivariate time
  series data," Journal of Statistical Software, 25 (Code Snippet),
  1--17.
}
\author{Roger D. Peng \email{rpeng@jhsph.edu}}

\examples{
x <- matrix(rnorm(2000), 100, 20)
mvtsplot(x)
}


% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{graphics}
