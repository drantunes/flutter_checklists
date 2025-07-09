import 'package:flutter_checklist/data/repositories/option_repository.dart';
import 'package:flutter_checklist/data/repositories/user_repository.dart';
import 'package:flutter_checklist/data/services/local_storage_service.dart';
import 'package:flutter_checklist/ui/checklists/checklists_date_screen.dart';
import 'package:flutter_checklist/ui/checklists/checklists_items_screen.dart';
import 'package:flutter_checklist/ui/checklists/checklists_note_screen.dart';
import 'package:flutter_checklist/ui/checklists/checklists_screen.dart';
import 'package:flutter_checklist/ui/checklists/checklists_viewmodel.dart';
import 'package:flutter_checklist/ui/core/widgets/error_screen.dart';
import 'package:flutter_checklist/ui/home/home_screen.dart';
import 'package:flutter_checklist/ui/home/home_viewmodel.dart';
import 'package:flutter_checklist/ui/login/login_screen.dart';
import 'package:flutter_checklist/ui/login/login_viewmodel.dart';
import 'package:flutter_checklist/ui/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Routes {
  static final home = '/';
  static final checklists = '/checklists';
  static final checklistsDate = '/checklists/:dateId';
  static final checklistsDateItems = '/checklists/:dateId/:itemsId';
  static final checklistsItemNote = '/checklists/:dateId/:itemsId/:noteItem';
  static final login = '/login';
  static final splash = '/splash';
}

final router = GoRouter(
  initialLocation: Routes.home,

  refreshListenable: authState,

  redirect: (context, state) {
    return switch (authState.value) {
      AuthStatus.idle => Routes.splash,
      AuthStatus.loggedOut => Routes.login,
      AuthStatus.loggedIn => Routes.home,
      AuthStatus.online => (state.name == Routes.splash) ? Routes.home : null,
    };
  },

  routes: [
    GoRoute(
      name: Routes.splash,
      path: Routes.splash,
      builder: (context, state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      name: Routes.login,
      path: Routes.login,
      builder: (context, state) {
        final loginViewModel = LoginViewmodel(userRepository: context.read());
        return LoginScreen(loginViewmodel: loginViewModel);
      },
    ),
    GoRoute(
      name: Routes.home,
      path: Routes.home,
      builder: (context, state) {
        final repository = OptionRepository(localStorageService: LocalStorageService());
        final viewModel = HomeViewmodel(optionRepository: repository);

        return HomeScreen(viewmodel: viewModel);
      },
    ),
    GoRoute(
      name: Routes.checklists,
      path: Routes.checklists,
      builder: (context, state) {
        final viewModel = ChecklistsViewmodel(
          checklistRepository: context.read(),
        )..loadChecklists();
        return ChecklistsScreen(viewModel: viewModel);
      },
    ),
    GoRoute(
      name: Routes.checklistsDate,
      path: Routes.checklistsDate,
      builder: (context, state) {
        final dateId = state.pathParameters['dateId'];
        if (dateId == null) return ErrorScreen();

        final viewModel = ChecklistsViewmodel(
          checklistRepository: context.read(),
        )..loadChecklistByDate(dateId);

        return ChecklistsDateScreen(
          dateId: dateId,
          viewModel: viewModel,
        );
      },
    ),
    GoRoute(
      name: Routes.checklistsDateItems,
      path: Routes.checklistsDateItems,
      builder: (context, state) {
        final dateId = state.pathParameters['dateId'];
        final itemsId = state.pathParameters['itemsId'];

        if (itemsId == null || dateId == null) return ErrorScreen();

        final viewModel = ChecklistsViewmodel(
          checklistRepository: context.read(),
        )..loadTasksByCategory(dateId, itemsId);

        return ChecklistsItemsScreen(
          category: itemsId,
          viewmodel: viewModel,
        );
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
