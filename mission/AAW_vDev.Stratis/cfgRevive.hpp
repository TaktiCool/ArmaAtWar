class CfgRevive {
    // Damage handling
    unconsciousDamageCoefficient = 10; // An unconscious unit should die fast when hit

    // Unconsciousness
    preventInstantDeath = 1; // Enable or disable unconsciousness
    unconsciousDuration = 500; // Value which determines how long a unit stays unconscious (calculated with bleeding)

    // Heal
    healActionDuration = 8; // Time a MEDIC needs to bandage
    healCoefficient = 2; // Duration penalty for non medics

    // Revive
    reviveActionDuration = 8; // Time a MEDIC needs to revive
    reviveCoefficient = 2; // Duration penalty for non medics
};
