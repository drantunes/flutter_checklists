import 'package:flutter_checklist/data/models/checklist_box.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ChecklistTasksBox {
  @Id()
  int id = 0;

  String category;

  ChecklistTasksBox(this.category);

  List<String> completedTasks = [];

  final checklist = ToOne<ChecklistBox>();
}
