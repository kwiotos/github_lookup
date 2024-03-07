import 'package:go_router/go_router.dart';

import '../../features/repos/presentation/repos/route/repos_route.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: $appRoutes,
);
