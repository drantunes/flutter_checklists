import 'package:flutter_checklist/data/models/checklist_tasks_box.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ChecklistBox {
  @Id()
  int id = 0;

  @Index()
  @Unique()
  String date;

  ChecklistBox(this.date);

  @Backlink('checklist')
  final tasks = ToMany<ChecklistTasksBox>();
}
