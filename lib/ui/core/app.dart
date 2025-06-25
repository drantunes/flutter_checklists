import 'package:flutter/material.dart';
import 'package:flutter_checklist/data/repositories/checklist_repository.dart';
import 'package:flutter_checklist/routes/routes.dart';
import 'package:flutter_checklist/theme/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ChecklistRepository()),
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
