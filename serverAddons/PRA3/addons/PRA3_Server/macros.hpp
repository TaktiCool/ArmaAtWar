#define MAJOR 0
#define MINOR 6
#define PATCHLVL 0
#define BUILD 1037

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

// dont release with this setting enabled
#define isDev

#define QUOTE(var) #var

#define FUNCPATH(var) \pr\PRA3\addons\PRA3_Server\##MODULE\fn_##var.sqf
#define FFNCPATH(folder,var) \pr\PRA3\addons\PRA3_Server\##MODULE\##folder\fn_##var.sqf

#define GVAR(var) PRA3_##MODULE##_##var
#define QGVAR(var) QUOTE(GVAR(var))

#define EGVAR(var1,var2) PRA3_##var1##_##var2
#define QEGVAR(var1,var2) QUOTE(EGVAR(var1,var2))

#define CGVAR(var1) EGVAR(Core,var1)
#define QCGVAR(var1) QEGVAR(Core,var1)

#define UIVAR(var1) QEGVAR(UI,var1)

#define PYN 108
#define PX(X) ((X)/PYN*safeZoneH/(4/3))
#define PY(Y) ((Y)/PYN*safeZoneH)

#ifdef isDev
    #define DUMP(var) \
        diag_log format ["(%1) [PRA3 LOG - %2]: %3", diag_frameNo, #MODULE, var];\
        systemChat format ["(%1) [PRA3 DUMP - %2]: %3", diag_frameNo, #MODULE, var];\
        if (hasInterface) then {\
            sendlogfile = [format ["(%1) [PRA3 DUMP - %2]: %3", diag_frameNo, #MODULE, var], format ["%1_%2", profileName, GVAR(playerUID)]];\
            publicVariableServer "sendlogfile";\
        };
#endif

#ifdef PRA3_DEBUGFULL
    #undef DUMP
    #define DUMP(var) \
        diag_log format ["(%1) [PRA3 LOG - %2]: %3", diag_frameNo, #MODULE, var];\
        systemChat format ["(%1) [PRA3 DUMP - %2]: %3", diag_frameNo, #MODULE, var];\
        if (hasInterface) then {\
            sendlogfile = [format ["(%1) [PRA3 DUMP - %2]: %3", diag_frameNo, #MODULE, var], format ["%1_%2", profileName, GVAR(playerUID)]];\
            publicVariableServer "sendlogfile";\
        };
#endif

#ifndef DUMP
    #define DUMP(var) /* disabled */
#endif



#ifdef isDev
    #define LOG(var) \
        diag_log format ["(%1) [PRA3 LOG - %2]: %3", diag_frameNo, #MODULE, var];\
        systemChat format ["(%1) [PRA3 DUMP - %2]: %3", diag_frameNo, #MODULE, var];\
        if (hasInterface) then {\
            sendlogfile = [format ["(%1) [PRA3 DUMP - %2]: %3", diag_frameNo, #MODULE, var], format ["%1_%2", profileName, GVAR(playerUID)]];\
            publicVariableServer "sendlogfile";\
        };
#endif

#ifdef PRA3_DEBUGFULL
    #undef LOG
    #define LOG(var) \
        diag_log format ["(%1) [PRA3 LOG - %2]: %3", diag_frameNo, #MODULE, var];\
        systemChat format ["(%1) [PRA3 DUMP - %2]: %3", diag_frameNo, #MODULE, var];\
        if (hasInterface) then {\
            sendlogfile = [format ["(%1) [PRA3 DUMP - %2]: %3", diag_frameNo, #MODULE, var], format ["%1_%2", profileName, GVAR(playerUID)]];\
            publicVariableServer "sendlogfile";\
        };
#endif

#ifndef LOG
    #define LOG(var) diag_log format ["(%1) [PRA3 LOG - %2]: %3", diag_frameNo, #MODULE, var];
#endif


#define DFUNC(var) PRA3_##MODULE##_fnc##_##var

#define QFUNC(var) QUOTE(DFUNC(var))

#ifdef isDev
    #define FUNC(var) (missionNamespace getVariable [QFUNC(var), {DUMP(QFUNC(var) + " Dont Exist")}])
#endif

#ifdef PRA3_DEBUGFULL
    #undef FUNC
    #define FUNC(var) {\
        DUMP("Function " + QFUNC(var) + " called with " + str (_this));\
        private _tempRet = _this call DFUNC(var);\
        if (!isNil "_tempRet") then {\
            _tempRet\
        }\
    }
#endif

#ifndef FUNC
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
