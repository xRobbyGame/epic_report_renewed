// ignore_for_file: prefer_final_fields, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/CharacterController.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class TurnController extends GetxController {
  RxList<CharacterController> _characters = [
    new CharacterController(),
    new CharacterController(),
    new CharacterController()
  ].obs;
  RxList<CharacterController> get characters => _characters;
}
