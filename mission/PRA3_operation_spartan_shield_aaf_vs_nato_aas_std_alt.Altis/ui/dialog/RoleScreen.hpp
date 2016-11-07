class PRA3_UI_RoleScreen {
    idd = 3000;
    onLoad = "['PRA3_UI_RoleScreen_onLoad', _this] call CLib_fnc_localEvent;";
    onUnload = "'PRA3_UI_RoleScreen_onUnload' call CLib_fnc_localEvent;";

    class Controls {
        class RoleManagement : PRA3_UI_RoleManagement {};
    };
};
