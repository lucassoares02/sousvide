import 'package:flutter/material.dart';
import 'package:sous/main_controller.dart';
import 'package:sous/main_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sous Vide',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Página inicial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MainController _mainController = MainController(MainRepository());
  final ipController = TextEditingController();
  var setBomb = false;

  @override
  void initState() {
    _mainController.getSensor(ipController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: _mainController.sensorNotifier,
              builder: ((context, value, child) {
                return Column(
                  children: [
                    Text(
                      '${_mainController.sensor}ºC',
                      style: const TextStyle(color: Colors.grey, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${_mainController.sensor2}ºC',
                      style: const TextStyle(color: Colors.grey, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                _mainController.getSensor(ipController.text);
              },
              child: const Text('Temperatura'),
            ),
            ElevatedButton(
              onPressed: () {
                if (setBomb) {
                  _mainController.setOff(ipController.text);
                } else {
                  _mainController.setOn(ipController.text);
                }
                setState(() {
                  setBomb = !setBomb;
                });
              },
              child: Text(setBomb ? 'Desligar' : 'Ligar'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: TextFormField(
                controller: ipController,
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ),
      ),
    );
  }
}
