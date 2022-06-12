// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/TurnController.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class ReportViewController extends GetxController {
  RxList<TurnController> _turns =
      [new TurnController(), new TurnController()].obs;
  RxList<TurnController> get turns => _turns;

  TextEditingController _enemyName = TextEditingController();
  TextEditingController get enemyName => _enemyName;

  TextEditingController _speedFirstCharacter = TextEditingController();
  TextEditingController get speedFirstCharacter => _speedFirstCharacter;

  TextEditingController _crPush = TextEditingController();
  TextEditingController get crPush => _crPush;

  TextEditingController _crDepush = TextEditingController();
  TextEditingController get crDepush => _crDepush;

  int calculteRealSpeed() {
    int speed = 0;
    int crBonus = 0;
    if (crPush.value.text != "") {
      crBonus += int.parse(crPush.value.text);
    }
    if (crDepush.value.text != "") {
      crBonus -= int.parse(crPush.value.text);
    }
    if (crBonus != 0) {
      speed = int.parse(speedFirstCharacter.value.text) *
          -(crBonus.toDouble()) ~/
          100;
    } else {
      speed = int.parse(speedFirstCharacter.value.text);
    }

    return speed;
  }
}
