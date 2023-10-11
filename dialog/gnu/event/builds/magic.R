#!/usr/bin/r

# Method Utilities
# Description
# Utility functions to support the definition and use of formal methods. Most of these functions will not normally be called directly by the user.

# Usage
# getGeneric(f, mustFind=FALSE, where, package)

# getGroup(fdef, recursive, where)
# getGroupMembers(group, recursive = FALSE, character = TRUE)

# getMethodsMetaData(f, where)
# assignMethodsMetaData (f, value, fdef, where)

# makeGeneric(f, fdef, fdefault =, group=list(), valueClass=character(),
#             package =, signature = NULL, genericFunction = NULL,
#             simpleInheritanceOnly = NULL)

# makeStandardGeneric(f, fdef)

# generic.skeleton(name, fdef, fdefault)

# defaultDumpName(generic, signature)

# doPrimitiveMethod(name, def, call= sys.call(sys.parent()),
#                   ev = sys.frame(sys.parent(2)))

# conformMethod(signature, mnames, fnames, f= , fdef, method)

# matchSignature(signature, fun, where)

# findUnique(what, message, where)

# MethodAddCoerce(method, argName, thisClass, methodClass)

# cacheMetaData(where, attach = TRUE, searchWhere = as.environment(where),
#               doCheck = TRUE)

# cacheGenericsMetaData(f, fdef, attach = TRUE, where, package, methods)

# setPrimitiveMethods(f, fdef, code, generic, mlist)

# missingArg(symbol, envir = parent.frame(), eval)

# sigToEnv(signature, generic)

# rematchDefinition(definition, generic, mnames, fnames, signature)
# unRematchDefinition(definition)
# isRematched(definition)

# asMethodDefinition(def, signature, sealed = FALSE, fdef)

# addNextMethod(method, f, mlist, optional, envir)

# insertClassMethods(methods, Class, value, fieldNames, returnAll)

# balanceMethodsList(mlist, args, check = TRUE) # <- deprecated since R 3.2.0
# Summary of Functions
# getGeneric:
# returns the definition of the function named f as a generic.

# If no definition is found, throws an error or returns NULL according to the value of mustFind. By default, searches in the top-level environment (normally the global environment, but adjusted to work correctly when package code is evaluated from the function library).

# Primitive functions are dealt with specially, since there is never a formal generic definition for them. The value returned is the formal definition used for assigning methods to this primitive. Not all primitives can have methods; if this one can't, then getGeneric returns NULL or throws an error.

# getGroup:
# returns the groups to which this generic belongs, searching from environment where (the global environment normally by default).

# If recursive=TRUE, also all the group(s) of these groups.

# getGroupMembers:
# Return all the members of the group generic function named group. If recursive is TRUE, and some members are group generics, includes their members as well. If character is TRUE, returns just a character vector of the names; otherwise returns a list, whose elements may (or may not) include either names with a package attribute or actual generic functions.

# Note that members that are not defined as generic functions will not be included in the returned value. To see the raw data, use getGeneric(group)@groupMembers.

# getMethodsMetaData, assignMethodsMetaData, mlistMetaName:
# Utilities to get (getMethodsMetaData) and assign (assignMethodsMetaData) the metadata object recording the methods defined in a particular package, or to return the mangled name for that object (mlistMetaName).

# The assign function should not be used directly. The get function may be useful if you want explicitly only the outcome of the methods assigned in this package. Otherwise, use getMethods.

# matchSignature:
# Matches the signature object (a partially or completely named subset of the signature arguments of the generic function object fun), and return a vector of all the classes in the order specified by fun@signature. The classes not specified by signature will be "ANY" in the value, but extra trailing "ANY"'s are removed. When the input signature is empty, the returned signature is a single "ANY" matching the first formal argument (so the returned value is always non-empty).

# Generates an error if any of the supplied signature names are not legal; that is, not in the signature slot of the generic function.

# If argument where is supplied, a warning will be issued if any of the classes does not have a formal definition visible from where.

# MethodAddCoerce:
# Possibly modify one or more methods to explicitly coerce this argument to methodClass, the class for which the method is explicitly defined. Only modifies the method if an explicit coerce is required to coerce from thisClass to methodClass.

