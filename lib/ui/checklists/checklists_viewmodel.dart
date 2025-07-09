import 'package:flutter/widgets.dart';
import 'package:flutter_checklist/data/repositories/checklist_repository.dart';
import 'package:flutter_checklist/domain/models/checklist.dart';
import 'package:flutter_checklist/domain/models/checklist_category.dart';
import 'package:flutter_checklist/domain/models/checklist_task.dart';

class ChecklistsViewmodel extends ChangeNotifier {
  final ChecklistRepository checklistRepository;

  List<Checklist> checklists = [];
  Checklist? currentChecklist;
  ChecklistCategory? currentCategory;

  ChecklistsViewmodel({required this.checklistRepository});

  loadChecklists() async {
    checklists = await checklistRepository.loadChecklists();
    notifyListeners();
  }

  loadChecklistByDate(String date) {
    loadChecklists();
    currentChecklist = checklistRepository.checklists.firstWhere(
      (Checklist checklist) => checklist.date == date,
    );

    notifyListeners();
  }

  loadTasksByCategory(String dateId, String itemsId) {
    loadChecklistByDate(dateId);
    int index = int.parse(itemsId);
    currentCategory = currentChecklist!.categories[index];

    notifyListeners();
  }

  void updateItem(ChecklistTask item, bool value) {
    if (value) {
      currentCategory?.completedTasks.add(item.name);
    } else {
      currentCategory?.completedTasks.remove(item.name);
    }

    checklistRepository.updateTask(currentChecklist!, currentCategory!, item.name, value);

    checkIfCategoryIsCompleted();

    loadChecklists();

    notifyListeners();
  }

  checkIfCategoryIsCompleted() {
    if (currentCategory!.completedTasks.length == currentCategory!.tasks.length) {
      currentChecklist!.completedCategories.add(currentCategory!.name);
    } else {
      currentChecklist!.completedCategories.remove(currentCategory!.name);
    }
  }
}

String getToday() {
  final date = DateTime.now();
  return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}
