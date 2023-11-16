import 'package:flutter/material.dart';

class SignPage extends StatefulWidget {

  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();

}

class _SignPageState extends State<SignPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('标题'),
      ),
       body: const SizedBox.expand()
    );
  }
}