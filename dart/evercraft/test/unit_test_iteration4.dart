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
import 'package:evercraft/src/utils/WeaponType.dart';
import 'package:evercraft/src/utils/WeaponDamage.dart';

void main() {
  test('Character can have one weapon', () {
    var c = new Character();
    var w = WeaponType.Longsword;
    c.Equip(w, 5, 0, 0);
    var d = c.weapon.length;
    expect(d, 1);
  });

  test('Character can equip a longsword that does 5 damage', () {
    var c = new Character();
    var w = WeaponType.Longsword;
    c.Equip(w, 5, 0, 0);
    var d = c.weapon.length;
    expect(c.weapon[0].type, WeaponType.Longsword);
    expect(c.GetWeaponDamageModifier(), 5);
  });

  test('Rogue can equip a waraxe that does 6 damage, 2 attack, 2 damage - hit', () {
    var c = new Rogue();
    var d = new Character();
    var w = WeaponType.WarAxe;
    c.Equip(w, 6, 2, 2);

    c.Attack(d, 12, 0);
    expect(d.hitPoints, -8);

  });

  test('Rogue can equip a waraxe that does 6 damage, 2 attack, 2 damage - critical hit', () {
    var c = new Rogue();
    var d = new Character();
    var w = WeaponType.WarAxe;
    c.Equip(w, 6, 2, 2);

    c.Attack(d, 20, 0);
    expect(d.hitPoints, -23);

  });

  test('As an elf I want to be able to wield a elven longsword that so I can stick it to that orc with the waraxe', () {
    var c = new Character(Race.Elf);
    c.Equip(WeaponType.Longsword, 5, 1, 1);

    var d = new Character(Race.Orc);
    d.Equip(WeaponType.WarAxe, 6, 2, 2);

    var attackModifier = Combat.PreAttack(c, d, 0);
    c.SetWeaponAttackModifier(attackModifier);

    var damageModifier = Combat.PreDamage(c, d, 0);
    c.SetWeaponDamageModifier(damageModifier);

    c.Attack(d, 12, 0);
    expect(d.hitPoints, -5);

  });

}