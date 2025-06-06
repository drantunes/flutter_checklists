import 'package:flutter/material.dart';
import 'package:flutter_checklist/routes/routes.dart';
import 'package:flutter_checklist/ui/core/widgets/full_button.dart';
import 'package:flutter_checklist/ui/core/widgets/outlined_full_button.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, left: 24.0, right: 24.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: Column(
                spacing: 24,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    child: Image.asset('assets/images/checklist_logo.png'),
                  ),
                  Text(
                    'Log Checklist',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FullButton(
                  label: 'Iniciar Checklist',
                  onPressed: () => context.pushNamed(
                    Routes.checklistsDate,
                    pathParameters: {'dateId': DateTime.now().toIso8601String()},
                  ),
                ),

                OutlinedFullButton(
                  onPressed: () => context.pushNamed(Routes.checklists),
                  label: 'Checklists',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
