import 'Character.dart';
import 'package:evercraft/src/utils/Alignment.dart';
import 'package:evercraft/src/utils/Combat.dart';
import 'package:evercraft/src/utils/AttackResults.dart';
import 'package:evercraft/src/utils/AbilityScore.dart';
import 'package:evercraft/src/utils/Ability.dart';

import 'dart:math';

class Fighter extends Character {

  Fighter () {

    this.name;
    this.alignment = Alignment.Neutral;
    this.hitPoints = 5;
    this.baseArmorClass = 10;
    this.abilities = GenerateDefaultAbilities();

    maxHitPoints = max(1, 10 + GetAbilityModifier(Ability.Constitution));
    hitPoints = maxHitPoints;
  }

  void AddExperience(int xp){
    int previousLevel = getLevel;
    this.experience = this.experience + xp;
    int levelsGained = (getLevel - previousLevel);
    hitPoints += levelsGained * (10 + GetAbilityModifier(Ability.Constitution));

    int attackPowerGain = levelsGained;
    attackPower += attackPowerGain.round();
  }
}