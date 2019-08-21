import 'WeaponType.dart';
import 'WeaponDamage.dart';

class Weapon {
  WeaponDamage _wd;
  WeaponType _wt;
  int _am = 0;

  WeaponDamage get damage {
    return _wd;
  }

  set damage (WeaponDamage wd) {
    _wd = wd;
  }

  WeaponType get type {
    return _wt;
  }

  set type (WeaponType wt) {
    _wt = wt;
  }

  int get modifier {
    return _am;
  }

  set modifier (int am) {
    _am = am;
  }

  Weapon (WeaponType wt, WeaponDamage wd, int am){
    _wd = wd;
    _wt = wt;
    _am = am;
  }
}