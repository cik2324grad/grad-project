import 'package:flutter/material.dart';

class SelectCategoriesViewModel extends ChangeNotifier {
  List<dynamic> selectedCategories = [];
  bool checboxType = false;
  int selectedImageIndex = -1;

  void changeCheckboxType() {
    if (checboxType == false) {
      checboxType = true;
    } else {
      checboxType = false;
    }
    notifyListeners();
  }

  void changeSelectedImageIndex(int index) {
    if (selectedImageIndex != index) {
      selectedImageIndex = index;
      print("selected indexx ${selectedImageIndex}");
    }
    notifyListeners();
  }
}
