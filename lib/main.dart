import 'package:flutter/material.dart';
import 'dart:async';

import './router/index.dart' as router;
import './router/route_param.dart';

import './models/scene.dart' as scene_model;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily English',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: router.routes,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<scene_model.Scene> scenes = [];

  Future<void> getScenes() async {
    final list = await scene_model.getScenes();
    setState(() {
      scenes = list;
    });
  }

  void onTap(scene_model.Scene scene) {
    Navigator.of(context).pushNamed(router.names.scene, arguments: ScenePageArguments(scene.id));
  }

  @override
  void initState() {
    super.initState();
    getScenes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Daily English'),
      ),
      body: ListView(
        children: scenes.map((scene) {
          return GestureDetector(
            onTap: () => onTap(scene),
            child: ListItem(title: scene.title),
          );
        }).toList()
      )
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;

  const ListItem({
    super.key,
    required this.title,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFCCCCCC))
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          Expanded(child: Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0XFF333333),
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              )
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: const Icon(Icons.arrow_forward_ios, color: Color(0xFF999999), size: 18)
          )
        ]
      )
    );
  }
}