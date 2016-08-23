class PREFIX {
    class Dependencies {
        class Core {
            require[] = {};
        };
        class Kit {
            require[] = {"Core", "Squad"};
        };
        class Logistic {
            require[] = {"Core"};
        };
        class GarbageCollector {
            require[] = {"Core"};
        };

        class Mission {
            require[] = {"Core"};
        };
        class Nametags {
            require[] = {"Core"};
        };
        class Revive {
            require[] = {"Core"};
        };

        class Sector {
            require[] = {"Core", "Mission"};
        };
        class Tickets {
            require[] = {"Core", "Mission"};
        };

        class RespawnUI {
            require[] = {"Core", "Squad", "Deployment", "Kit"};
        };
        class Deployment {
            require[] = {"Core", "Mission"};
        };
        class Squad {
            require[] = {"Core", "Mission"};
        };

        class UnitTracker {
            require[] = {"Core", "Mission", "Kit", "Squad"};
        };

        class CompassUI {
            require[] = {"Core"};
        };
    };

    #include "cfgLocalisation.hpp"

    class DOUBLE(PREFIX,Extension) {
        version = "0.1";
    };
};
