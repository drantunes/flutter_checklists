import 'package:flutter_checklist/domain/models/checklist_task.dart';

class ChecklistCategory {
  final String id;
  final String name;
  final List<ChecklistTask> tasks;
  final List<String> completedTasks = [];

  ChecklistCategory({
    required this.id,
    required this.name,
    required this.tasks,
  });
}
