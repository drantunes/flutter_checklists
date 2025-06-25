import 'package:flutter/material.dart';
import 'package:flutter_checklist/routes/routes.dart';
import 'package:flutter_checklist/theme/theme.dart';
import 'package:flutter_checklist/ui/checklists/checklists_viewmodel.dart';
import 'package:go_router/go_router.dart';

class ChecklistsItemsScreen extends StatelessWidget {
  const ChecklistsItemsScreen({
    super.key,
    required this.category,
    required this.viewmodel,
  });

  final String category;
  final ChecklistsViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewmodel,
      builder: (context, child) {
        final cat = viewmodel.currentCategory;
        final items = cat!.tasks;
        return Scaffold(
          appBar: AppBar(
            title: Text(cat.name),
            centerTitle: true,
          ),
          body: ListView.separated(
            padding: EdgeInsets.all(12),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.all(12),
                leading: Transform.scale(
                  scale: 1.4, // Adjust the scale factor as needed
                  child: Checkbox(
                    side: BorderSide(color: ChecklistTheme.themeColor, width: 1.4),
                    value: cat.completedTasks.contains(items[index].name),
                    onChanged: (value) {
                      viewmodel.updateItem(items[index], value!);
                    },
                  ),
                ),

                title: Text(
                  items[index].name,
                  style: ChecklistTheme.itemTextStyle,
                ),
                trailing: IconButton(
                  onPressed: () => context.pushNamed(
                    Routes.checklistsItemNote,
                    pathParameters: {
                      'dateId': GoRouterState.of(context).pathParameters['dateId']!,
                      'itemsId': category,
                      'noteItem': '$index',
                    },
                  ),
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 24,
                  ),
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
