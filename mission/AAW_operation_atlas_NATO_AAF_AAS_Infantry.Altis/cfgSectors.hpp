
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
                dependency[] = {"base_guer","sector_1"};
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
                dependency[] = {"sector_2","sector_4"};
                designator = "D";
            };

            class sector_4 : sector {
                dependency[] = {"sector_3","base_west"};
                designator = "E";
            };

        };

    };
};
