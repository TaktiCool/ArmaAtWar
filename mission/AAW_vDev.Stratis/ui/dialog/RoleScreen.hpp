class AAW_UI_RoleScreen {
    idd = 3000;
    onLoad = "['AAW_UI_RoleScreen_onLoad', _this] call CLib_fnc_localEvent;";
    onUnload = "'AAW_UI_RoleScreen_onUnload' call CLib_fnc_localEvent;";

    class Controls {
        class RoleManagement : AAW_UI_RoleManagement {};
    };
};
