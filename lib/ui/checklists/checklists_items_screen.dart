import 'package:flutter/material.dart';
import 'package:flutter_checklist/routes/routes.dart';
import 'package:flutter_checklist/theme/theme.dart';
import 'package:go_router/go_router.dart';

class ChecklistsItemsScreen extends StatelessWidget {
  ChecklistsItemsScreen({
    super.key,
    required this.category,
  });

  final String category;

  final items = [
    'Conferir se o item está armazenado no local correto',
    'Garantir empilhamento seguro conforme especificações',
    'Atualizar status de armazenagem no sistema',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Armazenagem'),
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
                value: false,
                onChanged: (value) {},
              ),
            ),

            title: Text(
              items[index],
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
  }
}
