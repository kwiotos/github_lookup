import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../repo_details/route/repo_details_route.dart';
import '../ui/repos_page.dart';

part 'repos_route.g.dart';

@TypedGoRoute<ReposRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<RepoDetailsRoute>(
      path: 'repo/:owner/:repo',
      routes: <TypedGoRoute<GoRouteData>>[],
    ),
  ],
)
class ReposRoute extends GoRouteData {
  const ReposRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => ReposPage();
}
