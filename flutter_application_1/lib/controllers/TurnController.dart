// ignore_for_file: prefer_final_fields, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/CharacterController.dart';
import 'package:get/get.dart';

//Controller of a turn data
class TurnController extends GetxController {
  //Turn data
  RxList<CharacterController> _characters = [
    new CharacterController(),
    new CharacterController(),
    new CharacterController()
  ].obs;
  RxList<CharacterController> get characters => _characters;

  TextEditingController _speedFirstCharacter = TextEditingController();
  TextEditingController get speedFirstCharacter => _speedFirstCharacter;

  TextEditingController _crPush = TextEditingController();
  TextEditingController get crPush => _crPush;

  TextEditingController _crDepush = TextEditingController();
  TextEditingController get crDepush => _crDepush;

  Color yourSpeedColor = Colors.red;
  Icon yourSpeedIcon = const Icon(
    Icons.highlight_remove_rounded,
    color: Colors.red,
  );

  //Calculate real player speed with CR
  int calculteRealSpeed() {
    int speed = 0;
    int crBonus = 0;
    if (crPush.value.text.isNotEmpty) {
      crBonus -= int.parse(crPush.value.text);
    }
    if (crDepush.value.text.isNotEmpty) {
      crBonus += int.parse(crDepush.value.text);
    }
    if (crBonus != 0) {
      speed = (int.parse(speedFirstCharacter.value.text) -
              int.parse(speedFirstCharacter.value.text) *
                  (crBonus.toDouble()) /
                  100)
          .toInt();
    } else {
      speed = int.parse(speedFirstCharacter.value.text);
    }

    return speed;
  }
}
