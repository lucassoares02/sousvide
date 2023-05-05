import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sous/alimentos_model.dart';

class MainRepository {
  Future getDataSensor(String ip) async {
    try {
      var response = await http.get(Uri.parse('http://${ip}:5000/sensor'));
      return response.body;
    } catch (exception) {
      rethrow;
    }
  }

  Future getDataSensor2(String ip) async {
    try {
      var response = await http.get(Uri.parse('http://${ip}:5000/sensor2'));
      return response.body;
    } catch (exception) {
      rethrow;
    }
  }

  Future setReleOn(String ip) async {
    try {
      var response = await http.get(Uri.parse('http://${ip}:5000/bombon'));
      return response.body;
    } catch (exception) {
      rethrow;
    }
  }

  Future setReleOff(String ip) async {
    try {
      var response = await http.get(Uri.parse('http://${ip}:5000/bomboff'));
      return response.body;
    } catch (exception) {
      rethrow;
    }
  }

  Future getListReceipts(String ip) async {
    try {
      final response = await http.get(Uri.parse('http://${ip}:5000/getalimentos'));
      return response.body;
    } catch (exception) {
      print("Exception ${exception}");
      rethrow;
    }
  }

  // Future getListReceipts1(String ip) async {
  //   print('Passando por aqui');
  //   try {
  //     final List<Alimento> listAlimentos = [];
  //     listAlimentos.add(Alimento(id: 1, description: 'Brócolis', time: 1200, temperature: 82.5, weight: 1));
  //     listAlimentos.add(Alimento(id: 2, description: 'Picanha', time: 12000, temperature: 52.5, weight: 1));
  //     listAlimentos.add(Alimento(id: 3, description: 'Costela', time: 120000, temperature: 60.5, weight: 1));
  //     return listAlimentos;
  //   } catch (exception) {
  //     rethrow;
  //   }
  // }
}
