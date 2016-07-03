class PRA3_UI_MedicalInfo {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable ['PRA3_UI_MedicalInfo', _this select 0];";
    class Controls {

        class Text : RscStructuredText {
            idc = 5000;
            shadow = 0;
            x = 0.5 - PX(25);
            y = 0.5 - PY(1.5);
            w = PX(50);
            h = PY(6);
            text = "";
            size = PY(2);
            class Attributes
            {
                font = "PuristaMedium";
                color = "#ffffff";
                align = "center";
                shadow = 0;
            };
        };
    };
};
