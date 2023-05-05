import 'dart:async';

import 'package:flutter/material.dart';

import 'main_controller.dart';
import 'main_repository.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.recipe, required this.ip});

  final List recipe;
  final String ip;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final MainController mainController = MainController(MainRepository());
  bool visibleTimer = false;
  String temp = '';
  bool ligado = false;

  controllerReceipt() async {
    print("CONTROLLER RECEIPT");
    final temperature = await mainController.getSensor1(widget.ip);
    print('Temperatura: $temperature');
    setState(() {
      temp = temperature;
    });
    print(temperature);
    print(widget.recipe[3]);
    if (double.parse(temperature) < double.parse(widget.recipe[3])) {
      print('PRIMEIRO ELSE');
      setState(() {
        ligado = true;
      });
      final resp = await mainController.setOn(widget.ip);
    } else {
      print('SEGUNDO ELSE');
      setState(() {
        ligado = false;
      });
      await mainController.setOff(widget.ip);
    }
  }

  temperaturaInicial() async {
    await mainController.setOff(widget.ip);
    final temperature = await mainController.getSensor1(widget.ip);
    print('Temperatura: $temperature');
    setState(() {
      temp = temperature;
    });
  }

  void setInterval(time) {
    print('CONTROLLER TIME');
    Duration periodic = Duration(seconds: time);
    Timer.periodic(periodic, (intervalTime) {
      controllerReceipt();
    });
  }

  @override
  void initState() {
    temperaturaInicial();
    super.initState();
  }

  controllerPrepararSous() {
    setInterval(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.recipe[1]}'),
                const SizedBox(height: 20),
                Text('Tempo Preparo: ${(widget.recipe[2] / 60).toInt()} minutos'),
                const SizedBox(height: 20),
                Text('Temperatura: ${(widget.recipe[3])}'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    visibleTimer
                        ? TweenAnimationBuilder<Duration>(
                            duration: Duration(minutes: ((widget.recipe[2]) / 60).toInt()),
                            tween: Tween(begin: Duration(minutes: ((widget.recipe[2]) / 60).toInt()), end: Duration.zero),
                            onEnd: () {
                              print('Timer ended');
                            },
                            builder: (BuildContext context, Duration value, Widget? child) {
                              final minutes = value.inMinutes;
                              final seconds = value.inSeconds % 60;
                              return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text('$minutes:$seconds',
                                      textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30)));
                            },
                          )
                        : Text('Tempo restante\n${((widget.recipe[2]) / 60).toInt()} min',
                            textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Temperatura Atual\n$temp', textAlign: TextAlign.center, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(color: ligado ? Colors.green : Colors.red),
                      child: Text(
                        'Rele',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            visibleTimer = true;
                          });
                        },
                        child: const Text('Iniciar preparo')),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          controllerPrepararSous();
                        },
                        child: const Text('Checar panela')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
