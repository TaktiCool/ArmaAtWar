#define GWIDTH 40
#define GHEIGHT 26

#define PLAYER_LIST_ENTRY(ID,PID,POS) \
        class PlayerDesignator##ID##_##PID : BG_RscText {\
            idc = ID+PID*100 + 2;\
            text = "A";\
            font = "PuristaSemiBold";\
            x = PX(4.5);\
            y = PY(POS);\
            w = PX(20);\
            h = PY(2.5);\
        };\
        class PromoteBtn##ID##_##PID : BG_RscButtonMenu {\
            idc = ID+PID*100 + 3;\
            text = "PROMOTE";\
            x = PX(24.5);\
            y = PY(POS);\
            w = PX(9);\
            h = PY(2.5);\
        };\
        class KickBtn##ID##_##PID : BG_RscButtonMenu {\
            idc = ID+PID*100 + 4;\
            text = "KICK";\
            x = PX(34);\
            y = PY(POS);\
            w = PX(6);\
            h = PY(2.5);\
        };\

#define SQUAD_LIST_ENTRY(ID,POS) \
        class Designator##ID : BG_RscText {\
            idc = ID + 2;\
            text = "A";\
            font = "PuristaSemiBold";\
            x = PX(1);\
            y = PY(POS);\
            w = PX(3);\
            h = PY(3);\
        };\
        class Name##ID : BG_RscText {\
            idc = ID + 3;\
            text = "SquadName";\
            font = "PuristaSemiBold";\
            x = PX(3.5);\
            y = PY(POS);\
            w = PX(26);\
            h = PY(3);\
        };\
        class Channel##ID : BG_RscText {\
            idc = ID + 4;\
            text = "Ch. 6";\
            x = PX(29);\
            y = PY(POS);\
            w = PX(5);\
            h = PY(3);\
        };\
        class PlayerCount##ID : BG_RscText {\
            idc = ID + 5;\
            text = "6 / 9";\
            x = PX(35);\
            y = PY(POS);\
            w = PX(4);\
            h = PY(3);\
        };\
        PLAYER_LIST_ENTRY(ID,1,3)\
        PLAYER_LIST_ENTRY(ID,2,3+2.5)\
        PLAYER_LIST_ENTRY(ID,3,3+2*2.5)\
        PLAYER_LIST_ENTRY(ID,4,3+3*2.5)\
        PLAYER_LIST_ENTRY(ID,5,3+4*2.5)\
        PLAYER_LIST_ENTRY(ID,6,3+5*2.5)\
        PLAYER_LIST_ENTRY(ID,7,3+6*2.5)\
        PLAYER_LIST_ENTRY(ID,8,3+7*2.5)\
        PLAYER_LIST_ENTRY(ID,9,3+8*2.5)\




class GVAR(RespawnScreen) {
    idd = -1;
    onLoad = "uiNamespace setVariable [""BG_respawn_RespawnScreen"", _this select 0];";
    class Controls {


        #define GHEIGHT 3
        class TeamInfo : RscControlsGroup {
            idc = 100;
            x = 0.5 - PX(75);
            y = safeZoneY + PY(10);
            w = PX(GWIDTH);
            h = PY(GHEIGHT);




            class Controls {
                class Background : RscPicture {
                    idc = 101;
                    text = "#(argb,8,8,3)color(0.2,0.2,0.2,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(GWIDTH);
                    h = PY(GHEIGHT);
                };
                class TeamFlag : RscPicture {
                    idc = 102;
                    text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
                    x = PX(0.5);
                    y = PY(0.5);
                    w = PX(3.33);
                    h = PY(2);
                };

                class TeamName : BG_H1Text {
                    idc = 103;
                    text = "US ARMY";
                    x = PX(5);
                    y = PY(0);
                    w = PX(GWIDTH-6);
                    h = PY(GHEIGHT);
                };
            };
        };

        #define GHEIGHT 43

        class SquadManagement : RscControlsGroup {
            idc = 200;
            x = 0.5 - PX(75);
            y = safeZoneY + PY(14);
            w = PX(GWIDTH);
            h = PY(GHEIGHT);



            class Controls {
                class Background : RscPicture {
                    idc = 201;
                    text = "#(argb,8,8,3)color(0.2,0.2,0.2,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(GWIDTH);
                    h = PY(GHEIGHT);
                };

                class Heading : BG_H2Text {
                    idc = 202;
                    text = "SQUADS";
                    x = PX(0.5);
                    y = PY(0);
                    w = PX(GWIDTH-0.5);
                };

                class SquadList : RscControlsGroup {
                    idc = 10000;
                    x = 0;
                    y = PY(4);
                    w = PX(GWIDTH);
                    h = PY(31);

                    class Controls {
                        SQUAD_LIST_ENTRY(11000,0)
                        SQUAD_LIST_ENTRY(12000,1*3.5)
                        SQUAD_LIST_ENTRY(13000,2*3.5)
                        SQUAD_LIST_ENTRY(14000,3*3.5)
                        SQUAD_LIST_ENTRY(15000,4*3.5)
                        SQUAD_LIST_ENTRY(16000,5*3.5)
                        SQUAD_LIST_ENTRY(17000,6*3.5)
                        SQUAD_LIST_ENTRY(18000,7*3.5)
                    };
                };

                class NewSquadDesignator : BG_RscText {
                    idc = 204;
                    x = PX(1);
                    y = PY(39);
                    w = PX(2);
                };

                class NewSquadDescriptionInput : BG_RscEdit {
                    idc = 205;
                    x = PX(4);
                    y = PY(39);
                    w = PX(26.5);
                };

                class CreateSquadBtn : BG_RscButtonMenu {
                    idc = 206;
                    text = "CREATE";
                    x = PX(31);
                    y = PY(39);
                    w = PX(8);

                    onButtonClick = "[_this] call BG_respawn_fnc_createSquadBtn;";
                };
            };
        };
    };
};
