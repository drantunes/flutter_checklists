import 'package:flutter/material.dart';
import 'package:flutter_checklist/data/repositories/checklist_repository.dart';
import 'package:flutter_checklist/data/repositories/user_repository.dart';
import 'package:flutter_checklist/data/services/objectbox_service.dart';
import 'package:flutter_checklist/routes/routes.dart';
import 'package:flutter_checklist/theme/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final ObjectboxService objectBox;
  final UserRepository userRepository;

  const App({super.key, required this.objectBox, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ObjectboxService>.value(value: objectBox),
        Provider<UserRepository>.value(value: userRepository),
        Provider(
          create: (context) => ChecklistRepository(objectbox: context.read()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Checklist',
        debugShowCheckedModeBanner: false,
        theme: ChecklistTheme.themeData,
        routerConfig: router,
      ),
    );
  }
}
