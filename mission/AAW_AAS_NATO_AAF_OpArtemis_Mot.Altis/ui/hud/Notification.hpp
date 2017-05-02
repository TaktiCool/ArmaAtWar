class AAW_UI_Notification {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable ['AAW_UI_Notification', _this select 0];";
    class Controls {
        class CtrlGroup : RscControlsGroupNoScrollbars {
            idc = 4000;
            x = 0.5 - PX(25);
            y = PY(4.5) + safeZoneY;
            w = PX(50);
            h = PY(3.5);

            class Controls {
                class Background : RscPicture {
                    idc = 4001;
                    text = "ui\media\notification_gradient_ca.paa";
                    x = PX(0);
                    y = PY(0);
                    w = PX(50);
                    h = PY(4);
                    colorText[] = {0.8,0.8,0.8,1};
                };

                class NotificationText : RscStructuredText {
                    idc = 4002;
                    shadow = 0;
                    x = PX(0);
                    y = PY(0.2);
                    w = PX(50);
                    h = PY(3);
                    text = "TEST";
                    size = PY(2.5);
                    class Attributes
                    {
                        font = "PuristaMedium";
                        color = "#ffffff";
                        align = "center";
                        shadow = 1;
                    };
                };
            };
        };
    };
};