# findUnique:
# Return the list of environments (or equivalent) having an object named what, using environment where and its parent environments. If more than one is found, a warning message is generated, using message to identify what was being searched for, unless message is the empty string.

# cacheMetaData, cacheGenericsMetaData, setPrimitiveMethods:
# Utilities for ensuring that the internal information about class and method definitions is up to date. Should normally be called automatically whenever needed (for example, when a method or class definition changes, or when a package is attached or detached). Required primarily because primitive functions are dispatched in C code, rather than by the official model.

# The setPrimitiveMethods function resets the caching information for a particular primitive function. Don't call it directly.

# missingArg:
# Returns TRUE if the symbol supplied is missing from the call corresponding to the environment supplied (by default, environment of the call to missingArg). If eval is true, the argument is evaluated to get the name of the symbol to test. Note that missingArg is closer to the ‘Blue Book’ sense of the missing function, not that of the current R base package implementation. But beware that it works reliably only if no assignment has yet been made to the argument. (For method dispatch this is fine, because computations are done at the beginning of the call.)

# balanceMethodsList:
# Used to be called from setMethod() and is deprecated since R version 3.2.0.

# sigToEnv:
# Turn the signature (a named vector of classes) into an environment with the classes assigned to the names. The environment is then suitable for calling MethodsListSelect, with evalArgs=FALSE, to select a method corresponding to the signature. Usually not called directly: see selectMethod.

# .saveImage:
# Flag, used in dynamically initializing the methods package from .onLoad.

# rematchDefinition, unRematchDefinition, isRematched:
# If the specified method in a call to setMethod specializes the argument list (by replacing ...), then rematchDefinition constructs the actual method stored. Using knowledge of how rematchDefinition works, unRematchDefinition reverses the procedure; if given a function or method definition that does not correspond to this form, it just returns its argument. isRematched returns a logical value indicating whether rematching was used when constructing a given method.

# asMethodDefinition:
# Turn a function definition into an object of class MethodDefinition, corresponding to the given signature (by default generates a default method with empty signature). The definition is sealed according to the sealed argument.

# addNextMethod:
# A generic function that finds the next method for the signature of the method definition method and caches that method in the method definition (promoting the class to "MethodWithNext"). Note that argument mlist is obsolete and not used.

# makeGeneric:
# Makes a generic function object corresponding to the given function name, optional definition and optional default method. Other arguments supply optional elements for the slots of class genericFunction.

# makeStandardGeneric:
# a utility function that makes a valid function calling standardGeneric for name f. Works (more or less) even if the actual definition, fdef, is not a proper function, that is, it's a primitive or internal.

# conformMethod:
# If the formal arguments, mnames, are not identical to the formal arguments to the function, fnames, conformMethod determines whether the signature and the two sets of arguments conform, and returns the signature, possibly extended. The function name, f is supplied for error messages. The generic function, fdef, supplies the generic signature for matching purposes.

# The method assignment conforms if method and generic function have identical formal argument lists. It can also conform if the method omits some of the formal arguments of the function but: (1) the non-omitted arguments are a subset of the function arguments, appearing in the same order; (2) there are no arguments to the method that are not arguments to the function; and (3) the omitted formal arguments do not appear as explicit classes in the signature. A future extension hopes to test also that the omitted arguments are not assumed by being used as locally assigned names or function names in the body of the method.

# defaultDumpName:
# the default name to be used for dumping a method.

# doPrimitiveMethod:
# do a primitive call to builtin function name the definition and call provided, and carried out in the environment ev.

# A call to doPrimitiveMethod is used when the actual method is a .Primitive. (Because primitives don't behave correctly as ordinary functions, not having either formal arguments nor a function body).

# See Also
# setGeneric, setClass, showMethods.

# Examples

b1 <- getGroup("exp")
b2 <- getGroup("==", recursive = TRUE)

b3 <- getGroupMembers("Arith")
b4 <- getGroupMembers("Math")
b5 <- getGroupMembers("Ops") # -> its sub groups