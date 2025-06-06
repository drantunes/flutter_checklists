import 'package:flutter/material.dart';
import 'package:flutter_checklist/routes/routes.dart';
import 'package:flutter_checklist/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Checklist',
      debugShowCheckedModeBanner: false,
      theme: ChecklistTheme.themeData,
      routerConfig: router,
    );
  }
}
