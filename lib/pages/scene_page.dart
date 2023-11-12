import 'package:flutter/material.dart';

import '../models/scene.dart';
import '../widgets/custom-snapshot-widget.dart';

class ScenePage extends StatefulWidget {
  final String sceneId;
  
  const ScenePage({ super.key, required this.sceneId });

  @override
  State<ScenePage> createState() => _ScenePageState();
}

class _ScenePageState extends State<ScenePage> {
  String? sceneId;
  Scene? scene;
  Future<Scene>? futureScene;


  Future<void> getSceneItem() async {
    futureScene = getScene(sceneId!);
    final item = await futureScene;
    setState(() {
      scene = item;
    });
  }

  @override
  void initState() {
    super.initState();
    sceneId = widget.sceneId;
    getSceneItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scene ${sceneId!}')
      ),
      body: FutureBuilder<Scene>(
        future: futureScene,
        builder: (context, snapshot) {
          return CustomSnapshotWidget(
            snapshot: snapshot,
            content: const Center(
              child: Text('aaaa')
            )
          );
        },
      )
    );
  }
}
