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
  final String id;
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

// 多个句子组成的段落
typedef SceneParagraph = List<Sentence>;

// TODO: remove
Scene createScene([String? id]) {
  return Scene(
    id: id ?? Random().nextInt(10000).toString(),
    title: lorem(paragraphs: 1, words: 6),
    description: lorem(paragraphs: 5, words: 40),
    sentences: [
      const Sentence(original: 'These shoes are very comfortable.', translated: '这双鞋很舒适'),
      const Sentence(original: 'Name you price?', translated: '开个价?'),
      const Sentence(original: 'What\'s the price of this pair of shoes?', translated: '这双鞋多少钱?'),
      const Sentence(
        original: 'You can create an object using a constructor. Constructor names can be either ClassName or ClassName.identifier. For example, the following code creates Point objects using the Point() and Point.fromJson() constructors:',
        translated: '您可以使用构造函数创建对象。构造函数名称可以是 ClassName ClassName.identifier 或 。例如，以下代码使用 Point() 和 Point.fromJson() 构造函数创建 Point 对象', 
      ),
      const Sentence(
        original: 'The following code has the same effect, but uses the optional new keyword before the constructor name:',
        translated: '以下代码具有相同的效果，但在构造函数名称之前使用 optional new 关键字：',
      ),
      const Sentence(
        original: 'Some classes provide constant constructors. To create a compile-time constant using a constant constructor, put the const keyword before the constructor name:',
        translated: '某些类提供常量构造函数。若要使用常量构造函数创建编译时常量，请将 const 关键字放在构造函数名称之前：',
      ),
    ],
  );
}

Future<List<Scene>> getScenes() {
  List<Scene> list = [];
  for (int i = 0; i < 20; i++) {
    list.add(createScene());
  }
  return Future.delayed(const Duration(seconds: 4) ,() => list);
}

Future<Scene> getScene(String id) async {
  await Future.delayed(const Duration(seconds: 3));
  return createScene(id);
}