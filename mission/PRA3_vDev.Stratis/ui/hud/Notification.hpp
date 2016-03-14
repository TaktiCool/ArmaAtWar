class PRA3_UI_Notification {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable [""PRA3_UI_Notification"", _this select 0];";
    class Controls {
        class CtrlGroup : RscControlsGroupNoScollbars {
            idc = 4000;
            x = 0.5 - PX(20);
            y = PY(4.5) + safeZoneY;
            w = PX(40);
            h = PY(3);

            class Controls {
                class Background : RscPicture {
                    idc = 4001;
                    text = "media\notification_gradient.paa";
                    x = PX(0);
                    y = PY(0);
                    w = PX(40);
                    h = PY(3.5);
                };

                class NotificationText : RscText {
                    idc = 4002;
                    shadow = 0;
                    x = PX(0);
                    y = PY(3);
                    w = PX(40);
                    h = PY(0.6);
                    style = ST_CENTER;
                };
            };
        };
    };
};
