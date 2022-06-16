// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/appColors.dart';

//Controller of an enemy data
class CharacterController extends GetxController {
  //Enemy data
  TextEditingController _name = TextEditingController();
  TextEditingController get name => _name;

  TextEditingController _artifact = TextEditingController();
  TextEditingController get artifact => _artifact;

  RxString _type = "None".obs;
  RxString get type => _type;

  TextEditingController _cr = TextEditingController();
  TextEditingController get cr => _cr;

  TextEditingController _crPush = TextEditingController();
  TextEditingController get crPush => _crPush;

  TextEditingController _crDepush = TextEditingController();
  TextEditingController get crDepush => _crDepush;

  RxInt _realSpeed = 0.obs;
  RxInt get realSpeed => _realSpeed;

  RxInt _hp = 10000.obs;
  RxInt get hp => _hp;

  RxBool _isHpEnabled = true.obs;
  RxBool get isHpEnabled => _isHpEnabled;

  RxBool _hasEnemyOutspeed = false.obs;
  RxBool get hasEnemyOutspeed => _hasEnemyOutspeed;

  Color colorHasEnemyOutsped = AppColors.light_grey;
  Icon iconHasEnemyOutsped = Icon(
    Icons.highlight_remove_rounded,
    color: AppColors.light_grey,
  );

  RxBool _hasImmunity = false.obs;
  RxBool get hasImmunity => _hasImmunity;

  Color colorHasImmunityBox = AppColors.darker;
  Color colorHasImmunityText = AppColors.light_grey;

  RxString _set = "None".obs;
  RxString get set => _set;

  TextEditingController _additionalInfos = TextEditingController();
  TextEditingController get additionalInfos => _additionalInfos;

  //Infos preview shown on the card
  String cardName = "";
  String cardInfos = "10K | ?";

  //Change enemy has outspeed status
  void updateEnemyHasOutsped() {
    if (hasEnemyOutspeed.value) {
      hasEnemyOutspeed.value = false;
      colorHasEnemyOutsped = AppColors.light_grey;
      iconHasEnemyOutsped = Icon(
        Icons.highlight_remove_rounded,
        color: colorHasEnemyOutsped,
      );
    } else {
      hasEnemyOutspeed.value = true;
      colorHasEnemyOutsped = Colors.blue;
      iconHasEnemyOutsped = Icon(
        Icons.done_rounded,
        color: colorHasEnemyOutsped,
      );
    }
  }

  //Change immunity status
  void updateImmunity() {
    if (hasImmunity.value) {
      hasImmunity.value = false;
      colorHasImmunityBox = AppColors.darker;
      colorHasImmunityText = AppColors.light_grey;
    } else {
      hasImmunity.value = true;
      colorHasImmunityBox = Colors.blue;
      colorHasImmunityText = Colors.black;
    }
  }

  //Switch the type of the enemy
  void switchType() {
    switch (_type.value) {
      case 'None':
        _type.value = 'Fire';
        break;
      case 'Fire':
        _type.value = 'Ice';
        break;
      case 'Ice':
        _type.value = 'Earth';
        break;
      case 'Earth':
        _type.value = 'Dark';
        break;
      case 'Dark':
        _type.value = 'Light';
        break;

      default:
        _type.value = 'None';
        break;
    }
  }
}
