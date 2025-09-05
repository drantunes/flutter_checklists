import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_checklist/config/env.dart';
import 'package:flutter_checklist/routes/routes.dart';
import 'package:flutter_checklist/ui/checklists/checklists_viewmodel.dart';
import 'package:flutter_checklist/ui/core/widgets/full_button.dart';
import 'package:flutter_checklist/ui/core/widgets/outlined_full_button.dart';
import 'package:flutter_checklist/ui/home/home_viewmodel.dart';
import 'package:flutter_checklist/utils/assets.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewmodel});

  final HomeViewmodel viewmodel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewmodel;

    log(MediaQuery.sizeOf(context).width.toString());

    return LayoutBuilder(
      builder: (context, contraints) {
        if (contraints.maxWidth > 600) {
          return Center(child: Text('Tela grande'));
        }
        return ListenableBuilder(
          listenable: viewModel,
          builder: (context, child) {
            return SafeArea(
              child: Scaffold(
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
                            RepaintBoundary(
                              child: AnimatedBuilder(
                                animation: animationController,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle:
                                        animationController.value * 2 * 3.141592653589793,
                                    child: Transform.scale(
                                      scale: 1 + 0.1 * (1 - animationController.value),
                                      child: child,
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 130,
                                  child: Image.asset(Assets.logo),
                                ),
                              ),
                            ),
                            Text(
                              'Log Checklist',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'API: ${Env.apiKey}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            (viewModel.loading)
                                ? SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(),
                                  )
                                : Switch(
                                    value: viewModel.option,
                                    onChanged: (newVal) => viewModel.saveOption(newVal),
                                  ),
                            TextButton(
                              onPressed: widget.viewmodel.logout,
                              child: Text('Sair'),
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
                              pathParameters: {'dateId': getToday()},
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
              ),
            );
          },
        );
      },
    );
  }
}
