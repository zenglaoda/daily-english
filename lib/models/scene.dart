import 'dart:math';
import 'package:flutter_lorem/flutter_lorem.dart';


// 句子
class Sentence {
  // 原文
  final String original;
  // 译文
  final String translated;

  const Sentence({
    required this.original,
    required this.translated
  });
}

// 情景
class Scene {
  final int id;
  final String title;
  final String description;
  final List<Sentence> sentences;

  const Scene({
    required this.id,
    required this.title,
    required this.sentences,
    required this.description
  });
}

// TODO: remove
Scene createScene([int? id]) {
  return Scene(
    id: id ?? Random().nextInt(10000),
    title: lorem(paragraphs: 1, words: 6),
    description: lorem(paragraphs: 5, words: 40),
    sentences: [
      const Sentence(original: 'These shoes are very comfortable.', translated: '这双鞋很舒适'),
      const Sentence(original: 'Name you price?', translated: '开个价?'),
      const Sentence(original: 'What\'s the price of this pair of shoes?', translated: '这双鞋多少钱?'),
    ],
  );
}

Future<List<Scene>> getScenes() async {
  List<Scene> list = [];
  for (int i = 0; i < 20; i++) {
    list.add(createScene());
  }
  return list;
}

Future<Scene> getScene(int id) async {
  await Future.delayed(const Duration(seconds: 3));
  return createScene(id);
}