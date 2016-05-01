class PRA3_UI_GroupInfo {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable ['PRA3_UI_GroupInfo', _this select 0];";
    class Controls {
        class CtrlGroup : RscControlsGroupNoScollbars {
            idc = 6000;
            x = 0.5;
            y = 0.5;
            w = PX(17);
            h = PY(50);

            class Controls {
                class Background : RscPicture {
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(17);
                    h = PY(4);
                };
                class SquadName : RscText {
                    idc = 6001;
                    text = "ALPHA";
                    font = "PuristaBold";
                    sizeEx = PY(1.8);
                    shadow = 0;
                    colorBackground[] = {0,0,0,0};
                    colorText[] = {1,1,1,1};
                    x = PX(0);
                    y = PY(0);
                    w = PX(8);
                    h = PY(2);
                };

                class SquadType : RscText {
                    idc = 6002;
                    text = "Rifle Squad";
                    font = "PuristaMedium";
                    style = ST_RIGHT;
                    sizeEx = PY(1.8);
                    shadow = 0;
                    colorBackground[] = {0,0,0,0};
                    colorText[] = {1,1,1,1};
                    x = PX(8.5);
                    y = PY(0);
                    w = PX(8.5);
                    h = PY(2);
                };

                class SquadDescription : RscText {
                    idc = 6003;
                    text = "German Squad";
                    font = "PuristaMedium";
                    sizeEx = PY(1.8);
                    shadow = 0;
                    colorBackground[] = {0,0,0,0};
                    colorText[] = {0.5,0.5,0.5,1};
                    x = PX(0);
                    y = PY(1.8);
                    w = PX(12);
                    h = PY(2);
                };

                class GroupMemberCount : RscText {
                    idc = 6004;
                    text = "4/9";
                    font = "PuristaMedium";
                    style = ST_RIGHT;
                    sizeEx = PY(1.8);
                    shadow = 0;
                    colorBackground[] = {0,0,0,0};
                    colorText[] = {0.5,0.5,0.5,1};
                    x = PX(12.5);
                    y = PY(1.8);
                    w = PX(4.5);
                    h = PY(2);
                };

                class BackgroundBottom : RscPicture {
                    idc = 6005;
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    x = PX(0);
                    y = PY(4.2);
                    w = PX(17);
                    h = PY(12);
                };

                class SquadMemberList : RscStructuredText {
                    idc = 6006;
                    shadow = 0;
                    x = PX(0);
                    y = PY(4.4);
                    w = PX(17);
                    h = PY(11.9);
                    text = "";
                    size = PY(1.8);
                    class Attributes
                    {
                        font = "PuristaMedium";
                        color = "#ffffff";
                        align = "left";
                        shadow = 0;
                    };
                };
            };
        };
    };
};
