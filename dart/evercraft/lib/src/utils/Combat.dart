import 'package:evercraft/src/models/Character.dart';
import 'AttackResults.dart';
import 'package:evercraft/src/utils/Race.dart';
import 'package:evercraft/src/utils/WeaponType.dart';

class Combat {

  static AttackResult Attack (Character c, int r, int m){

    var rm = r + m;
    var critical = 20;

    if(c.race == Race.Elf){
      critical = 19;
    }

    if(r >= critical){
      return AttackResult.CriticalHit;
    }

    if(( rm  >= c.GetArmorClassForDefense())){
      return AttackResult.Hit;
    } else {
      return AttackResult.Miss;
    }
  }

  static int PreAttack (Character attacker, Character defender, int modifier){
    if(attacker.race == Race.Dwarf && defender.race == Race.Orc){
      modifier = 2;
    }

    if(attacker.weapon[0].type == WeaponType.Longsword && (attacker.race == Race.Elf || defender.race == Race.Orc)){
      modifier = 2;
    }

    if(attacker.weapon[0].type == WeaponType.Longsword && (attacker.race == Race.Elf && defender.race == Race.Orc)){
      modifier = 5;
    }

    return modifier;
  }

  static int PreDefend (Character attacker, Character defender, int ac){
    if(attacker.race == Race.Orc && defender.race == Race.Elf){
      ac += 2;
    }
    if(attacker.race == Race.Halfling && defender.race != Race.Halfling){
      ac += 2;
    }

    if(attacker.weapon[0].type == WeaponType.Longsword && (attacker.race == Race.Elf || defender.race == Race.Orc)){
      ac = 2;
    }

    if(attacker.weapon[0].type == WeaponType.Longsword && (attacker.race == Race.Elf && defender.race == Race.Orc)){
      ac = 5;
    }
    return ac;
  }

  static int PreDamage (Character attacker, Character defender, int damage){
    if(attacker.race == Race.Dwarf && defender.race == Race.Orc){
      damage += 2;
    }
    return damage;
  }
}