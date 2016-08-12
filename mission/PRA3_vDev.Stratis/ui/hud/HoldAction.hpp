class PRA3_UI_HoldAction {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable ['PRA3_UI_HoldAction', _this select 0];";
    class Controls {

        class TextBackground : RscStructuredText {
            idc = 6000;
            shadow = 0;
            x = 0;
            y = 0.509;
            w = 1;
            h = 0.5;
            text = "";
            class Attributes
            {
                font = "PuristaMedium";
                color = "#ffffff";
                align = "center";
                shadow = 0;
            };
        };

        class TextForeground : TextBackground {
            idc = 6001;

        };


    };
};
