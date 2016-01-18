// List of script functions allowed to be sent from client via remoteExec
class Functions
{
  // State of remoteExec: 0-turned off, 1-turned on, taking whitelist into account, 2-turned on, however, ignoring whitelists (default because of backward compatibility)
  mode = 2;
  // Ability to send jip messages: 0-disabled, 1-enabled (default)
  jip = 1;
  /*your functions here*/
  class addActionToObject {allowedTargets=0;};
  class attachPoles {allowedTargets=0;};
  class createMarkerFARP {allowedTargets=0;};
  class deleteMarkerFARP {allowedTargets=0;};
  class deployFARP {allowedTargets=0;};
  class dynamicText {allowedTargets=0;};
  class initFARP {allowedTargets=0;};
  class removeAllActions {allowedTargets=0;};
  class sectorFlip {allowedTargets=0;};
  class setFuel {allowedTargets=0;};
  class undeployFARP {allowedTargets=0;};
  class MP {allowedTargets=0;};       
};

// List of script commands allowed to be sent from client via remoteExec
class Commands
{
  mode = 2;
  class hint {allowedTargets=0};
  class createMarker {allowedTargets=0};
  class setMarkerShape {allowedTargets=0};
  class setMarkerType {allowedTargets=0};
  class setMarkerText {allowedTargets=0};
  class lock {allowedTargets=0};
};