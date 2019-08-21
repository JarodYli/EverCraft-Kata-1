import 'package:test/test.dart';

import 'dart:math';

import 'package:evercraft/src/models/Character.dart';
import 'package:evercraft/src/models/Fighter.dart';
import 'package:evercraft/src/models/Rogue.dart';
import 'package:evercraft/src/models/Monk.dart';
import 'package:evercraft/src/models/Paladin.dart';
import 'package:evercraft/src/utils/Alignment.dart';
import 'package:evercraft/src/utils/AttackResults.dart';
import 'package:evercraft/src/utils/Combat.dart';
import 'package:evercraft/src/utils/Ability.dart';
import 'package:evercraft/src/utils/AbilityScore.dart';
import 'package:evercraft/src/utils/Race.dart';

void main() {
  test('Humans are the default Race', () {
    var c = new Character();

    expect(Race.Human, c.race);
  });

  test('Orc modifiers, strength', () {
    var c = new Character(Race.Orc);
    var s = c.GetAbilityModifier(Ability.Strength);
    expect(2, s);
  });

  test('Orc modifiers, intelligence', () {
    var c = new Character(Race.Orc);
    var s = c.GetAbilityModifier(Ability.Intelligence);
    expect(-1, s);
  });

  test('Orc modifiers, ArmorClass', () {
    var c = new Character(Race.Orc);
    var ac = c.GetArmorClassForDefense();
    expect(12, ac);
  });

  test('Dwarf modifiers, consitution', () {
    var c = new Character(Race.Dwarf);
    var s = c.GetAbilityModifier(Ability.Constitution);
    expect(1, s);
  });

  test('Dwarf modifiers, charisma', () {
    var c = new Character(Race.Dwarf);
    var s = c.GetAbilityModifier(Ability.Charisma);
    expect(-1, s);
  });

  test('Dwarf modifiers, consitution*2 per level gained', () {
    var c = new Character(Race.Dwarf);
    var levels = 2;
    c.AddExperience(levels * 1000);
    expect(19, c.hitPoints);
  });

  test('Dwarf modifiers, plus 2 to attack and damage vs Orcs', () {
    var c = new Character(Race.Dwarf);
    var d = new Character(Race.Orc);

    c.Attack(d, 12, 0);
    expect(1, d.hitPoints);
  });

  test('Elf modifiers, plus 2 when attacked by orcs', () {
    var a = new Character(Race.Orc);
    var d = new Character(Race.Elf);

    var ac = Combat.PreDefend(a, d, d.GetArmorClassForDefense());
    expect(13, ac);
  });

  test('Elf modifiers, adds 1 to critical range, not critical', () {
    var a = new Character(Race.Orc);
    var d = new Character(Race.Elf);

    AttackResult ar = Combat.Attack(d, 18, 0);
    expect(AttackResult.Hit, ar);
  });

  test('Elf modifiers, adds 1 to critical range, critical', () {
    var a = new Character(Race.Orc);
    var d = new Character(Race.Elf);

    AttackResult ar = Combat.Attack(d, 19, 0);
    expect(AttackResult.CriticalHit, ar);
  });

//  test ('Halfling cannot be evil', (){
//    var c = new Character(Race.Halfling);
//    c.setAlignment = Alignment.Neutral;
//    try {
//      // code that might throw an exception
//      c.setAlignment = Alignment.Evil;
//    }
//    on Exception {
//      // code for handling exception
//      throw new Exception("Halfling cannot be Evil");
//    }
//    expect(c.alignment, Alignment.Neutral);
//  });
}