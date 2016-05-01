#define MODULE CompassUI
#include "\pr\PRA3\addons\PRA3_Server\macros.hpp"

#define PYN 105
//#define PRATIO ((safeZoneW/safeZoneH)/(4/3))

#define PX(X) ((X)/PYN*safeZoneH/(4/3))
#define PY(Y) ((Y)/PYN*safeZoneH)