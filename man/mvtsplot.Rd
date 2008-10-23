\name{mvtsplot}
\alias{mvtsplot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ ~~function to do ... ~~ }
\description{
  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
mvtsplot(x, group = NULL, xtime = NULL, norm = c("internal", "global"), levels = 3, smooth.df = NULL, margin = TRUE, sort = NULL, main = "", palette = "PRGn", rowstat = "median", xlim, bottom.ylim = NULL, right.xlim = NULL, gcol = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ ~~Describe \code{x} here~~ }
  \item{group}{ ~~Describe \code{group} here~~ }
  \item{xtime}{ ~~Describe \code{xtime} here~~ }
  \item{norm}{ ~~Describe \code{norm} here~~ }
  \item{levels}{ ~~Describe \code{levels} here~~ }
  \item{smooth.df}{ ~~Describe \code{smooth.df} here~~ }
  \item{margin}{ ~~Describe \code{margin} here~~ }
  \item{sort}{ ~~Describe \code{sort} here~~ }
  \item{main}{ ~~Describe \code{main} here~~ }
  \item{palette}{ ~~Describe \code{palette} here~~ }
  \item{rowstat}{ ~~Describe \code{rowstat} here~~ }
  \item{xlim}{ ~~Describe \code{xlim} here~~ }
  \item{bottom.ylim}{ ~~Describe \code{bottom.ylim} here~~ }
  \item{right.xlim}{ ~~Describe \code{right.xlim} here~~ }
  \item{gcol}{ ~~Describe \code{gcol} here~~ }
}
\details{
  ~~ If necessary, more details than the description above ~~
}
\value{
  ~Describe the value returned
  If it is a LIST, use
  \item{comp1 }{Description of 'comp1'}
  \item{comp2 }{Description of 'comp2'}
  ...
}
\references{ ~put references to the literature/web site here ~ }
\author{ ~~who you are~~ }
\note{ ~~further notes~~ 

 ~Make other sections like Warning with \section{Warning }{....} ~
}
\seealso{ ~~objects to See Also as \code{\link{help}}, ~~~ }
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(x, group = NULL, xtime = NULL,
                     norm = c("internal", "global"), levels = 3,
                     smooth.df = NULL, margin = TRUE,
                     sort = NULL,
                     main = "", palette = "PRGn",
                     rowstat = "median",
                     xlim, bottom.ylim = NULL,
                     right.xlim = NULL,
                     gcol = 1) {
        if(is.data.frame(x))
                x <- data.matrix(x)
        checkMatrix(x)
        norm <- match.arg(norm)

        if(!is.null(sort))
                sort <- match.fun(sort)
        rowstat <- match.fun(rowstat)

        if(!require(RColorBrewer))
                stop("'RColorBrewer' package required")
        if(is.null(xtime)) {
                xtime <- seq_len(nrow(x))
                xlim <- c(0, max(xtime))
        }
        else
                xlim <- range(xtime)
        if(!is.null(group)) {
                group <- as.factor(group)
                x <- reorderCols(x, group)
        }
        if(!margin && !is.null(sort)) {
                stat <- apply(x, 2, sort, na.rm = TRUE)
                x <- x[, order(stat)]
        }
        if(margin) {
                colm <- apply(x, 2, function(x) {
                        grDevices::boxplot.stats(x)$stats
                })
                if(!is.null(sort)) {
                        stat <- apply(x, 2, sort, na.rm = TRUE)
                        ord <- order(stat)
                        x <- x[, ord]
                        colm <- colm[, ord]
                }
        }
        if(is.null(smooth.df))
                cx <- catcols(x, levels, norm)
        else {
                x <- smoothX(x, smooth.df)
                cx <- catcols(x, levels, norm)
        }
        if(margin)
                rowm <- apply(x, 1, rowstat, na.rm = TRUE)
        colnames(cx) <- colnames(x)
        empty <- apply(cx, 2, function(x) all(is.na(x)))

        if(any(empty)) {  ## Remove empty columns
                cx <- cx[, !empty]

                if(margin)
                        colm <- colm[, !empty]
        }
        pal <- colorRampPalette(brewer.pal(4, palette))

        nlevels <- if(length(levels) == 1)
                levels
        else
                length(levels)
        if(margin)
                drawImageMargin(cx, pal, nlevels, xlim, cn, xtime,
                                group, gcol, smooth.df, rowm, nrow(x),
                                bottom.ylim, colm, right.xlim, main)
        else
                drawImage(cx, pal, nlevels, xlim, cn, xtime, group, gcol)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
