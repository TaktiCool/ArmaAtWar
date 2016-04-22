class CfgRevive {
    // Damage handling
    damageCoefficients[] = {1, 1, 1, 1, 1, 1, 1}; // How the damage effects the different selections
    unconsciousDamageCoefficient = 10; // An unconscious unit should die fast when hit
    maxDamage = 3; // Upper limit to prevent unbelievable damage values

    // Bleeding
    bleedCoefficient = 1; // How fast a unit bleeds
    bleedOutValue = 300; // Value which determines when a unit is out of blood (and falls unconscious)

    // Unconsciousness
    preventInstantDeath = 1; // Enable or disable unconsciousness
    unconsciousDuration = 500; // Value which determines how long a unit stays unconscious (calculated with bleeding)

    // Bandage
    bandageActionDuration = 20; // Time a MEDIC needs to bandage
    bandageCoefficient = 2; // Duration penalty for non medics

    // Revive
    reviveActionDuration = 20; // Time a MEDIC needs to revive
    reviveCoefficient = 2; // Duration penalty for non medics

    // Healing
    healingActionAmount = 0.05; // Amount a MEDIC heals per second
    healingCoefficient = 0.5; // Amount penalty for non medics
};
