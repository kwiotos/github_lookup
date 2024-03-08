import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/repo_details_page.dart';

class RepoDetailsRoute extends GoRouteData {
  final String owner;
  final String repo;

  const RepoDetailsRoute(this.owner, this.repo);

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      RepoDetailsPage(owner, repo);
}
