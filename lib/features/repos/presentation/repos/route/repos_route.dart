import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../repos_screen.dart';

part 'repos_route.g.dart';

@TypedGoRoute<ReposRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[],
)
class ReposRoute extends GoRouteData {
  const ReposRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ReposScreen();
}
