#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author:

    Description:
    [Description]

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(lastDeploymentManagementUIUpdateFrame) = 0;

[UIVAR(RespawnScreen_DeploymentManagement_update), {
    if (!dialog || GVAR(lastDeploymentManagementUIUpdateFrame) == diag_frameNo) exitWith {};
    GVAR(lastDeploymentManagementUIUpdateFrame) = diag_frameNo;

    disableSerialization;

    // SpawnPointList
    #undef IDC
    #define IDC 403
    private _selectedLnbRow = lnbCurSelRow IDC;
    private _selectedPoint = [[IDC, [lnbCurSelRow IDC, 0]] call CFUNC(lnbLoad), ""] select (_selectedLnbRow == -1);
    EGVAR(Deployment,deploymentPoints) params ["_pointIds", "_pointData"];
    private _visiblePoints = _pointIds select {
        private _pointDetails = _pointData select (_pointIds find _x);
        (_pointDetails select 5) call (_pointDetails select 4)
    };
    lnbClear IDC;
    {
        private _pointDetails = _pointData select (_pointIds find _x);
        _pointDetails params ["_name", "_icon", "_tickets"];
        if (_tickets > 0) then {
            _name = format ["%1 (%2)", _name, _tickets];
        };

        private _rowNumber = lnbAddRow [IDC, [_name]];
        [IDC, [_rowNumber, 0], _x] call CFUNC(lnbSave);

        lnbSetPicture [IDC, [_rowNumber, 0], _icon];

        if (_x == _selectedPoint) then {
            lnbSetCurSelRow [IDC, _rowNumber];
        };
    } count _visiblePoints;
    if ((lnbSize IDC select 0) == 0) then {
        lnbSetCurSelRow [IDC, -1];
        _selectedPoint = "";
    } else {
        if (_selectedPoint == "" || !(_selectedPoint in _visiblePoints)) then {
            lnbSetCurSelRow [IDC, 0];
            _selectedPoint = [IDC, [0, 0]] call CFUNC(lnbLoad);
        };
    };

    // Map
    #undef IDC
    #define IDC 700
    if (_selectedPoint != "") then {
        private _map = (findDisplay 1000) displayCtrl IDC;
        private _pointDetails = _pointData select (_pointIds find _selectedPoint);

        _map ctrlMapAnimAdd [0.5, 0.15, _pointDetails select 3]; //@todo check if dialog syntax can be used
        ctrlMapAnimCommit _map;
    };
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_SpawnPointList_onLBSelChanged), {
    [UIVAR(RespawnScreen_DeploymentManagement_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);
