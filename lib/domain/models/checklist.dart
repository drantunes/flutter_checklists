import 'package:flutter_checklist/domain/models/checklist_category.dart';

class Checklist {
  final String id;
  final String date;
  final List<ChecklistCategory> categories;
  final List<String> completedCategories = [];

  Checklist({required this.id, required this.date, required this.categories});
}
