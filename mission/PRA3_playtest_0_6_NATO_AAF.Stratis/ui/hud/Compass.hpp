#define LINE(var) \
class Line##var : Line1 {\
    idc = 7100 + var;\
    x = PX(0.15 + 2.5 * (var - 1));\
};

#define BEARING(var,textVar) \
class Bearing##var : Bearing1 {\
    idc = 7300 + var;\
    x = PX(-0.25 + 7.5 * (var - 1));\
    text = textVar;\
};

class PRA3_UI_Compass {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable ['PRA3_UI_Compass', _this select 0];";
    class Controls {
        class CtrlGroup : RscControlsGroupNoScollbars {
            idc = 7000;
            x = 0.5 - PX(46.25);
            y = PY(103) + safeZoneY;
            w = PX(92.5);
            h = PY(5);

            class Controls {
                class Needle : RscPicture {
                    idc = 7001;
                    text = "ui\media\fob_ca.paa";
                    angle = 180;
                    x = PX(46.25 - 1);
                    y = PY(1.6);
                    w = PX(2);
                    h = PY(1);
                };
                class CtrlGroup : RscControlsGroupNoScollbars {
                    idc = 7100;
                    x = 0;
                    y = 0;
                    w = PX(272.5); // 360° + 185°
                    h = PY(5);

                    class Controls {
                        class Line1 : RscPicture {
                            idc = 7101;
                            text = "#(argb,8,8,3)color(1,1,1,1)";
                            x = PX(0.15);
                            y = PY(0.6);
                            w = PX(2.2);
                            h = PY(0.3);
                        };
                        LINE(2)
                        LINE(3)
                        LINE(4)
                        LINE(5)
                        LINE(6)
                        LINE(7)
                        LINE(8)
                        LINE(9)
                        LINE(10)
                        LINE(11)
                        LINE(12)
                        LINE(13)
                        LINE(14)
                        LINE(15)
                        LINE(16)
                        LINE(17)
                        LINE(18)
                        LINE(19)
                        LINE(20)
                        LINE(21)
                        LINE(22)
                        LINE(23)
                        LINE(24)
                        LINE(25)
                        LINE(26)
                        LINE(27)
                        LINE(28)
                        LINE(29)
                        LINE(30)
                        LINE(31)
                        LINE(32)
                        LINE(33)
                        LINE(34)
                        LINE(35)
                        LINE(36)
                        LINE(37)
                        LINE(38)
                        LINE(39)
                        LINE(40)
                        LINE(41)
                        LINE(42)
                        LINE(43)
                        LINE(44)
                        LINE(45)
                        LINE(46)
                        LINE(47)
                        LINE(48)
                        LINE(49)
                        LINE(50)
                        LINE(51)
                        LINE(52)
                        LINE(53)
                        LINE(54)
                        LINE(55)
                        LINE(56)
                        LINE(57)
                        LINE(58)
                        LINE(59)
                        LINE(60)
                        LINE(61)
                        LINE(62)
                        LINE(63)
                        LINE(64)
                        LINE(65)
                        LINE(66)
                        LINE(67)
                        LINE(68)
                        LINE(69)
                        LINE(70)
                        LINE(71)
                        LINE(72)
                        LINE(73)
                        LINE(74)
                        LINE(75)
                        LINE(76)
                        LINE(77)
                        LINE(78)
                        LINE(79)
                        LINE(80)
                        LINE(81)
                        LINE(82)
                        LINE(83)
                        LINE(84)
                        LINE(85)
                        LINE(86)
                        LINE(87)
                        LINE(88)
                        LINE(89)
                        LINE(90)
                        LINE(91)
                        LINE(92)
                        LINE(93)
                        LINE(94)
                        LINE(95)
                        LINE(96)
                        LINE(97)
                        LINE(98)
                        LINE(99)
                        LINE(100)
                        LINE(101)
                        LINE(102)
                        LINE(103)
                        LINE(104)
                        LINE(105)
                        LINE(106)
                        LINE(107)
                        LINE(108)
                        LINE(109)
                        class Bearing1 : PRA3_RscText {
                            idc = 7301;
                            text = "W";
                            style = ST_CENTER;
                            x = PX(-0.25);
                            y = PY(2);
                            w = PX(3);
                            h = PY(1.5);
                        };
                        BEARING(2,"285")
                        BEARING(3,"300")
                        BEARING(4,"NW")
                        BEARING(5,"330")
                        BEARING(6,"345")
                        BEARING(7,"N")
                        BEARING(8,"015")
                        BEARING(9,"030")
                        BEARING(10,"NE")
                        BEARING(11,"060")
                        BEARING(12,"075")
                        BEARING(13,"E")
                        BEARING(14,"105")
                        BEARING(15,"120")
                        BEARING(16,"SE")
                        BEARING(17,"150")
                        BEARING(18,"165")
                        BEARING(19,"S")
                        BEARING(20,"195")
                        BEARING(21,"210")
                        BEARING(22,"SW")
                        BEARING(23,"240")
                        BEARING(24,"255")
                        BEARING(25,"W")
                        BEARING(26,"285")
                        BEARING(27,"300")
                        BEARING(28,"NW")
                        BEARING(29,"330")
                        BEARING(30,"345")
                        BEARING(31,"N")
                        BEARING(32,"015")
                        BEARING(33,"030")
                        BEARING(34,"NO")
                        BEARING(35,"060")
                        BEARING(36,"075")
                        BEARING(37,"O")
                    };
                };
            };
        };
    };
};
