#include "macros.hpp"

if (isNil QFUNC(compile)|| isNil QFUNC(compressString) || isNil QFUNC(decompressString) || isNil QFUNC(stripSqf)) then {
    DFUNC(compile) = compile preprocessFileLineNumbers QUOTE(FFNCPATH(Compile,compile));
    DFUNC(compressString) = compile preprocessFileLineNumbers QUOTE(FFNCPATH(Compile,compressString));
    DFUNC(decompressString) = compile preprocessFileLineNumbers QUOTE(FFNCPATH(Compile,decompressString));
    DFUNC(stripSqf) = compile preprocessFileLineNumbers QUOTE(FFNCPATH(Compile,stripSqf));
};

#include "PREP.hpp"
