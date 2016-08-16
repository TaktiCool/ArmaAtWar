#include "macros.hpp"

if (isNil QFUNC(compile)) then {
    DFUNC(compile) = compile preprocessFileLineNumbers QUOTE(FUNCPATH(compile));
    DFUNC(compressString) = compile preprocessFileLineNumbers QUOTE(FUNCPATH(compressString));
};

#include "PREP.hpp"
