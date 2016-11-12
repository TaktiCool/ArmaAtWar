class CfgRevive {
    // Damage handling
    unconsciousDamageCoefficient = 10; // An unconscious unit should die fast when hit

    // Unconsciousness
    preventInstantDeath = 1; // Enable or disable unconsciousness
    unconsciousDuration = 300; // Value which determines how long a unit stays unconscious (calculated with bleeding)

    // Heal
    healActionDuration = 6; // Time a MEDIC needs to bandage
    healCoefficient = 2; // Duration penalty for non medics

    // Revive
    reviveActionDuration = 6; // Time a MEDIC needs to revive
    reviveCoefficient = 2; // Duration penalty for non medics
};
