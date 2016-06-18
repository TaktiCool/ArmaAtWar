class CfgRevive {
    // Damage handling
    damageCoefficients[] = {1, 1, 1, 1, 1, 1, 1}; // How the damage effects the different selections
    unconsciousDamageCoefficient = 10; // An unconscious unit should die fast when hit
    maxDamage = 1.2; // Upper limit to prevent unbelievable damage values
    maxDamageOnLegsBeforWalking = 0.7;

    // Enableing Remote Damange Handling
    enableRemoteDamageHandling = 1;     // Currently disalbe because its currently just for Testing and WIP

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
    healingActionDuration = 40; // Time a MEDIC needs to heal a unit from maxDamage
    healingCoefficient = 2; // Duration penalty for non medics
};
