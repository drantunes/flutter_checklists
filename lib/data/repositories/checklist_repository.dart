import 'dart:collection';

import 'package:flutter_checklist/data/models/checklist_box.dart';
import 'package:flutter_checklist/data/models/checklist_tasks_box.dart';
import 'package:flutter_checklist/data/services/checklist_api_service.dart';
import 'package:flutter_checklist/data/services/objectbox_service.dart';
import 'package:flutter_checklist/domain/models/checklist.dart';
import 'package:flutter_checklist/domain/models/checklist_category.dart';
import 'package:flutter_checklist/domain/models/checklist_task.dart';
import 'package:flutter_checklist/objectbox.g.dart';
import 'package:flutter_checklist/ui/checklists/checklists_viewmodel.dart';

class ChecklistRepository {
  final ObjectboxService objectbox;
  final List<Checklist> _checklists = [];

  ChecklistRepository({required this.objectbox});

  UnmodifiableListView<Checklist> get checklists => UnmodifiableListView(_checklists);

  Future<List<Checklist>> loadChecklists() async {
    // Condição de Cache
    if (checklists.isNotEmpty) return checklists;

    // Carregar o checklist estático da API
    // final checklistData = checklistsJson;
    final api = ChecklistApiService();
    final checklistData = await api.getChecklist();

    // Abro o armzenamento no Objectbox
    final checklistBox = objectbox.store.box<ChecklistBox>();

    // Verifica se já existe um checklist para Hoje. Senão, cria um box
    final query = checklistBox.query(ChecklistBox_.date.equals(getToday())).build();
    final result = query.find();
    query.close();

    // Só cria um novo checklist, senão existe no banco
    if (result.isEmpty) {
      checklistBox.put(ChecklistBox(getToday()));
    }

    // Carregar todos os checklists do banco de dados
    final userChecklists = checklistBox.getAll();

    for (var userChecklist in userChecklists) {
      final List<ChecklistCategory> categories = [];

      // Para cada categoria do checklist
      for (var i = 0; i < checklistData.length; i++) {
        //Vamos pegar a categoria e o checlists
        final category = checklistData[i]['category'] as String;
        final categoryChecklist = checklistData[i]['checklist'] as List;

        // Criar uma lista de tarefas de uma categoria
        final tasks = categoryChecklist
            .map(
              (task) => ChecklistTask(id: task, name: task),
            )
            .toList();

        final checklistCategory = ChecklistCategory(
          name: category,
          date: userChecklist.date,
          tasks: tasks,
        );

        // Vamos pegar do box as tarefas com categorias completadas
        List<ChecklistTasksBox> userCompletedTasks = userChecklist.tasks.isEmpty
            ? []
            : userChecklist.tasks
                  .where((checklistTaskBox) => checklistTaskBox.category == category)
                  .toList();

        // Adicionar userCompletedTasks na Categoria
        if (userCompletedTasks.isNotEmpty) {
          checklistCategory.completedTasks.addAll(
            userCompletedTasks.first.completedTasks,
          );
        }
        categories.add(checklistCategory);
      }
      // Crio o checklist da tela
      final checklist = Checklist(date: userChecklist.date, categories: categories);

      // Verificação se existe uma categoria com todas as tarefas completadas
      for (var cat in categories) {
        if (cat.tasks.length == cat.completedTasks.length) {
          checklist.completedCategories.add(cat.name);
        }
      }
      _checklists.add(checklist);
    }

    return checklists;
  }

  void updateTask(
    Checklist currentChecklist,
    ChecklistCategory currentCategory,
    String task,
    bool value,
  ) async {
    // Abrir o objectbox
    final checklistBox = objectbox.store.box<ChecklistBox>();

    // Vamos buscar o checklist com o data atual
    final query = checklistBox
        .query(
          ChecklistBox_.date.equals(currentChecklist.date),
        )
        .build();
    final checklist = query.findFirst();
    query.close();

    // Verificar se existem tarefas e categoria para esta data no Box
    final checklistTask = (checklist?.tasks != null && checklist!.tasks.isEmpty)
        ? ChecklistTasksBox(currentCategory.name)
        : checklist?.tasks.firstWhere(
            (task) => task.category == currentCategory.name,
            orElse: () => ChecklistTasksBox(currentCategory.name),
          );
    // Agora, baseado no valor, vamos salvar/remover a tarefa do box
    (value)
        ? checklistTask?.completedTasks.add(task)
        : checklistTask?.completedTasks.remove(task);

    // Agora precisamos salvar o box
    final checklistTasksBox = objectbox.store.box<ChecklistTasksBox>();
    int id = checklistTasksBox.put(checklistTask!);

    checklist?.tasks.add(checklistTasksBox.get(id)!);
    checklistBox.put(checklist!);

    // Por ultimo, vamos verificar se a categoria está completa
    checkIfCategoryIsCompleted(currentChecklist, currentCategory);
  }

  void checkIfCategoryIsCompleted(
    Checklist currentChecklist,
    ChecklistCategory currentCategory,
  ) {
    final checklist = _checklists.firstWhere((c) => c.date == currentChecklist.date);

    final cat = checklist.categories.firstWhere((c) => c.name == currentCategory.name);

    if (cat.tasks.length == cat.completedTasks.length) {
      checklist.completedCategories.add(cat.name);
    }
  }
}
