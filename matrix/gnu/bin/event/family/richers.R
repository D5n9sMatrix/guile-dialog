#!/usr/bin/r

# Conditioning Plots
# Description
# This function produces two variants of the conditioning plots discussed in the reference below.

# Usage
# coplot(formula, data, given.values, panel = points, rows, columns,
#        show.given = TRUE, col = par("fg"), pch = par("pch"),
#        bar.bg = c(num = gray(0.8), fac = gray(0.95)),
#        xlab = c(x.name, paste("Given :", a.name)),
#        ylab = c(y.name, paste("Given :", b.name)),
#        subscripts = FALSE,
#        axlabels = function(f) abbreviate(levels(f)),
#        number = 6, overlap = 0.5, xlim, ylim, ...)
# co.intervals(x, number = 6, overlap = 0.5)
# Arguments
# formula	
# a formula describing the form of conditioning plot. A formula of the form y ~ x | a indicates that plots of y versus x should be produced conditional on the variable a. A formula of the form y ~ x| a * b indicates that plots of y versus x should be produced conditional on the two variables a and b.

# All three or four variables may be either numeric or factors. When x or y are factors, the result is almost as if as.numeric() was applied, whereas for factor a or b, the conditioning (and its graphics if show.given is true) are adapted.

# data	
# a data frame containing values for any variables in the formula. By default the environment where coplot was called from is used.

# given.values	
# a value or list of two values which determine how the conditioning on a and b is to take place.

# When there is no b (i.e., conditioning only on a), usually this is a matrix with two columns each row of which gives an interval, to be conditioned on, but is can also be a single vector of numbers or a set of factor levels (if the variable being conditioned on is a factor). In this case (no b), the result of co.intervals can be used directly as given.values argument.

# panel	
# a function(x, y, col, pch, ...) which gives the action to be carried out in each panel of the display. The default is points.

# rows	
# the panels of the plot are laid out in a rows by columns array. rows gives the number of rows in the array.

# columns	
# the number of columns in the panel layout array.

# show.given	
# logical (possibly of length 2 for 2 conditioning variables): should conditioning plots be shown for the corresponding conditioning variables (default TRUE).

# col	
# a vector of colors to be used to plot the points. If too short, the values are recycled.

# pch	
# a vector of plotting symbols or characters. If too short, the values are recycled.

# bar.bg	
# a named vector with components "num" and "fac" giving the background colors for the (shingle) bars, for numeric and factor conditioning variables respectively.

# xlab	
# character; labels to use for the x axis and the first conditioning variable. If only one label is given, it is used for the x axis and the default label is used for the conditioning variable.

# ylab	
# character; labels to use for the y axis and any second conditioning variable.

# subscripts	
# logical: if true the panel function is given an additional (third) argument subscripts giving the subscripts of the data passed to that panel.

# axlabels	
# function for creating axis (tick) labels when x or y are factors.

# number	
# integer; the number of conditioning intervals, for a and b, possibly of length 2. It is only used if the corresponding conditioning variable is not a factor.

# overlap	
# numeric < 1; the fraction of overlap of the conditioning variables, possibly of length 2 for x and y direction. When overlap < 0, there will be gaps between the data slices.

# xlim	
# the range for the x axis.

# ylim	
# the range for the y axis.

# ...	
# additional arguments to the panel function.

# x	
# a numeric vector.

# Details
# In the case of a single conditioning variable a, when both rows and columns are unspecified, a ‘close to square’ layout is chosen with columns >= rows.

# In the case of multiple rows, the order of the panel plots is from the bottom and from the left (corresponding to increasing a, typically).

# A panel function should not attempt to start a new plot, but just plot within a given coordinate system: thus plot and boxplot are not panel functions.

# The rendering of arguments xlab and ylab is not controlled by par arguments cex.lab and font.lab even though they are plotted by mtext rather than title.

# Value
# co.intervals(., number, .) returns a (number x 2) matrix, say ci, where ci[k,] is the range of x values for the k-th interval.

# References
# Chambers, J. M. (1992) Data for models. Chapter 3 of Statistical Models in S eds J. M. Chambers and T. J. Hastie, Wadsworth & Brooks/Cole.

# Cleveland, W. S. (1993) Visualizing Data. New Jersey: Summit Press.

# See Also
# pairs, panel.smooth, points.

# Examples

## Tonga Trench Earthquakes
food1 <- coplot(lat ~ long | depth, data = quakes)
food2 <- given.depth <- co.intervals(quakes$depth, number = 4, overlap = .1)
food3 <- coplot(lat ~ long | depth, data = quakes, given.values = given.depth, rows = 1)

## Conditioning on 2 variables:
food4 <- lat ~ long | depth * mag
food5 <- coplot(ll.dm, data = quakes)
food6 <- coplot(ll.dm, data = quakes, number = c(4, 7), show.given = c(TRUE, FALSE))
food7 <- coplot(ll.dm, data = quakes, number = c(3, 7),
       overlap = c(-.5, .1)) # negative overlap DROPS values

## given two factors
food8 <- seq_len(nrow(warpbreaks)) # to get nicer default labels
food9 <- coplot(breaks ~ Index | wool * tension, data = warpbreaks,
       show.given = 0:1)
food10 <- coplot(breaks ~ Index | wool * tension, data = warpbreaks,
       col = "red", bg = "pink", pch = 21,
       bar.bg = c(fac = "light blue"))

## Example with empty panels:
food11 <- with(data.frame(state.x77), {
coplot(Life.Exp ~ Income | Illiteracy * state.region, number = 3,
       panel = function(x, y, ...) panel.smooth(x, y, span = .8, ...))
## y ~ factor -- not really sensible, but 'show off':
coplot(Life.Exp ~ state.region | Income * state.division,
       panel = panel.smooth)
})