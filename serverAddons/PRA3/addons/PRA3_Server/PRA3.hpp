class PRA3 {
    class Dependencies {
        class Core {
            require[] = {};
        };
        class Kit {
            require[] = {"Core"};
        };
        class Logistic {
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
    };

    class PRA3_Extension {
        version = "0.1";
    };
};
