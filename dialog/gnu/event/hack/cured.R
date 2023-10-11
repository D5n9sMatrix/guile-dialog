#!/usr/bin/r

# Cumulative Sums, Products, and Extremes
# Description
# Returns a vector whose elements are the cumulative sums, products, minima or maxima of the elements of the argument.

# Usage
# cumsum(x)
# cumprod(x)
# cummax(x)
# cummin(x)
# Arguments
# x	
# a numeric or complex (not cummin or cummax) object, or an object that can be coerced to one of these.

# Details
# These are generic functions: methods can be defined for them individually or via the Math group generic.

# Value
# A vector of the same length and type as x (after coercion), except that cumprod returns a numeric vector for integer input (for consistency with *). Names are preserved.

# An NA value in x causes the corresponding and following elements of the return value to be NA, as does integer overflow in cumsum (with a warning).

# S4 methods
# cumsum and cumprod are S4 generic functions: methods can be defined for them individually or via the Math group generic. cummax and cummin are individually S4 generic functions.

# References
# Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole. (cumsum only.)

# Examples

war1 <- cumsum(1:100)
war2 <- cumprod(1:100)
war3 <- cummin(c(3:100, 2:0, 4:2))
war4 <- cummax(c(3:100, 2:0, 4:2))