import 'package:flutter/material.dart';
import 'package:flutter_checklist/routes/routes.dart';
import 'package:flutter_checklist/theme/theme.dart';
import 'package:flutter_checklist/ui/checklists/checklists_viewmodel.dart';
import 'package:flutter_checklist/ui/core/widgets/pie_indicator.dart';
import 'package:go_router/go_router.dart';

class ChecklistsScreen extends StatefulWidget {
  const ChecklistsScreen({
    super.key,
    required this.viewModel,
  });

  final ChecklistsViewmodel viewModel;

  @override
  State<ChecklistsScreen> createState() => _ChecklistsScreenState();
}

class _ChecklistsScreenState extends State<ChecklistsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        final items = widget.viewModel.checklists;

        return Scaffold(
          appBar: AppBar(
            title: Text('Checklists'),
            centerTitle: true,
          ),
          body: items.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  padding: EdgeInsets.all(12),

                  itemBuilder: (context, index) {
                    final done =
                        widget.viewModel.checklists[index].completedCategories.length;
                    final total = widget.viewModel.checklists[index].categories.length;

                    return ListTile(
                      leading: PieIndicator(
                        size: 40,
                        value: done / total,
                      ),
                      title: Text(
                        items[index].date,
                        style: ChecklistTheme.titleTextStyle,
                      ),
                      subtitle: Text(
                        '$done de $total concluídos',
                        style: ChecklistTheme.subtitleTextStyle,
                      ),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () => context.pushNamed(
                        Routes.checklistsDate,
                        pathParameters: {
                          'dateId': widget.viewModel.checklists[index].date,
                        },
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
