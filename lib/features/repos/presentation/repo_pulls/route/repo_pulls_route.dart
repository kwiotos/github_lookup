import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/repo_pulls_page.dart';

class RepoPullsRoute extends GoRouteData {
  final String owner;
  final String repo;

  const RepoPullsRoute(this.owner, this.repo);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      RepoPullsPage(owner, repo);
}
