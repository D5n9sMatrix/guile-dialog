#!/usr/bin/r

# Returns the Names of All Built-in Objects
# Description
# Return the names of all the built-in objects. These are fetched directly from the symbol table of the R interpreter.

# Usage
# builtins(internal = FALSE)
# Arguments
# internal	
# a logical indicating whether only ‘internal’ functions (which can be called via .Internal) should be returned.

# Details
# builtins() returns an unsorted list of the objects in the symbol table, that is all the objects in the base environment. These are the built-in objects plus any that have been added subsequently when the base package was loaded. It is less confusing to use ls(baseenv(), all.names = TRUE).

# builtins(TRUE) returns an unsorted list of the names of internal functions, that is those which can be accessed as .Internal(foo(args ...)) for foo in the list.

# Value
# A character vector.
b7 <- builtins(internal = FALSE)