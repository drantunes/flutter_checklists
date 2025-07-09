import 'package:flutter_checklist/domain/models/checklist_task.dart';

class ChecklistCategory {
  final String date;
  final String name;
  final List<ChecklistTask> tasks;
  final List<String> completedTasks = [];

  ChecklistCategory({
    required this.name,
    required this.date,
    required this.tasks,
  });
}
