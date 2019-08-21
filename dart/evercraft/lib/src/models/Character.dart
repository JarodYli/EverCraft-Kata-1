import 'package:evercraft/src/utils/Alignment.dart';
import 'package:evercraft/src/utils/Combat.dart';
import 'package:evercraft/src/utils/AttackResults.dart';
import 'package:evercraft/src/utils/AbilityScore.dart';
import 'package:evercraft/src/utils/Ability.dart';
import 'package:evercraft/src/utils/Race.dart';
import 'package:evercraft/src/utils/Weapon.dart';
import 'package:evercraft/src/utils/WeaponType.dart';
import 'package:evercraft/src/utils/WeaponDamage.dart';

import 'dart:math';

class Character {
  String name;
  Alignment alignment;
  int hitPoints;
  int baseArmorClass;
  int maxHitPoints;
  bool get getIsDead{
    return hitPoints <= 0;
  }

  int get getHitPoints{
    return hitPoints;
  }

  Map<Ability, AbilityScore> abilities;
  List<Weapon> weapon;

  int experience = 0;
  int attackPower = 1;

  int get getLevel {
    var _xp = experience/1000 + 1;
    return _xp.toInt();
  }

  set setAlignment(value) {
    if (alignment != value) {
      if (value == Alignment.Evil && race == Race.Halfling) {
        throw new Exception("Halfling Alignment can be anything other than Evil.");
      }
      if (value == Alignment.Good && this.runtimeType.toString() == "Rogue") {
        throw new Exception("Rogue Alignment can be anything other than Good.");
      }
      alignment = value;
    }
  }

  Race race;

  Character([Race r = Race.Human]){
    this.name;
    this.alignment = Alignment.Neutral;
    this.hitPoints = 5;
    this.baseArmorClass = 10;
    this.abilities = GenerateDefaultAbilities();
    this.race = r;
    maxHitPoints = max(1, this.hitPoints + GetAbilityModifier(Ability.Constitution));
  }

  void TakeDamage (int d){
    hitPoints -= d;
  }

  void Attack(Character defender, int r, int attackModifier){
    attackModifier += Combat.PreAttack(this, defender, attackModifier);
    int criticalModifier = 2;
    // if carrying weapon, use attack modifier of weapon
    if(weapon.length > 0){
      attackModifier += GetWeaponAttackModifier();
      attackPower += GetWeaponDamageModifier();
    }
    AttackResult attackSuccess = Combat.Attack(this, r, attackModifier);
    int damageDealt = 0;
    int damageModifier = 0;
    if(attackSuccess == AttackResult.Hit){
      damageModifier = abilities[Ability.Strength].modifier;
      if(weapon.length > 0) {
        damageModifier += GetWeaponDamageModifier();
      }
    } else if (attackSuccess == AttackResult.CriticalHit){
      if(weapon.length > 0){
        criticalModifier = 3;
      }
      damageModifier = abilities[Ability.Strength].modifier * criticalModifier;
    }

    damageDealt = max(1, attackPower + damageModifier);

    if(damageDealt > 0){
      damageDealt += Combat.PreDamage(this, defender, damageDealt);
      defender.TakeDamage(damageDealt);
      AddExperience(10);
    }
  }

  List<Weapon> Equip(WeaponType wt, int d, int dm, int am){
    List<Weapon> _list = new List<Weapon>();
    var _wd = new WeaponDamage(d, dm);
    var _weapon = new Weapon(wt, _wd, am);
    _list.add(_weapon);
    weapon = _list;
    return weapon;
  }

  List<Weapon> Unequip(){
    List<Weapon> _list = new List<Weapon>();
    weapon = _list;
    return weapon;
  }

  int GetAbilityScore(Ability a){
    var score = 10;
    // look thru map to get value
    return score;
  }

  int GetWeaponAttackModifier(){
    var m = 0;
    if(weapon.length > 0){
      m = weapon[0].modifier;
    }
    return m;
  }

  int GetWeaponDamageModifier(){
    var d = 0;
    if(weapon.length > 0) {
      d = weapon[0].damage.damage;
    }
    return d;
  }

  void SetWeaponAttackModifier(int _m){
    if(weapon.length > 0){
      weapon[0].modifier = _m;
    }
  }

  void SetWeaponDamageModifier(int _d){
    if(weapon.length > 0) {
      weapon[0].damage.damage = _d;
    }
  }

  int GetArmorClassForDefense(){
    var ac = baseArmorClass + GetAbilityModifier(Ability.Dexterity);
    switch(race){
      case Race.Orc:
        ac += 2;
      break;
    }
    return ac;
  }

  Map<Ability, AbilityScore> GenerateDefaultAbilities(){
    List<Ability> list = Ability.values;
    AbilityScore _as = AbilityScore();
    _as.score = 10;
    var modifier = _as.modifier;
    Map<Ability, AbilityScore> _abilities = new Map.fromIterable(list,
        key: (item) => item,
        value: (item) => _as);
    abilities = _abilities;
    return _abilities;
  }

  void SetAbilityScore(Ability a, int s){
    // set the score for the abilty
    abilities[a].score = s;
  }

  int GetAbilityModifier(Ability a){
    var modifier = abilities[a].modifier;
    switch(race){
      case Race.Orc:
        if (a == Ability.Strength) {
          modifier += 2;
        } else if (a == Ability.Intelligence || a == Ability.Wisdom || a == Ability.Charisma) {
          modifier -= 1;
        }
        break;
      case Race.Dwarf:
        if (a == Ability.Constitution) {
          modifier += 1;
        } else if (a == Ability.Charisma) {
          modifier -= 1;
        }
        break;
      case Race.Elf:
      if (a == Ability.Constitution) {
        modifier -= 1;
      } else if (a == Ability.Dexterity) {
        modifier += 1;
      }
      break;
      case Race.Halfling:
        if (a == Ability.Strength) {
          modifier -= 1;
        } else if (a == Ability.Dexterity) {
          modifier += 1;
        }
        break;
    }
    return modifier;
  }

  void AddExperience(int xp){
    int previousLevel = getLevel;
    this.experience = this.experience + xp;
    int levelsGained = (getLevel - previousLevel);
    int modifier = GetAbilityModifier(Ability.Constitution);
    switch(race){
      case Race.Dwarf:
        if (modifier > 0) {
          modifier *= 2;
        }
        break;
    }
    hitPoints += levelsGained * (5 + modifier);

    double attackPowerGain = levelsGained / 2;
    if (getLevel % 2 == 0 && levelsGained % 2 == 1) {
      attackPowerGain = attackPowerGain + 1; // If the new level is even, and the number of levels gained is odd, then we gain (x/2 + 1) levels
    }
    attackPower += attackPowerGain.round();
  }
}