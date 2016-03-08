class default {
    respawnTime = 10;
    condition = "true";
    side = "";
};

class defaultWest : default {
    side = "WEST";
};

class defaultEast : default {
    side = "EAST";
};

class defaultIndependent : default {
    side = "INDEPENDENT";
};


class vr_hunter_0 : defaultWest {
};

class vr_slammer_0 : defaultWest {
    condition = "time > 60";
};

class vr_ifrit_0 : defaultEast {
};

class vr_varsuk_0 : defaultEast {
    condition = "time > 60";
};
