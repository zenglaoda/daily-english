import 'package:flutter/material.dart';

import '../models/scene.dart' as scene_model;
import '../router/route_param.dart';

class ScenePage extends StatefulWidget {
  
  const ScenePage({ super.key });

  @override
  State<ScenePage> createState() => _ScenePageState();
}

class _ScenePageState extends State<ScenePage> {
  int? sceneId;
  scene_model.Scene? scene;
  Future<scene_model.Scene>? futureScene;


  Future<void> getScene() async {
    futureScene = scene_model.getScene(sceneId!);
    final item = await futureScene;
    setState(() {
      scene = item;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ScenePageArguments;
    if (args.sceneId != sceneId) {
      sceneId = args.sceneId;
      getScene();
    }

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
