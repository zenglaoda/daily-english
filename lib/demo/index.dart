

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './flex.dart';
import './constrains.dart';

// demo页面
List<GoRoute> demoRoutes = [
  GoRoute(
    path: '/demo',
    name: 'demo',
    builder: (context, state) => const DemoPage(),
  ),
  GoRoute(
    path: '/demo/flex',
    name: 'flex',
    builder: (context, state) => const FlexPage(),
  ),
  GoRoute(
    path: '/demo/constrains',
    name: 'constrains',
    builder: (context, state) => const ConstrainsPage(),
  ),
];


class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final body = ListView(
      children: demoRoutes.map((route) => GestureDetector(
        child: ListTile(title: Text(route.name!),
        onTap: () {
          context.pushNamed(route.name!);
        },
      ))).toList()
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Demos'),
      ),
      body: body
    );
  }
}
