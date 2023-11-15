import 'package:flutter/material.dart';

class FlexPage extends StatelessWidget {
  const FlexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('flex')),
      body:
          Container(
            color: Colors.red[100],
            alignment: Alignment.topLeft,
            child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: const Text('Paragraphs'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.blue[300],
                    )
                  ),
                ]
              ),
          )
    );
  }
}