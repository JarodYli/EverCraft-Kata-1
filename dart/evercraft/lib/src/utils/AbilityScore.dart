import 'Ability.dart';

class AbilityScore {
  int _score = 10;
  int _modifier;

  int get score {
    return _score;
  }

  set score (int value) {

    if (value < 1) {
      //throw new ArgumentException("Minimum Ability Score is 1");
    }
    if (value > 20) {
      //throw new ArgumentException("Maximum Ability Score is 20");

    }
    _score = value;
  }

  int get modifier {
    switch (_score)
    {
      case 1:
        _modifier = -5;
        break;
      case 2:
      case 3:
        _modifier = -4;
        break;
      case 4:
      case 5:
        _modifier = -3;
        break;
      case 6:
      case 7:
        _modifier = -2;
        break;
      case 8:
      case 9:
        _modifier = -1;
        break;
      case 10:
      case 11:
        _modifier = 0;
        break;
      case 12:
      case 13:
        _modifier = 1;
        break;
      case 14:
      case 15:
        _modifier = 2;
        break;
      case 16:
      case 17:
        _modifier = 3;
        break;
      case 18:
      case 19:
        _modifier = 4;
        break;
      case 20:
        _modifier = 5;
        break;
      default:
        //throw new InvalidOperationException("AbilityScore is outside legal range 1-20");
        break;
    }
    return _modifier;
  }

  AbilityScore (){

  }
}