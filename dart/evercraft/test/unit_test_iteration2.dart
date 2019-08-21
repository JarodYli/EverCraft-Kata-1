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

void main() {
  test('Test Fighter Gain AttackPower', () {
    var c = new Fighter();
    var levels = 2;
    var expectedAttackPowerGain = 2;

    var atk = c.attackPower;

    c.AddExperience(levels * 1000);

    expect(atk + expectedAttackPowerGain, c.attackPower);
  });

  test('Test Fighter Gain HitPoints', () {
    var c = new Fighter();

    var levels = 2;
    var expectedHitPointsGain = 20;

    var hitPointsPrior = c.hitPoints;
    var modifiedHitPoints = expectedHitPointsGain + c.GetAbilityModifier(Ability.Constitution) * levels;

    c.AddExperience(levels * 1000);

    expect(hitPointsPrior + modifiedHitPoints, c.hitPoints);

  });

  test('Test Rogue Critical Hit * 3', (){
    var c = new Rogue();
    var d = new Character();

    int hitPointsPrior = d.hitPoints;

    c.Attack(d, 20, 0);

    int hitPointDiff = hitPointsPrior - d.hitPoints;

    expect(c.attackPower * 3, hitPointDiff);
  });

  test('test rogue bypass dexterity', (){
    var c = new Rogue();
    var d = new Character();
    d.SetAbilityScore(Ability.Dexterity, 20);

    int hitPointsPrior = d.hitPoints;

    c.Attack(d, 11, 0);

    assert(hitPointsPrior > d.hitPoints);
  });

  test('rogue dexterity attack', (){
    var c = new Rogue();
    var d = new Character();
    c.SetAbilityScore(Ability.Dexterity, 20);

    // check for attack < 11
    // check damage dealt is increased by the modifier

    int hitPointsPrior = d.hitPoints;

    c.Attack(d, 9, 0);

    int hitPointsDiff = hitPointsPrior - d.hitPoints;

    expect(c.GetAbilityModifier(Ability.Dexterity) + 1, hitPointsDiff);
  });

//  test ('rogue cannot be good', (){
//    var c = new Rogue();
//    c.setAlignment = Alignment.Neutral;
//    try {
//      // code that might throw an exception
//      c.setAlignment = Alignment.Good;
//    }
//    on Exception {
//      // code for handling exception
//      throw new Exception("Rogue cannot be good");
//    }
//    expect(c.alignment, Alignment.Neutral);
//  });

  test ('monk hit points per level 6 instead of 5', (){
    var c = new Monk();

    var levels = 2;
    var expectedHitPointsGain = 12;

    c.AddExperience(levels * 1000);

    expect(17, c.hitPoints);
  });

  test ('monk does 3 pts of damage', (){
    var c = new Monk();
    var d = new Character();
    c.Attack(d, 12, 0);

    expect(2, d.hitPoints);
  });

  test ('monk does 3 pts of damage, critical hit', (){
    var c = new Monk();
    var d = new Character();
    c.Attack(d, 20, 0);

    expect(2, d.hitPoints);
  });

  test ('add wisdom modifier to monk armor class high', (){
    var c = new Monk();
    // add wisdom modifier, if it is positive to monk armor class
    // in addition to dexterity modifier
    c.SetAbilityScore(Ability.Wisdom, 20);

    var v = c.GetAbilityModifier(Ability.Dexterity) + max(0, c.GetAbilityModifier(Ability.Wisdom)) + c.baseArmorClass;
    expect(v, c.GetArmorClassForDefense());
  });

  test ('add wisdom modifier to monk armor class low', (){
    var c = new Monk();
    // add wisdom modifier, if it is positive to monk armor class
    // in addition to dexterity modifier
    c.SetAbilityScore(Ability.Wisdom, 1);

    var v = c.GetAbilityModifier(Ability.Dexterity) + max(0, c.GetAbilityModifier(Ability.Wisdom)) + c.baseArmorClass;
    expect(v, c.GetArmorClassForDefense());
  });

  test ('paladin check hp level 8, not 5', (){
    var c = new Paladin();
    var levels = 2;
    var expectedHitPointsGain = 16 + c.hitPoints;

    c.AddExperience(levels * 1000);
    expect(expectedHitPointsGain, c.hitPoints);
  });

  test ('paladin attack evil gets +2 attack modifier', (){
    var c = new Paladin();
    var d = new Character();
    d.alignment = Alignment.Evil;
    var expectedDefenderHP = 0;
    c.Attack(d, 12, 0);
    expect(expectedDefenderHP, d.hitPoints);
  });

  test ('paladin attack evil gets +2 attack modifier, critical is 3 times', (){
    var c = new Paladin();
    var d = new Character();
    d.alignment = Alignment.Evil;
    var expectedDefenderHP = -10;
    c.Attack(d, 20, 0);
    expect(expectedDefenderHP, d.hitPoints);
  });

  test ('paladin increase 1 attackPower every level', (){
    var c = new Paladin();
    var levels = 2;
    var expectedAttackPowerGain = levels + c.attackPower;

    c.AddExperience(levels * 1000);
    expect(expectedAttackPowerGain, c.attackPower);
  });

  //test ('paladin must be good', (){
//    var c = new Paladin();
//    c.setAlignment = Alignment.Good;
//    try {
//      c.setAlignment = Alignment.Good;
//    }
//    on Exception {
//      // code for handling exception
//      throw new Exception("Paladin must be good");
//    }
//    expect(c.alignment, Alignment.Good);
//  });



}