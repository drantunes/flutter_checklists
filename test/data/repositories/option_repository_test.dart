import 'package:flutter_checklist/data/repositories/option_repository.dart';
import 'package:flutter_checklist/data/services/local_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalStorageService extends Mock implements LocalStorageService {}

void main() {
  late OptionRepository optionRepository;
  late MockLocalStorageService mockLocalStorageService;

  setUpAll(() {
    mockLocalStorageService = MockLocalStorageService();
    optionRepository = OptionRepository(localStorageService: mockLocalStorageService);
  });

  group('Test OptionRepository', () {
    test('Method save returns true when LocalStorageService.saveBool succeds', () async {
      when(
        () => mockLocalStorageService.saveBool(any(), any()),
      ).thenAnswer((_) async => true);

      final result = await optionRepository.save(true);

      expect(result, isTrue);
      verify(() => mockLocalStorageService.saveBool(any(), any())).called(1);
    });

    test('Method save returns false when LocalStorageService.saveBool succeds', () async {
      when(
        () => mockLocalStorageService.saveBool(any(), any()),
      ).thenAnswer((_) async => false);

      final result = await optionRepository.save(false);

      expect(result, isFalse);
      verify(() => mockLocalStorageService.saveBool(any(), any())).called(1);
    });
  });
}
