import 'package:flutter_checklist/domain/models/checklist_task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve criar um objeto ChecklistTask com id e name', () {
    final checklistTask = ChecklistTask(
      id: '1234',
      name: 'Recebimento',
    );

    expect(checklistTask, isA<ChecklistTask>());
    expect(checklistTask.id, '1234');
    expect(checklistTask.name, 'Recebimento');
  });
}
