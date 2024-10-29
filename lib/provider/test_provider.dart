import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  String _name = 'Rick Garcia Noguez';
  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }
}
