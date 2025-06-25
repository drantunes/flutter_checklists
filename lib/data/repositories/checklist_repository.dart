import 'dart:collection';

import 'package:flutter_checklist/data/mocks/checklists_json.dart';
import 'package:flutter_checklist/domain/models/checklist.dart';
import 'package:flutter_checklist/domain/models/checklist_category.dart';
import 'package:flutter_checklist/domain/models/checklist_task.dart';
import 'package:flutter_checklist/ui/checklists/checklists_viewmodel.dart';

class ChecklistRepository {
  final List<Checklist> _checklists = [];

  UnmodifiableListView<Checklist> get checklists => UnmodifiableListView(_checklists);

  loadChecklists() {
    if (checklists.isNotEmpty) return;

    final List<ChecklistCategory> categories = [];

    for (var i = 0; i < checklistsJson.length; i++) {
      final checklist = checklistsJson[i]['checklist'] as List;

      final tasks = checklist
          .map(
            (task) => ChecklistTask(id: task, name: task),
          )
          .toList();

      categories.add(
        ChecklistCategory(
          id: i.toString(),
          name: checklistsJson[i]['category'] as String,
          tasks: tasks,
        ),
      );
    }

    final checkList = Checklist(
      id: getToday(),
      date: getToday(),
      categories: categories,
    );
    if (!_checklists.contains(checkList)) _checklists.add(checkList);
  }
}
