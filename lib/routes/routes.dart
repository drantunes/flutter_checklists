import 'package:flutter_checklist/ui/checklists/checklists_date_screen.dart';
import 'package:flutter_checklist/ui/checklists/checklists_items_screen.dart';
import 'package:flutter_checklist/ui/checklists/checklists_note_screen.dart';
import 'package:flutter_checklist/ui/checklists/checklists_screen.dart';
import 'package:flutter_checklist/ui/core/widgets/error_screen.dart';
import 'package:flutter_checklist/ui/home/home_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final home = '/';
  static final checklists = '/checklists';
  static final checklistsDate = '/checklists/:dateId';
  static final checklistsDateItems = '/checklists/:dateId/:itemsId';
  static final checklistsItemNote = '/checklists/:dateId/:itemsId/:noteItem';
}

final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      name: Routes.home,
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: Routes.checklists,
      path: Routes.checklists,
      builder: (context, state) => ChecklistsScreen(),
    ),
    GoRoute(
      name: Routes.checklistsDate,
      path: Routes.checklistsDate,
      builder: (context, state) {
        final dateId = state.pathParameters['dateId'];
        if (dateId == null) return ErrorScreen();

        return ChecklistsDateScreen(dateId: dateId);
      },
    ),
    GoRoute(
      name: Routes.checklistsDateItems,
      path: Routes.checklistsDateItems,
      builder: (context, state) {
        final itemsId = state.pathParameters['itemsId'];
        if (itemsId == null) return ErrorScreen();

        return ChecklistsItemsScreen(category: itemsId);
      },
    ),
    GoRoute(
      name: Routes.checklistsItemNote,
      path: Routes.checklistsItemNote,
      builder: (context, state) {
        final noteItem = state.pathParameters['noteItem'];
        if (noteItem == null) return ErrorScreen();

        return ChecklistsNoteScreen(noteItem: noteItem);
      },
    ),
  ],
);
