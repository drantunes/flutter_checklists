import 'package:flutter/material.dart';
import 'package:flutter_checklist/routes/routes.dart';
import 'package:flutter_checklist/theme/theme.dart';
import 'package:flutter_checklist/ui/core/widgets/pie_indicator.dart';
import 'package:go_router/go_router.dart';

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
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return ListTile(
            leading: PieIndicator(
              size: 40,
              value: 0.6,
            ),
            title: Text(
              items[index],
              style: ChecklistTheme.titleTextStyle,
            ),
            subtitle: Text(
              '1 de 5 concluídos',
              style: ChecklistTheme.subtitleTextStyle,
            ),
            trailing: Icon(Icons.chevron_right),
            onTap: () => context.pushNamed(
              Routes.checklistsDate,
              pathParameters: {'dateId': '$index'},
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(height: 1),
        itemCount: items.length,
      ),
    );
  }
}
