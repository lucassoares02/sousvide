import 'package:flutter/material.dart';
import 'package:sous/list_recipes.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: TextFormField(
                controller: ipController,
                keyboardType: TextInputType.number,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // if (setBomb) {
                //   _mainController.setOff(ipController.text);
                // } else {
                //   _mainController.setOn(ipController.text);
                // }
                // setState(() {
                //   setBomb = !setBomb;
                // });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListRecipes(
                      ip: ipController.text,
                    ),
                  ),
                );
              },
              child: Text(setBomb ? 'Desligar' : 'Ligar'),
            ),
          ],
        ));
  }
}
