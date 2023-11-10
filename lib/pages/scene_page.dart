import 'package:flutter/material.dart';

import '../models/scene.dart';
import '../router/index.dart';

class ScenePage extends StatefulWidget {
  final int sceneId;
  
  const ScenePage({ super.key, required this.sceneId });

  @override
  State<ScenePage> createState() => _ScenePageState();
}

class _ScenePageState extends State<ScenePage> {
  Scene? scene;
  Future<Scene>? futureScene;


  Future<void> getSceneItem() async {
    futureScene = getScene(widget.sceneId);
    final item = await futureScene;
    setState(() {
      scene = item;
    });
  }

  @override
  void initState() {
    super.initState();
    getSceneItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scene')),
      body: FutureBuilder(
        future: futureScene,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('数据加载失败'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return Center(
              child: Text(data.title),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator()
            );
          }
        },
      )
    );
  }
}
