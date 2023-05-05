import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sous/alimentos_model.dart';
import 'package:sous/main_repository.dart';

class MainController extends ValueNotifier<MainState> {
  MainController(this._mainRepository) : super(MainState.start);
  String sensor = "0.0";
  String sensor2 = "0.0";
  List listAlimentos = [];
  final MainRepository _mainRepository;
  final ValueNotifier<MainState> listNotifier = ValueNotifier<MainState>(MainState.start);
  final ValueNotifier<MainState> sensorNotifier = ValueNotifier<MainState>(MainState.start);

  Future getSensor(String ip) async {
    sensorNotifier.value = MainState.loading;
    try {
      var response = await _mainRepository.getDataSensor(ip);
      var response2 = await _mainRepository.getDataSensor2(ip);

      var convertJson = jsonDecode(response);
      var convertJson2 = jsonDecode(response2);

      sensor = convertJson['celsius'].toStringAsFixed(1);
      sensor2 = convertJson2['celsius'].toStringAsFixed(1);
      sensorNotifier.value = MainState.success;
    } catch (e) {
      debugPrint('Error ==== $e');
      sensorNotifier.value = MainState.error;
    }
  }

  Future getSensor1(String ip) async {
    try {
      var response = await _mainRepository.getDataSensor(ip);

      var convertJson = jsonDecode(response);

      sensor = convertJson['celsius'].toStringAsFixed(1);

      return sensor;
    } catch (e) {
      debugPrint('Error ==== $e');
    }
  }

  Future setOn(String ip) async {
    try {
      String a = await _mainRepository.setReleOn(ip);
    } catch (e) {
      debugPrint('Error ==== $e');
      sensorNotifier.value = MainState.error;
    }
  }

  Future setOff(String ip) async {
    try {
      String a = await _mainRepository.setReleOff(ip);
    } catch (e) {
      debugPrint('Error ==== $e');
      sensorNotifier.value = MainState.error;
    }
  }

  Future listRecepts(String ip) async {
    listNotifier.value = MainState.start;
    try {
      final response = await _mainRepository.getListReceipts(ip);
      listAlimentos = jsonDecode(response);
      listNotifier.value = MainState.success;
    } catch (e) {
      print('Error: $e');
      sensorNotifier.value = MainState.error;
    }
  }
}

enum MainState { start, loading, success, error }
