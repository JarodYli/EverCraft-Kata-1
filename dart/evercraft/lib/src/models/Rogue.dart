import 'Character.dart';
import 'package:evercraft/src/utils/Alignment.dart';
import 'package:evercraft/src/utils/Combat.dart';
import 'package:evercraft/src/utils/AttackResults.dart';
import 'package:evercraft/src/utils/AbilityScore.dart';
import 'package:evercraft/src/utils/Ability.dart';

import 'dart:math';

class Rogue extends Character {

  Rogue () {

    this.name;
    this.alignment = Alignment.Neutral;
    this.hitPoints = 5;
    this.baseArmorClass = 10;
    this.abilities = GenerateDefaultAbilities();

    maxHitPoints = max(1, 5 + GetAbilityModifier(Ability.Constitution));
    hitPoints = maxHitPoints;
  }

  Alignment get getAlignment
  {
    return alignment;
  }

  set setAlignment(value) {
    if (alignment != value) {
      if (value == Alignment.Good) {
        throw new Exception("Rogue Alignment cannot be set to Good.");
      }
      alignment = value;
    }
  }

  void Attack(Character defender, int r, int attackModifier){
    int damageDealt = 0;
    int damageModifier = 0;
    int criticalModifier = 3;
    var defenderModifier = defender.GetAbilityModifier(Ability.Dexterity);
    attackModifier += GetAbilityModifier(Ability.Dexterity) + max(0, defenderModifier);
    if(weapon.length > 0){
      attackModifier += GetWeaponAttackModifier();
      attackPower += GetWeaponDamageModifier();
    }
    damageModifier = abilities[Ability.Dexterity].modifier;
    var attackResult = Combat.Attack(defender, r, attackModifier);
    if (attackResult == AttackResult.CriticalHit)
    {
      if(weapon.length > 0) {
        criticalModifier = 4;
      }
      damageDealt = criticalModifier * max(1, attackPower + damageModifier);
    }
    else if (attackResult == AttackResult.Hit)
    {
      if(weapon.length > 0) {
        damageModifier += GetWeaponDamageModifier();
      }
      damageDealt = max(1, attackPower + damageModifier);
    }

    if(damageDealt > 0){
      defender.TakeDamage(damageDealt);
      AddExperience(10);
    }
  }
}