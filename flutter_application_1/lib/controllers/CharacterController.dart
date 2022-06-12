// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class CharacterController extends GetxController {
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

  RxString _set = "None".obs;
  RxString get set => _set;

  RxBool _hasImmunity = false.obs;
  RxBool get hasImmunity => _hasImmunity;

  TextEditingController _additionalInfos = TextEditingController();
  TextEditingController get additionalInfos => _additionalInfos;

  String cardName = "";
  String cardInfos = "10K | ?";
}
