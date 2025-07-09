import 'package:flutter_checklist/domain/models/checklist_category.dart';

class Checklist {
  final String date;

  final List<ChecklistCategory> categories;
  final List<String> completedCategories = [];

  Checklist({required this.date, required this.categories});
}
