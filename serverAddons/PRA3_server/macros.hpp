#define MAJOR 3
#define MINOR 5
#define PATCHLVL 0
#define BUILD 0

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

#define QUOTE(var) #var

#define FUNCPATH(var) \pr\PRA3\addons\PRA3_server\##MODULE\fn_##var.sqf
#define FFUNCPATH(folder,var) \x\AME\addons\AME\##MODULE\##folder\fn_##var.sqf

#define GVAR(var) PRA3_##MODULE##_##var
#define QGVAR(var) #GVAR(var)

#define EGVAR(var1,var2) PRA3_##var1##_##var2
#define QEGVAR(var1,var2) #EGVAR(var1,var2)

#define GEVENT(var1,var2) QUOTE(PRA3_Event_##var1##_##var2)

#define FUNC(var) PRA3_##MODULE##_fnc##_##var
#define QFUNC(var) #FNC(var)

#define EFUNC(var1,var2) PRA3_##var1##_fnc##_##var2
#define QEFUNC(var1,var2) #EFNC(var1,var2)

#define PREP(fncName) [QUOTE(FUNCPATH(fncName)), QFNC(fncName)] call PRA3_fnc_compileCode;
#define EPREP(folder,fncName) [QUOTE(FFNCPATH(folder,fncName)), QFNC(fncName)] call PRA3_fnc_compileCode;

#ifdef PRA3_DEBUGFULL
	#define DUMP(var) diag_log format ["[PRA3 - %1]: %2", #MODULE, str (var)];
#else
	#define DUMP(var) /*Deactivated*/
#endif
