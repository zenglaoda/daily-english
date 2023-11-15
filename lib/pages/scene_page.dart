import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../models/scene.dart';
import '../widgets/custom_snapshot_widget.dart';
import '../widgets/custom_show_modal_bottom_sheet.dart';

class ScenePage extends StatefulWidget {
  final String sceneId;
  
  const ScenePage({ super.key, required this.sceneId });

  @override
  State<ScenePage> createState() => _ScenePageState();
}

class _ScenePageState extends State<ScenePage> {
  Scene? scene;
  Future<Scene>? futureScene;
  List<SceneParagraph> paragraphs = [];
  // 一共分成多少个段落
  int paragraphTotal = 1;

  String get sceneId => widget.sceneId;

  int get sentenceTotal => scene == null ? 1: scene!.sentences.length;

  // 生成段落
  void sentences2paragraphs() {
    final sentences = scene!.sentences;
    final int sentencePerParagraph = (sentenceTotal / paragraphTotal).floor();
    final List<SceneParagraph> group = [];
    for (int i = 0; i < paragraphTotal; i++) {
      final endIndex = i == paragraphTotal - 1 ? sentences.length : (i + 1) * sentencePerParagraph;
      final paragraph = sentences.sublist(i * sentencePerParagraph,  endIndex);
      group.add(paragraph);
    }
    setState(() {
      paragraphs = group;
    });
  }

  void updateParagraphTotal(double value) {
    paragraphTotal = value.ceil();
    sentences2paragraphs();
  }

  // 阅读设置
  void showReadBottomSheet(BuildContext context) {
    customShowModalBottomSheet(
      context: context,
      title: '阅读设置',
      builder: (context) => Container(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Paragraphs:$paragraphTotal', 
              style: TextStyle(
                fontSize: 16, 
                color: Color(0xff000000)
              )
            ),
            Expanded(
              child: Slider(
                value: paragraphTotal.toDouble(),
                min: 1.0,
                max: math.max(1, sentenceTotal.toDouble()),
                divisions: math.max(1, sentenceTotal),
                onChanged: (double value) {
                  updateParagraphTotal(value);
                },
              ),
            )
          ]
        ),
      )
    );
  }

  Future<void> getSceneItem() async {
    futureScene = getScene(sceneId);
    final item = await futureScene!;
    scene = item;
    paragraphTotal = item.sentences.length;
    sentences2paragraphs();
  }

  @override
  void initState() {
    super.initState();
    getSceneItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scene $sceneId'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showReadBottomSheet(context);
            },
          )
        ]
      ),
      body: FutureBuilder<Scene>(
        future: futureScene,
        builder: (context, snapshot) {
          return CustomSnapshotWidget<Scene>(
            snapshot: snapshot,
            builder: (_, data) => SentenceListWidget(paragraphs: paragraphs, title: data.title)
          );
        },
      )
    );
  }
}


class SentenceListWidget extends StatelessWidget {
  final String title;
  final List<SceneParagraph> paragraphs;

  const SentenceListWidget({ 
    super.key,
    required this.paragraphs,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 18, bottom: 40, left: 4, right: 4),
      children: [
        Text(title, 
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff000000),
          )
        ),
        ...paragraphs.map((paragraph) => SentenceItemWidget(paragraph)).toList(),
      ]
    );
  }
}

class SentenceItemWidget extends StatelessWidget {
  final List<Sentence> paragraph;

  const SentenceItemWidget(this.paragraph, { super.key });

  @override
  Widget build(BuildContext context) {
    final original = paragraph.fold('', (previousValue, element) => '$previousValue${element.original}  ');
    final translated = paragraph.fold('', (previousValue, element) => '$previousValue${element.translated}  ');

    return Container(
      padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(original, 
            style: const TextStyle(
              color: Color(0xff000000),
              fontSize: 20
            )
          ),
          Container(
            margin: const EdgeInsets.only(top: 2),
            child: Text(translated,
              style: const TextStyle(
                color: Color(0xff333333),
                fontSize: 16
              )
            ),
          )
        ]
      )
    );
  }
}

