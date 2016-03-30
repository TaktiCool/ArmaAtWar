/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Fake Function that call and Compile initFunctions because no PreProcessor is Avable over the cfgFunctions >> init entry

    Parameter(s):
    0: Argument Name <TYPE>

    Returns:
    0: Return Name <TYPE>
*/
_this call compile preprocessFileLineNumbers "pr\PRA3\addons\PRA3_Server\initFunctions.sqf";
//call compile preprocessFileLineNumbers "pr\PRA3\addons\PRA3_Server\initOld.sqf";
//call compile preprocessFileLineNumbers "A3\functions_f\initFunctions.sqf";
