import 'dart:convert';

import 'package:flutter_checklist/data/services/checklist_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ChecklistApiService apiService;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://api.teste.com'));
    registerFallbackValue(http.Response('[]', 200));
    mockHttpClient = MockHttpClient();
    apiService = ChecklistApiService(client: mockHttpClient);
  });

  setUp(() {
    when(
      () => mockHttpClient.get(any(that: isA<Uri>())),
    ).thenAnswer((_) async => http.Response('[]', 200));

    // Stub para o POST chamado em postSyncedDate() no finally do getChecklist
    when(
      () => mockHttpClient.post(
        any(that: isA<Uri>()),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async => http.Response('{}', 200));
  });
  group('Checklist API Service', () {
    test('Test if getChecklist retrurn correct JSON', () async {
      final response = http.Response(
        jsonEncode([
          {'id': '1', 'name': 'Test Checklist'},
        ]),
        200,
      );

      when(
        () => mockHttpClient.get(any(that: isA<Uri>())),
      ).thenAnswer((_) async => response);

      final result = await apiService.getChecklist();

      expect(result, isA<List<dynamic>>());
      expect(result.first['name'], 'Test Checklist');
    });
  });
  test('getChecklist throws exception on error', () async {
    when(
      () => mockHttpClient.get(any(that: isA<Uri>())),
    ).thenThrow(Exception('Erro de conexão'));

    expect(() async => await apiService.getChecklist(), throwsException);
  });
}
