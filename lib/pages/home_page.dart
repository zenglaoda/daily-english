import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/index.dart';
import '../models/scene.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Scene> scenes = [];

  Future<void> getSceneList() async {
    final list = await getScenes();
    setState(() {
      scenes = list;
    });
  }

  void onTap(Scene scene) {
    context.push(routeScenePage, extra: scene.id);
  }

  @override
  void initState() {
    super.initState();
    getSceneList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Scenes'),
      ),
      body: ListView(children: scenes.map((scene) {
        return GestureDetector(
          onTap: () => onTap(scene),
          child: ListItem(title: scene.title),
        );
      }).toList())
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
          border: Border(bottom: BorderSide(color: Color(0xFFCCCCCC))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
            Expanded(
              child: Text(title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0XFF333333),
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                )),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Icon(Icons.arrow_forward_ios,color: Color(0xFF999999), size: 18))
          ]
        ));
  }
}
