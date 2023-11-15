import 'package:flutter/material.dart';

class ConstrainsPage extends StatelessWidget {
  const ConstrainsPage({ super.key });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[200],
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 300),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.green[400],
              child: const Text('paragraph', style: TextStyle(fontSize: 18)),
            ),
            Expanded(child: 
              Container(
                color: Colors.blue[300],
                child: const SizedBox(height: 50, width: 50),
              )
            )
          ],
        ),
      )
    );
  }
}