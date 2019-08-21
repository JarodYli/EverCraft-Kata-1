import 'Character.dart';
import 'package:evercraft/src/utils/Alignment.dart';
import 'package:evercraft/src/utils/Combat.dart';
import 'package:evercraft/src/utils/AttackResults.dart';
import 'package:evercraft/src/utils/AbilityScore.dart';
import 'package:evercraft/src/utils/Ability.dart';

import 'dart:math';

class Paladin extends Character {

  Paladin () {

    this.name;
    this.alignment = Alignment.Neutral;
    this.hitPoints = 5;
    this.baseArmorClass = 10;
    this.abilities = GenerateDefaultAbilities();
    this.attackPower = 3;
  }

  Alignment get getAlignment
  {
    return alignment;
  }

  set setAlignment(value) {
    if (alignment != value) {
      alignment = value;
    }
    if(alignment != Alignment.Good){
      throw new Exception("Paladin Alignment must be set to Good.");
      alignment = value;
    }
  }

  void Attack(Character defender, int r, int attackModifier){
    if(defender.alignment == Alignment.Evil){
      attackModifier += 2;
    }
    AttackResult attackSuccess = Combat.Attack(this, r, attackModifier);
    if(attackSuccess == AttackResult.Hit){
      if(defender.alignment == Alignment.Evil){
        attackPower += 2;
      }

      int damageDealt = max(1, attackPower + (abilities[Ability.Strength].modifier));
      defender.TakeDamage(damageDealt);

      AddExperience(10);
    } else if (attackSuccess == AttackResult.CriticalHit){
      if(defender.alignment == Alignment.Evil){
        attackPower += 2;
      }
      int damageDealt = max(1, attackPower + (abilities[Ability.Strength].modifier * 2));
      if(defender.alignment == Alignment.Evil){
        damageDealt *= 3;
      }
      defender.TakeDamage(damageDealt);
      AddExperience(10);
    }
  }

  void AddExperience(int xp)
  {
    int previousLevel = getLevel;
    experience += xp;
    int levelsGained = (getLevel - previousLevel);
    hitPoints += levelsGained * (8 + abilities[Ability.Constitution].modifier);

    int attackPowerGain = levelsGained;
    attackPower += attackPowerGain;
  }
}