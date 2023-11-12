import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/scene_page.dart';
import '../pages/home_page.dart';

const routeHome = (name: 'home', path: '/');
const routeScene = (name: 'sceneItem', path: '/scene/item');

Map<String, String> getRouterQueryParameters(GoRouterState state) {
  final url = Uri.parse(state.uri.toString());
  return url.queryParameters;
}

void printState(GoRouterState state, [String? key]) {
  print(
    'key: $key\n'
    'name:${state.name}\n'
    'uri:${state.uri}\n'
    'path:${state.path}\n'
    'fullPath:${state.fullPath}\n'
    'pathParameters:${state.pathParameters}\n'
    'extra:${state.extra}\n'
  );
}

final GoRouter routerConfig = GoRouter(
  initialLocation: routeHome.path,
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
        final queryParameters = getRouterQueryParameters(state);
        return ScenePage(sceneId: queryParameters['sceneId']!);
      },
    )
  ],
);
