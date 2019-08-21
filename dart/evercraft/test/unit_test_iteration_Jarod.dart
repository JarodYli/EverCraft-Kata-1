import 'package:test/test.dart';

import 'package:evercraft/jarodSrc/models/Character.dart';

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
    // give character an alignment
    // test to see if alignment exists : good, evil, or neutral
  });

  test("armor", (){
    // set armor by defualt to ten
    // test to see if armor exists and is equal to ten
  });

  test("Hit Points", (){
    // set hit points by defualt to 5
    // check value of hit points
  });
}
