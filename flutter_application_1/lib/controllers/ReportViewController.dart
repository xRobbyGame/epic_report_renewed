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
}
