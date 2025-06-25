import 'package:flutter/material.dart';
import 'package:flutter_checklist/routes/routes.dart';
import 'package:flutter_checklist/theme/theme.dart';
import 'package:flutter_checklist/ui/checklists/checklists_viewmodel.dart';
import 'package:flutter_checklist/ui/core/widgets/pie_indicator.dart';
import 'package:go_router/go_router.dart';

class ChecklistsDateScreen extends StatelessWidget {
  const ChecklistsDateScreen({
    super.key,
    required this.dateId,
    required this.viewModel,
  });

  final String dateId;
  final ChecklistsViewmodel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        final items = viewModel.currentChecklist!.categories
            .map((category) => category.name)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(dateId),
            centerTitle: true,
          ),
          body: ListView.separated(
            padding: EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final count =
                  viewModel.currentChecklist!.categories[index].completedTasks.length;

              final total = viewModel.currentChecklist!.categories[index].tasks.length;

              return ListTile(
                contentPadding: EdgeInsets.all(12),
                leading: PieIndicator(
                  size: 40,
                  value: count / total,
                ),
                title: Text(
                  items[index],
                  style: ChecklistTheme.titleTextStyle,
                ),
                subtitle: Text(
                  '$count de $total concluídos',
                  style: ChecklistTheme.subtitleTextStyle,
                ),
                trailing: Icon(Icons.chevron_right),

                onTap: () => context.pushNamed(
                  Routes.checklistsDateItems,
                  pathParameters: {'dateId': dateId, 'itemsId': '$index'},
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(height: 1),
            itemCount: items.length,
          ),
        );
      },
    );
  }
}
