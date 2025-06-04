import 'package:flutter/material.dart';
import 'package:flutter_checklist/ui/core/widgets/pie_indicator.dart';

class ChecklistsScreen extends StatelessWidget {
  ChecklistsScreen({super.key});

  final items = ['24 de Junho', '23 de Junho', '22 de Junho'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checklists'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: PieIndicator(
              size: 40,
              value: 0.4,
            ),
            title: Text(
              items[index],
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
            subtitle: Text('1 de 5 concluídos'),
            trailing: IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {},
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(height: 1),
        itemCount: items.length,
      ),
    );
  }
}
