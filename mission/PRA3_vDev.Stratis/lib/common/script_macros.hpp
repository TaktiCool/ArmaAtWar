#define DOUBLES(var1,var2) ##var1##_##var2
#define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3
#define QUOTE(var1) #var1

#define EGVAR(var1,var2) TRIPLES(PREFIX,var1,var2)
#define GVAR(var1) EGVAR(COMPONENT,var1)
#define QGVAR(var1) QUOTE(GVAR(var1))
#define QEGVAR(var1,var2) QUOTE(EGVAR(var1,var2))

#define EFUNCTAG(var1) DOUBLES(PREFIX,var1)
#define FUNCTAG EFUNCTAG(COMPONENT)

#define EFUNCPATH(var1) ##ROOT_FOLDER\PREFIX\##var1\functions
#define FUNCPATH EFUNCPATH(COMPONENT)

#define EFUNC(var1,var2) TRIPLES(EFUNCTAG(var1),fnc,var2)
#define FUNC(var1) TRIPLES(FUNCTAG,fnc,var1)
#define QFUNC(var1) QUOTE(FUNC(var1))
#define QEFUNC(var1,var2) QUOTE(EFUNC(var1,var2))

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
#define LOGICGROUP missionNamespace getVariable ["BG_common_logicGroup",createGroup (createCenter sideLogic);
