#include "macros.hpp"

if (isNil QFUNC(compile)) then {
    DFUNC(compile) = compile preprocessFileLineNumbers QUOTE(FUNCPATH(compile));
};

#include "PREP.hpp"
