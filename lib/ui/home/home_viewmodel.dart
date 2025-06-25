import 'package:flutter/cupertino.dart';

class HomeViewmodel extends ChangeNotifier {
  bool option = false;
  String title = 'Log Checklist';
  String error = '';

  saveOption(bool newOption) {
    option = newOption;
    if (option) {
      title = title.toUpperCase();
      error = '';
    } else {
      title = title.toLowerCase();
      error = 'Tem um erro';
    }
    notifyListeners();
  }
}
