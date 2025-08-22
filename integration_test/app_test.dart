import 'package:flutter/material.dart';
import 'package:flutter_checklist/data/repositories/user_repository.dart';
import 'package:flutter_checklist/data/services/objectbox_service.dart';
import 'package:flutter_checklist/data/services/pocketbase_auth_service.dart';
import 'package:flutter_checklist/ui/core/app.dart';
import 'package:flutter_checklist/ui/core/widgets/full_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('E2E Login', () {
    testWidgets('Login Flow', (tester) async {
      WidgetsFlutterBinding.ensureInitialized();
      final objectBox = await ObjectboxService.create();

      final userRepository = UserRepository(PocketbaseAuthService());
      userRepository.logout();

      await tester.pumpWidget(
        App(
          objectBox: objectBox,
          userRepository: userRepository,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Acesse sua Conta'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).first, 'teste@teste.com');
      await tester.enterText(find.byType(TextFormField).at(1), '12345678');
      await tester.tap(find.byType(FullButton));

      await tester.pumpAndSettle();

      expect(find.text('Log Checklist'), findsOneWidget);
    });
  });
}
