#define MAJOR 0
#define MINOR 1
#define PATCHLVL 0
#define BUILD 1

#define MODULE mission

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

#define QUOTE(var) #var

#define FUNCPATH(var) \pr\PRA3\addons\PRA3_server\##MODULE\fn_##var.sqf
#define FFNCPATH(folder,var) \pr\PRA3\addons\PRA3_server\##MODULE\##folder\fn_##var.sqf

#define GVAR(var) PRA3_##MODULE##_##var
#define QGVAR(var) QUOTE(GVAR(var))

#define EGVAR(var1,var2) PRA3_##var1##_##var2
#define QEGVAR(var1,var2) QUOTE(EGVAR(var1,var2))

#define CGVAR(var1) EGVAR(Core,var1)
#define QCGVAR(var1) QEGVAR(Core,var1)

#ifdef PRA3_DEBUGFULL
    #define DUMP(var) diag_log format ["[PRA3 - %1]: %2", #MODULE, str (var)];\
        systemChat format ["[PRA3 - %1]: %2", #MODULE, str (var)];
#else
    #define DUMP(var) diag_log format ["[PRA3 - %1]: %2", #MODULE, str (var)];
#endif

#define DFUNC(var) PRA3_##MODULE##_fnc##_##var

#define QFUNC(var) QUOTE(DFUNC(var))

#ifdef PRA3_DEBUGFULL
    #define FUNC(var) { DUMP("Function " + QFUNC(var) + " called with " + str (_this) + " Parameter") private _tempRet = _this call DFUNC(var); _tempRet}
#else
    #define FUNC(var) DFUNC(var)
#endif

#define EFUNC(var1,var2) PRA3_##var1##_fnc##_##var2
#define QEFUNC(var1,var2) QUOTE(EFUNC(var1,var2))

#define CFUNC(var1) EFUNC(Core,var1)
#define QCFUNC(var1) QUOTE(CFUNC(var1))

#define PREP(fncName) [QUOTE(FUNCPATH(fncName)), QFUNC(fncName)] call PRA3_Core_fnc_compile;
#define EPREP(folder,fncName) [QUOTE(FFNCPATH(folder,fncName)), QFUNC(fncName)] call PRA3_Core_fnc_compile;

#ifdef PRA3_DEBUGFULL
    #define ENABLEPERFORMANCECOUNTER
#endif

#ifdef ENABLEPERFORMANCECOUNTER
    #define PERFORMANCECOUNTER_START(var1) [#var1, true] call CFUNC(addPerformanceCounter);
    #define PERFORMANCECOUNTER_END(var1) [#var1, false] call CFUNC(addPerformanceCounter);
#else
    #define PERFORMANCECOUNTER_START(var1) /* Performance Counter disabled */
    #define PERFORMANCECOUNTER_END(var1) /* Performance Counter disabled */
#endif
