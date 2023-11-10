import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

import '../pages/scene_page.dart';
import '../pages/home_page.dart';

const routeHomePage = '/';
const routeScenePage = '/scenes/:sceneId';

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
    'path:${state.path}\n'
    'fullPath:${state.fullPath}\n'
    'pathParameters:${state.pathParameters}\n'
    'extra:${state.extra}\n'
  );
}

final GoRouter routerConfig = GoRouter(
  initialLocation: routeHomePage,
  routes: <RouteBase>[
    GoRoute(
      path: routeHomePage,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'scenes/:sceneId',
          builder: (BuildContext context, GoRouterState state) {
            printState(state);
            return const ScenePage(sceneId: 1);
          },
        ),
      ],
    ),
  ],
);
