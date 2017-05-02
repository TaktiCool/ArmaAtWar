class AAW_UI_SquadScreen {
    idd = 2000;
    onLoad = "['AAW_UI_SquadScreen_onLoad', _this] call CLib_fnc_localEvent;";
    onUnload = "'AAW_UI_SquadScreen_onUnload' call CLib_fnc_localEvent;";

    class Controls {
        class SquadManagement : AAW_UI_SquadManagement {
            y = PY(5) + safeZoneY;
        };
    };
};
