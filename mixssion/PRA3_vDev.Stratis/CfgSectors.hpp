class base_west : sector {
};

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
    dependency[] = {"sector_2","base_east"};
    designator = "D";
};

class base_east : sector {
};
