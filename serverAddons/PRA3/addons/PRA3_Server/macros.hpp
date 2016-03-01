#define MAJOR 0
#define MINOR 1
#define PATCHLVL 0
#define BUILD 1

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

#define GEVENT(var1,var2) QUOTE(PRA3_Event_##var1##_##var2)

#ifdef PRA3_DEBUGFULL
    #define FUNC(var) {DUMP(QUOTE(Function PRA3_##MODULE##_fnc##_##var called with _this Parameter)); private _tempRet = _this call PRA3_##MODULE##_fnc##_##var; _tempRet}
#else
    #define FUNC(var) PRA3_##MODULE##_fnc##_##var
#endif

#define QFUNC(var) QUOTE(FNC(var))

#define DFUNC(var) PRA3_##MODULE##_fnc##_##var

#define EFUNC(var1,var2) PRA3_##var1##_fnc##_##var2
#define QEFUNC(var1,var2) QUOTE(EUFNC(var1,var2))

#define CFUNC(var1) EFUNC(Core,var1)
#define QCFUNC(var1) QUOTE(CFUNC(var1))

#define PREP(fncName) [QUOTE(FUNCPATH(fncName)), QFUNC(fncName)] call PRA3_Core_fnc_compile;
#define EPREP(folder,fncName) [QUOTE(FFNCPATH(folder,fncName)), QFUNC(fncName)] call PRA3_Core_fnc_compile;

#ifdef PRA3_DEBUGFULL
    #define DUMP(var) diag_log format ["[PRA3 - %1]: %2", #MODULE, str (var)];
#else
    #define DUMP(var) /*Deactivated*/
#endif

#define FORMAT_1(STR,ARG1) format[STR, ARG1]
#define FORMAT_2(STR,ARG1,ARG2) format[STR, ARG1, ARG2]
#define FORMAT_3(STR,ARG1,ARG2,ARG3) format[STR, ARG1, ARG2, ARG3]
#define FORMAT_4(STR,ARG1,ARG2,ARG3,ARG4) format[STR, ARG1, ARG2, ARG3, ARG4]
#define FORMAT_5(STR,ARG1,ARG2,ARG3,ARG4,ARG5) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5]
#define FORMAT_6(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6]
#define FORMAT_7(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7]
#define FORMAT_8(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8]

#define DEBUG(msg) diag_log format ["DEBUG - %1 - %2: %3", DOUBLES(PREFIX,COMPONENT), __FILE___, msg]
#define DEBUG_1(STR, ARG1) DEBUG(FORMAT_1(STR, ARG1))
#define DEBUG_2(STR, ARG1, ARG2) DEBUG(FORMAT_2(STR, ARG1, ARG2))
#define DEBUG_3(STR, ARG1, ARG2, ARG3) DEBUG(FORMAT_3(STR, ARG1, ARG2, ARG3))

#define ERROR(msg) diag_log format ["ERROR - %1 - %2: %3", DOUBLES(PREFIX,COMPONENT), __FILE___, msg]

#define STR2SIDE(s) switch (s) do { case "WEST"; case "west": {blufor}; case "EAST"; case "east": {opfor}; case "GUER"; case "guer": {independent};  case "CIV"; case "civ": {civilian}; case "LOGIC"; case "logic": {sideLogic}; case "UNKNOWN"; case "unknown": {sideUnknown}; case "ENEMY"; case "enemy": {sideEnemy}; case "FRIENDLY"; case "friendly": {sideEnemy}}
#define LOGICGROUP missionNamespace getVariable ["PRA3_common_logicGroup",createGroup (createCenter sideLogic);
