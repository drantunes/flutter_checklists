import 'package:flutter/material.dart';
import 'package:flutter_checklist/data/repositories/user_repository.dart';
import 'package:flutter_checklist/routes/routes.dart';
import 'package:flutter_checklist/ui/checklists/checklists_viewmodel.dart';
import 'package:flutter_checklist/ui/core/widgets/full_button.dart';
import 'package:flutter_checklist/ui/core/widgets/outlined_full_button.dart';
import 'package:flutter_checklist/ui/home/home_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewmodel});

  final HomeViewmodel viewmodel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewmodel;

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
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
                        onPressed: () {
                          context.read<UserRepository>().logout();
                        },
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
        );
      },
    );
  }
}
