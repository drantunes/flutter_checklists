import 'package:flutter_checklist/data/repositories/user_repository.dart';
import 'package:flutter_checklist/data/services/memory_auth_service.dart';
import 'package:flutter_checklist/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserRepository userRepository;
  late MemoryAuthService authService;

  setUpAll(() {
    authService = MemoryAuthService();
    userRepository = UserRepository(authService);
  });

  group('Test login in UserRepository', () {
    setUp(() {
      authState.value = AuthStatus.idle;
    });

    test('return Ok for valid credentials', () async {
      final email = 'teste@teste.com';
      final password = '12345678';

      final result = await userRepository.login(email, password);

      expect(result, isA<Ok>());
      expect(authState.value, AuthStatus.online);
    });

    test('return Error for invalid credentials', () async {
      final email = 'teste@teste.com';
      final password = '1234';

      final result = await userRepository.login(email, password);

      expect(result, isA<Error>());
      expect(authState.value, AuthStatus.idle);
      expect((result as Error).error, contains('Password precisa ter > 8 caracteres'));
    });

    test('check if user has logged Out', () async {
      await userRepository.logout();

      expect(authState.value, AuthStatus.loggedOut);
    });
  });
}
