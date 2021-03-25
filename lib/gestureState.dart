import 'package:flutter/material.dart';

class GestureState extends ChangeNotifier {
  bool swipeRight = false;

  updateSwipe() {
    this.swipeRight = !swipeRight;
    notifyListeners();
  }
}
