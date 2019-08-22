import 'package:test/test.dart';

import 'package:evercraft/jarodSrc/models/character.dart';

import 'dart:math';

void main() {
  test("character name", () {
    // create a character
    Character c = new Character();

    // give it a name
    c.name = "Jarod";

    // test to see if the name exists and is equal to the name provided
    expect(c.name, "Jarod");

  });

  test("alignment", () {
    Character c = new Character();

    // give character an alignment; neutral is given by default
    c.alignment = "neutral";

    // test to see if alignment exists : good, evil, or neutral
    expect(c.alignment, "neutral");
  });

  test("armor", (){
    Character c = new Character();
    // set armor by defualt to ten
    c.armor = 10;

    // test to see if armor exists and is equal to ten
    print("armor grade:");
    print(c.armor);
    expect(c.armor, 10);
  });

  test("Hit Points", (){
    Character c = new Character();

    // set hit points by defualt to 5
    c.hitPoints = 5;

    // check value of hit points
    print("Hit Points:");
    print(c.hitPoints);
    expect(c.hitPoints, 5);
  });

  test("Attack", (){
    Character c = new Character();

    // set Attack to a function that generates a random number 1 - 20


    // Check to see if Attack is greater than 0 and less than 20
  });

  test("Two Charactrs Exist", (){
    // check to see if two characters exist; both with a name; alignmen; armor; hit points; and attack
  });

  test("Armor Vs Attack", (){
    // Player can execute attack against other player
    // Attackers attack is compared to defenders armor
    // If greater than armor's grade then adjust players hit points to the difference of the attack
  });

}
