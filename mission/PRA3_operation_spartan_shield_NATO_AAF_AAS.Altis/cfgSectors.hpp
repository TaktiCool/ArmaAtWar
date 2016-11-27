
// base config
class sector {
    dependency[] = {};
    ticketValue = 30;
    captureTime[] = {60,90};
    minUnits = 2;
    isLastSector = "";
    firstCaptureTime[] = {15,30};
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
            class sector_0 : sector {
                dependency[] = {"base_west","sector_1"};
                designator = "A";
            };

            class sector_1 : sector {
                dependency[] = {"sector_0","sector_4"};
                designator = "B";
            };

            class sector_4 : sector {
                dependency[] = {"sector_1","sector_5"};
                designator = "C";
            };

            class sector_5 : sector {
                dependency[] = {"sector_4","base_guer"};
                designator = "D";
            };

        };

    };
};
