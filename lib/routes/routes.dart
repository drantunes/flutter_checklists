import 'package:flutter_checklist/ui/checklists/checklists_screen.dart';
import 'package:flutter_checklist/ui/home/home_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final home = '/';
  static final checklists = '/checklists';
}

final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: Routes.checklists,
      builder: (context, state) {
        // final id = state.pathParameters['id'];
        return ChecklistsScreen();
      },
    ),
  ],
);
