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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Image.asset('assets/images/checklist_logo.png'),
                    ),
                    Text(
                      'Log Checklist',
                      style: TextStyle(
                        fontSize: 27,
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
                    onPressed: () {
                      context.push(Routes.checklists);
                    },
                  ),

                  OutlinedFullButton(
                    onPressed: () {},
                    label: 'Checklists',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
