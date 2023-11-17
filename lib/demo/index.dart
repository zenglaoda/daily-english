

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/index.dart';
import './flex.dart';
import './constrains.dart';

// demo页面
List<GoRoute> demoRoutes = [
  GoRoute(
    path: '/demo',
    name: 'demo',
    builder: (context, state) => const DemoPage(),
    routes: [
      GoRoute(
        path: 'flex',
        name: 'flex',
        builder: (context, state) => const FlexPage(),
      ),
      GoRoute(
        path: 'constrains',
        name: 'constrains',
        builder: (context, state) => const ConstrainsPage(),
      ),
    ]
  ),
];

List<({String name, String path})> menus = [
  routeHome,
  routeRegister,
  routeSign,
  (name: 'flex', path: '/demo/flex'),
  (name: 'constrains', path: '/demo/constrains'),
];

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final body = ListView(
      children: menus.map((menu) => GestureDetector(
        child: ListTile(title: Text(menu.name),
        onTap: () {
          context.pushNamed(menu.name);
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
