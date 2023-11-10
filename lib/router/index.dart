import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

import '../pages/scene_page.dart';
import '../pages/home_page.dart';

const routeHome = (name: 'home', path: '/');
const routeScene = (name: 'sceneItem', path: '/scene/item');

void printState(GoRouterState state, [String? key]) {
  // this._configuration, {
  // required this.uri,
  // required this.matchedLocation,
  // this.name,
  // this.path,
  // required this.fullPath,
  // required this.pathParameters,
  // this.extra,
  // this.error,
  // required this.pageKey,
  print(
    'key: $key\n'
    'name:${state.name}\n'
    'uri:${state.uri}\n'
    'path:${state.path}\n'
    'fullPath:${state.fullPath}\n'
    'pathParameters:${state.pathParameters}\n'
    'queryParameters:${state.pathParameters}\n'
    'extra:${state.extra}\n'
  );
}

final GoRouter routerConfig = GoRouter(
  initialLocation: routeHome.name,
  routes: <RouteBase>[
    GoRoute(
      path: routeHome.path,
      name: routeHome.name,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: routeScene.path,
      name: routeScene.name,
      builder: (BuildContext context, GoRouterState state) {
        print('--------------------');
        printState(state);
        return const ScenePage(sceneId: 1);
      },
    )
  ],
);
