
// base config
class sector {
    dependency[] = {};
    ticketValue = 30;
    captureTime[] = {30,60};
    minUnits = 3;
    isLastSector = "";
    firstCaptureTime[] = {5,15};
};

class CfgSectors {

    class base_west : sector {
        designator = "HQ";
    };

    class base_guer : sector {
        designator = "HQ";
    };

    class CfgSectorPath {
        class path_0 {
            class sector_0 : sector {
                dependency[] = {"base_west","sector_1"};
                designator = "A";
            };

            class sector_1 : sector {
                dependency[] = {"sector_0","sector_2"};
                designator = "B";
            };

            class sector_2 : sector {
                dependency[] = {"sector_1","sector_3"};
                designator = "C";
            };

            class sector_3 : sector {
                dependency[] = {"sector_2","base_guer"};
                designator = "D";
            };
        };

        class path_1 {
            class sector_5 : sector {
                dependency[] = {"base_west","sector_9"};
                designator = "A";
            };

            class sector_9 : sector {
                dependency[] = {"sector_5","sector_6"};
                designator = "B";
            };

            class sector_6 : sector {
                dependency[] = {"sector_9","sector_3"};
                designator = "C";
            };

            class sector_3 : sector {
                dependency[] = {"sector_6","base_guer"};
                designator = "D";
            };
        };

        class path_3 {
            class sector_4 : sector {
                dependency[] = {"base_west","sector_8"};
                designator = "A";
            };

            class sector_8 : sector {
                dependency[] = {"sector_4","sector_13"};
                designator = "B";
            };

            class sector_13 : sector {
                dependency[] = {"sector_8","sector_10"};
                designator = "C";
            };

            class sector_10 : sector {
                dependency[] = {"sector_13","base_guer"};
                designator = "D";
            };
        };

        class path_4 {
            class sector_12 : sector {
                dependency[] = {"base_west","sector_11"};
                designator = "A";
            };

            class sector_11 : sector {
                dependency[] = {"sector_12","sector_2"};
                designator = "B";
            };

            class sector_2 : sector {
                dependency[] = {"sector_11","sector_7"};
                designator = "C";
            };

            class sector_7 : sector {
                dependency[] = {"sector_2","base_guer"};
                designator = "D";
            };
        };

        class path_5 {
            class sector_4 : sector {
                dependency[] = {"base_west","sector_9"};
                designator = "A";
            };

            class sector_9 : sector {
                dependency[] = {"sector_4","sector_6"};
                designator = "B";
            };

            class sector_6 : sector {
                dependency[] = {"sector_9","sector_3"};
                designator = "C";
            };

            class sector_3 : sector {
                dependency[] = {"sector_6","base_guer"};
                designator = "D";
            };
        };

        class path_6 {
            class sector_0 : sector {
                dependency[] = {"base_west","sector_9"};
                designator = "A";
            };

            class sector_9 : sector {
                dependency[] = {"sector_0","sector_2"};
                designator = "B";
            };

            class sector_2 : sector {
                dependency[] = {"sector_9","sector_3"};
                designator = "C";
            };

            class sector_3 : sector {
                dependency[] = {"sector_2","base_guer"};
                designator = "D";
            };
        };

        class path_7 {
            class sector_4 : sector {
                dependency[] = {"base_west","sector_9"};
                designator = "A";
            };

            class sector_9 : sector {
                dependency[] = {"sector_4","sector_3"};
                designator = "B";
            };

            class sector_3 : sector {
                dependency[] = {"sector_9","sector_10"};
                designator = "C";
            };

            class sector_10 : sector {
                dependency[] = {"sector_3","base_guer"};
                designator = "D";
            };
        };
    };
};
