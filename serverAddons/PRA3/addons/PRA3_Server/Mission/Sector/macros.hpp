#define MODULE mission
#include "\pr\PRA3\addons\PRA3_Server\macros.hpp"
#define SelectSideMarker(var) (["u_installation", "b_installation", "o_installation", "n_installation"] select ([sideUnknown, west, east, independent] find var))
