import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOption = 0;

  int get selectedMenuOption {
    return _selectedMenuOption;
  }

  set selectedMenuOption(int opt) {
    _selectedMenuOption = opt;
    // notificar a los listeners
    notifyListeners();
  }
}