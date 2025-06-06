import 'package:flutter/material.dart';
import 'package:flutter_checklist/ui/core/widgets/full_button.dart';
import 'package:flutter_checklist/ui/core/widgets/outlined_full_button.dart';
import 'package:go_router/go_router.dart';

class ChecklistsNoteScreen extends StatefulWidget {
  const ChecklistsNoteScreen({
    super.key,
    required this.noteItem,
  });

  final String noteItem;

  @override
  State<ChecklistsNoteScreen> createState() => _ChecklistsNoteScreenState();
}

class _ChecklistsNoteScreenState extends State<ChecklistsNoteScreen> {
  final formKey = GlobalKey<FormState>();
  final noteController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  void save() {
    if (formKey.currentState!.validate()) {
      //save in VM
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Observações'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.qr_code))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView(
              children: [
                Form(
                  key: formKey,
                  child: TextFormField(
                    controller: noteController,
                    minLines: 3,
                    maxLines: 5,
                    style: const TextStyle(fontSize: 16),

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Observações',
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe uma observação';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: OutlinedFullButton(
                    label: 'Tirar Foto',
                    icon: Icons.camera_alt_outlined,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            FullButton(label: 'Salvar', onPressed: save),
          ],
        ),
      ),
    );
  }
}
