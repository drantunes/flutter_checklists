import 'package:flutter/material.dart';
import 'package:flutter_checklist/routes/routes.dart';
import 'package:flutter_checklist/theme/theme.dart';
import 'package:flutter_checklist/ui/core/widgets/pie_indicator.dart';
import 'package:go_router/go_router.dart';

class ChecklistsDateScreen extends StatelessWidget {
  ChecklistsDateScreen({
    super.key,
    required this.dateId,
  });

  final String dateId;

  final items = [
    'Recebimento de Mercadorias e Tarefas',
    'Movimentação Interna',
    'Armazenagem',
    'Separação de Pedidos',
    'Limpeza e Organização',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hoje, 25 de Junho'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.all(12),
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
              Routes.checklistsDateItems,
              pathParameters: {'dateId': dateId, 'itemsId': '$index'},
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(height: 1),
        itemCount: items.length,
      ),
    );
  }
}
