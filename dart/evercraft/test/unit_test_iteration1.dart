import 'package:test/test.dart';

import 'dart:math';

import 'package:evercraft/src/models/Character.dart';
import 'package:evercraft/src/utils/Alignment.dart';
import 'package:evercraft/src/utils/AttackResults.dart';
import 'package:evercraft/src/utils/Combat.dart';
import 'package:evercraft/src/utils/Ability.dart';
import 'package:evercraft/src/utils/AbilityScore.dart';

void main() {
  test('character name', () {
    Character c = new Character();
    c.name = "Justin";
    expect(c.name, "Justin");
  });

  test('character default alignment', () {
    Character c = new Character();

    expect(c.alignment, Alignment.Neutral);
  });

  test('character evil alignment', () {
    Character c = new Character();
    c.alignment = Alignment.Evil;
    expect(c.alignment, Alignment.Evil);
  });

  test('character good alignment', () {
    Character c = new Character();
    c.alignment = Alignment.Good;
    expect(c.alignment, Alignment.Good);
  });

  test('character neutral alignment', () {
    Character c = new Character();
    c.alignment = Alignment.Neutral;
    expect(c.alignment, Alignment.Neutral);
  });

  test('character neutral alignment', () {
    Character c = new Character();
    expect(c.hitPoints, 5);
    expect(c.baseArmorClass, 10);
  });

  test('character attack miss', () {
    Character c = new Character();
    var attackSuccess = Combat.Attack(c, 9, 0);
    expect(attackSuccess, AttackResult.Miss);
  });

  test('character attack hit', () {
    Character c = new Character();
    var attackSuccess = Combat.Attack(c, 11, 0);
    expect(attackSuccess, AttackResult.Hit);
  });

  test('character attack critical hit', () {
    Character c = new Character();
    var attackSuccess = Combat.Attack(c, 20, 0);
    expect(attackSuccess, AttackResult.CriticalHit);
  });

  test('character attack damage', () {
    Character c = new Character();
    c.TakeDamage(3);
    expect(c.hitPoints, 2);
  });

  test('character attack success with damage', () {
    Character attacker = new Character();
    Character defender = new Character();
    attacker.Attack(defender, 11, 0);
    expect(defender.hitPoints, 4);
  });

  test('character attack fail', () {
    Character attacker = new Character();
    Character defender = new Character();
    attacker.Attack(defender, 9, 0);
    expect(defender.hitPoints, 5);
  });

  test('character attack critial hit with damage', () {
    Character attacker = new Character();
    Character defender = new Character();
    attacker.Attack(defender, 20, 0);
    expect(defender.hitPoints, 3);
  });

  test('character is dead', () {
    Character attacker = new Character();
    Character defender = new Character();
    attacker.Attack(defender, 20, 0);
    attacker.Attack(defender, 20, 0);
    attacker.Attack(defender, 11, 0);
    expect(true, defender.getIsDead);
  });

  test('character is NOT dead', () {
    Character attacker = new Character();
    Character defender = new Character();
    expect(false, defender.getIsDead);
  });

  test('character is deader', () {
    Character attacker = new Character();
    Character defender = new Character();
    attacker.Attack(defender, 20, 0);
    attacker.Attack(defender, 20, 0);
    attacker.Attack(defender, 20, 0);
    attacker.Attack(defender, 20, 0);
    attacker.Attack(defender, 20, 0);
    attacker.Attack(defender, 20, 0);
    expect(true, defender.getIsDead);
  });

  test('character has ability score', () {
    Character c = new Character();
    //Strength, Dexterity, Constitution, Wisdom, Intelligence, Charisma
    expect(10, c.GetAbilityScore(Ability.Strength));
    expect(10, c.GetAbilityScore(Ability.Dexterity));
    expect(10, c.GetAbilityScore(Ability.Constitution));
    expect(10, c.GetAbilityScore(Ability.Wisdom));
    expect(10, c.GetAbilityScore(Ability.Intelligence));
    expect(10, c.GetAbilityScore(Ability.Charisma));
  });

  test('test ability modifier', () {
    AbilityScore _as = AbilityScore();
    _as.score = 1;
    expect(_as.modifier, -5);
  });

  test('Test Strength Modifier On Hit', (){
    var c = Character();
    var d = Character();
    var strength = 5;

    c.SetAbilityScore(Ability.Strength, strength);
    var strengthModifier = c.GetAbilityModifier(Ability.Strength);

    var hitPointsPrior = d.getHitPoints;

    var attackResults = 11 - strengthModifier;
    c.Attack(d, attackResults, 0);

    int diffHitPoints = hitPointsPrior - d.getHitPoints;

    expect(diffHitPoints, max(1, 1 + strengthModifier));
  });

  test("Dexterity Modifier On Attack", (){
    var c = new Character();
    var dexterity = 9;
    var roll = 11;
    var attackModifier = 2;
    var expectedAttackResult = AttackResult.Hit;
    c.SetAbilityScore(Ability.Dexterity, dexterity);
    var result = Combat.Attack(c, roll, attackModifier);
    expect(result, expectedAttackResult);
  });

  test("XP Gain On Attack", (){
    var attacker = new Character();
    var defender = new Character();
    var ap = 9;
    var attackModifier = 2;
    var expectedXpGain = 10;

    int startingExperience = attacker.experience;

    attacker.Attack(defender, ap, attackModifier);

    int xpGained = attacker.experience - startingExperience;
    expect(xpGained, expectedXpGain);

  });

  test("Hit Points Gained After Level", (){
    var c = new Character();

    var origHitPoints = c.hitPoints; // 5

    int expectedHitPointGain = 5 + c.GetAbilityModifier(Ability.Constitution); // 1

    c.AddExperience(1000); //

    var newHitPoints = c.hitPoints;

    var expectedActualHitPoints = origHitPoints + expectedHitPointGain;

    expect(expectedActualHitPoints, newHitPoints);
  });

  test("Attack Power Gained After Level Up", (){
    var c = new Character();
    var levels = 1;
    var expectedAttackPowerGain = 1;
    var origAttackPower = c.attackPower;

    c.AddExperience(levels * 1000);

    expect(origAttackPower + expectedAttackPowerGain, c.attackPower);
  });

}