import 'package:flutter/cupertino.dart';
import 'package:flutter_checklist/data/repositories/option_repository.dart';

class HomeViewmodel extends ChangeNotifier {
  final OptionRepository optionRepository;

  bool option = false;
  bool loading = true;

  HomeViewmodel({required this.optionRepository}) {
    loadOption();
  }

  loadOption() async {
    loading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2), () {});
    option = await optionRepository.read();
    loading = false;
    notifyListeners();
  }

  saveOption(bool newOption) async {
    option = newOption;

    await optionRepository.save(option);

    notifyListeners();
  }
}
