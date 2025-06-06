import 'package:flutter/material.dart';
import 'package:flutter_checklist/ui/core/widgets/outlined_full_button.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: <Widget>[
            Image.network(
              'https://cdn2.iconfinder.com/data/icons/corona-virus-covid-19-13/256/4_Error_notice_warning_virus-256.png',
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Esta Rota não existe!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),

            OutlinedFullButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop(context);
                }
              },
              label: 'Voltar',
            ),
          ],
        ),
      ),
    );
  }
}
