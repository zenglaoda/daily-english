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
  SceneParagraphs paragraphs = [];
  // 一共分成多少个段落
  int paragraphTotal = 1;

  String get sceneId => widget.sceneId;

  int get sentenceTotal => scene == null ? 1: scene!.sentences.length;

  void Function(VoidCallback fn)? readBottomSheetSetState;

  // 生成段落
  void sentences2paragraphs() {
    final int total = paragraphTotal;
    final List<Sentence> sentences = scene!.sentences;
    final int sentencePerParagraph = (sentenceTotal / total).floor();
    final SceneParagraphs group = [];
    for (int i = 0; i < total; i++) {
      final endIndex = i == total - 1 ? sentences.length : (i + 1) * sentencePerParagraph;
      final paragraph = sentences.sublist(i * sentencePerParagraph,  endIndex);
      group.add(paragraph);
    }
    setState(() {
      paragraphs = group;
    });
  }

  // 更新段落总数
  void updateReadBottomSheet() {
    // TODO: sheet 已经关闭时不能在调用该方法
    if (readBottomSheetSetState != null) {
      readBottomSheetSetState!((){});
    }
  }

  // 阅读设置
  void showReadBottomSheet() {
    customShowModalBottomSheet(
      context: context,
      title: '阅读设置',
      builder: (_, setState) {
        readBottomSheetSetState = setState;
        return Container(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Paragraphs: $paragraphTotal', 
                style: const TextStyle(
                  fontSize: 16, 
                  color: Color(0xff000000)
                )
              ),
              Expanded(
                child: Slider(
                  value: paragraphTotal.toDouble(),
                  min: 1.0,
                  max: math.max(1, sentenceTotal.toDouble()),
                  divisions: math.max(1, sentenceTotal - 1),
                  onChanged: (double value) {
                    setState(() {
                      paragraphTotal = value.round();
                      sentences2paragraphs();
                    });
                  },
                ),
              )
            ]
          ),
        );
      }
    );
  }

  // 获取场景详情
  Future<void> getSceneItem() async {
    futureScene = getScene(sceneId);
    final item = await futureScene!;
    scene = item;
    paragraphTotal = item.sentences.length;
    sentences2paragraphs();
    updateReadBottomSheet();
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
              showReadBottomSheet();
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
              height: 1.3,
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

