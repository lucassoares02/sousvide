import 'package:flutter/material.dart';
import 'details.dart';
import 'main_controller.dart';
import 'main_repository.dart';

class ListRecipes extends StatefulWidget {
  const ListRecipes({super.key, required this.ip});

  final String ip;

  @override
  State<ListRecipes> createState() => _ListRecipesState();
}

class _ListRecipesState extends State<ListRecipes> {
  final MainController _mainController = MainController(MainRepository());

  @override
  void initState() {
    _mainController.listRecepts(widget.ip);
    // _mainController.getSensor(ipController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: ValueListenableBuilder(
          valueListenable: _mainController.listNotifier,
          builder: ((context, value, child) {
            return ListView.builder(
              itemCount: _mainController.listAlimentos.length,
              itemBuilder: ((context, index) {
                final alimento = _mainController.listAlimentos[index];
                return ListTile(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(
                                recipe: alimento,
                                ip: widget.ip,
                              )),
                    );
                  }),
                  title: Text(
                    '${alimento[1]}',
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }),
            );
          })),
    );
  }
}
