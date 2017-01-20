#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas

    Description:
    PlaceHolder Function for Later Medical System used later as Wraper Function

    Parameter(s):
    0: Unit that get Checkt <Object>

    Returns:
    is Alive <Bool>
*/

params ["_unit"];
alive _unit && !(_unit getVariable [QEGVAR(Revive,isUnconscious), false])
