import 'WeaponType.dart';

class WeaponDamage {
  int _damage = 5;
  int _modifier = 0;

  int get damage {
    return _damage;
  }

  set damage (int value) {
    _damage = value;
  }

  int get modifier {
    return _modifier;
  }

  set modifier (int value) {
    _modifier = value;
  }


  WeaponDamage (int d, int m){
    _damage = d;
    _modifier = m;
  }
}