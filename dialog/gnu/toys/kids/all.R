#!/usr/bin/r

# Test if Two Objects are (Nearly) Equal
# Description
# all.equal(x, y) is a utility to compare R objects x and y testing ‘near equality’. If they are different, comparison is still made to some extent, and a report of the differences is returned. Do not use all.equal directly in if expressions—either use isTRUE(all.equal(....)) or identical if appropriate.

# Usage
# all.equal(target, current, ...)

# ## S3 method for class 'numeric'
# all.equal(target, current,
#           tolerance = sqrt(.Machine$double.eps), scale = NULL,
#           countEQ = FALSE,
#           formatFUN = function(err, what) format(err),
#           ..., check.attributes = TRUE)

# ## S3 method for class 'list'
# all.equal(target, current, ...,
#           check.attributes = TRUE, use.names = TRUE)

# ## S3 method for class 'environment'
# all.equal(target, current, all.names = TRUE,
#           evaluate = TRUE, ...)

# ## S3 method for class 'function'
# all.equal(target, current, check.environment=TRUE, ...)

# ## S3 method for class 'POSIXt'
# all.equal(target, current, ..., tolerance = 1e-3, scale,
#           check.tzone = TRUE)


# attr.all.equal(target, current, ...,
#                check.attributes = TRUE, check.names = TRUE)
# Arguments
# target	
# R object.

# current	
# other R object, to be compared with target.

# ...	
# further arguments for different methods, notably the following two, for numerical comparison:

# tolerance	
# numeric ≥ 0. Differences smaller than tolerance are not reported. The default value is close to 1.5e-8.

# scale	
# NULL or numeric > 0, typically of length 1 or length(target). See ‘Details’.

# countEQ	
# logical indicating if the target == current cases should be counted when computing the mean (absolute or relative) differences. The default, FALSE may seem misleading in cases where target and current only differ in a few places; see the extensive example.

# formatFUN	
# a function of two arguments, err, the relative, absolute or scaled error, and what, a character string indicating the kind of error; may be used, e.g., to format relative and absolute errors differently.

# check.attributes	
# logical indicating if the attributes of target and current (other than the names) should be compared.

# use.names	
# logical indicating if list comparison should report differing components by name (if matching) instead of integer index. Note that this comes after ... and so must be specified by its full name.

# all.names	
# logical passed to ls indicating if “hidden” objects should also be considered in the environments.

# evaluate	
# for the environment method: logical indicating if “promises should be forced”, i.e., typically formal function arguments be evaluated for comparison. If false, only the names of the objects in the two environments are checked for equality.

# check.environment	
# logical requiring that the environment()s of functions should be compared, too. You may need to set check.environment=FALSE in unexpected cases, such as when comparing two nls() fits.

# check.tzone	
# logical indicating if the "tzone" attributes of target and current should be compared.

# check.names	
# logical indicating if the names(.) of target and current should be compared.

# Details
# all.equal is a generic function, dispatching methods on the target argument. To see the available methods, use methods("all.equal"), but note that the default method also does some dispatching, e.g. using the raw method for logical targets.

# Remember that arguments which follow ... must be specified by (unabbreviated) name. It is inadvisable to pass unnamed arguments in ... as these will match different arguments in different methods.

# Numerical comparisons for scale = NULL (the default) are typically on relative difference scale unless the target values are close to zero: First, the mean absolute difference of the two numerical vectors is computed. If this is smaller than tolerance or not finite, absolute differences are used, otherwise relative differences scaled by the mean absolute target value. Note that these comparisons are computed only for those vector elements where target is not NA and differs from current. If countEQ is true, the equal and NA cases are counted in determining “sample” size.

# If scale is numeric (and positive), absolute comparisons are made after scaling (dividing) by scale.

# For complex target, the modulus (Mod) of the difference is used: all.equal.numeric is called so arguments tolerance and scale are available.

# The list method compares components of target and current recursively, passing all other arguments, as long as both are “list-like”, i.e., fulfill either is.vector or is.list.

# The environment method works via the list method, and is also used for reference classes (unless a specific all.equal method is defined).

# The method for date-time objects uses all.equal.numeric to compare times (in "POSIXct" representation) with a default tolerance of 0.001 seconds, ignoring scale. A time zone mismatch between target and current is reported unless check.tzone = FALSE.

# attr.all.equal is used for comparing attributes, returning NULL or a character vector.

# Value
# Either TRUE (NULL for attr.all.equal) or a vector of mode "character" describing the differences between target and current.

# References
# Chambers, J. M. (1998) Programming with Data. A Guide to the S Language. Springer (for =).

# See Also
# identical, isTRUE, ==, and all for exact equality testing.

# Examples

all.equal(pi, 355/113)
# not precise enough (default tol) > relative error

d45 <- pi*(1/4 + 1:10)
stopifnot(
all.equal(tan(d45), rep(1, 10)))          # TRUE, but
all      (tan(d45) == rep(1, 10))         # FALSE, since not exactly
all.equal(tan(d45), rep(1, 10), tolerance = 0)  # to see difference

## advanced: equality of environments
ae <- all.equal(as.environment("package:stats"),
                asNamespace("stats"))
stopifnot(is.character(ae), length(ae) > 10,
          ## were incorrectly "considered equal" in R <= 3.1.1
          all.equal(asNamespace("stats"), asNamespace("stats")))

## A situation where  'countEQ = TRUE' makes sense:
x1 <- x2 <- (1:100)/10;  x2[2] <- 1.1*x1[2]
## 99 out of 100 pairs (x1[i], x2[i]) are equal:
plot(x1,x2, main = "all.equal.numeric() -- not counting equal parts")
all.equal(x1,x2) ## "Mean relative difference: 0.1"
mtext(paste("all.equal(x1,x2) :", all.equal(x1,x2)), line= -2)
##' extract the 'Mean relative difference' as number:
all.eqNum <- function(...) as.numeric(sub(".*:", '', all.equal(...)))
set.seed(17)
## When x2 is jittered, typically all pairs (x1[i],x2[i]) do differ:
summary(r <- replicate(100, all.eqNum(x1, x2*(1+rnorm(x1)*1e-7))))
mtext(paste("mean(all.equal(x1, x2*(1 + eps_k))) {100 x} Mean rel.diff.=",
            signif(mean(r), 3)), line = -4, adj=0)
## With argument  countEQ=TRUE, get "the same" (w/o need for jittering):
mtext(paste("all.equal(x1,x2, countEQ=TRUE) :",
          signif(all.eqNum(x1,x2, countEQ=TRUE), 3)), line= -6, col=2)

## comparison of date-time objects
now <- Sys.time()
stopifnot(
all.equal(now, now + 1e-4)  # TRUE (default tolerance = 0.001 seconds)
)
all.equal(now, now + 0.2)
all.equal(now, as.POSIXlt(now, "UTC"))
stopifnot(
all.equal(now, as.POSIXlt(now, "UTC"), check.tzone = FALSE)  # TRUE
)