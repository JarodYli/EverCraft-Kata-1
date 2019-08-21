import 'Character.dart';
import 'package:evercraft/src/utils/Alignment.dart';
import 'package:evercraft/src/utils/Combat.dart';
import 'package:evercraft/src/utils/AttackResults.dart';
import 'package:evercraft/src/utils/AbilityScore.dart';
import 'package:evercraft/src/utils/Ability.dart';

import 'dart:math';

class Monk extends Character {

  Monk () {

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
  }

  int GetArmorClassForDefense(){
    var ac = baseArmorClass + GetAbilityModifier(Ability.Dexterity) + max(0, GetAbilityModifier(Ability.Wisdom));
    return ac;
  }

  void Attack(Character defender, int r, int attackModifier){
    AttackResult attackSuccess = Combat.Attack(this, r, attackModifier);
    if(attackSuccess == AttackResult.Hit){
      int damageDealt = max(3, attackPower + (abilities[Ability.Strength].modifier));
      defender.TakeDamage(damageDealt);

      AddExperience(10);
    } else if (attackSuccess == AttackResult.CriticalHit){
      int damageDealt = max(1, attackPower + (abilities[Ability.Strength].modifier * 2));
      defender.TakeDamage(damageDealt);
      AddExperience(10);
    }
  }
}