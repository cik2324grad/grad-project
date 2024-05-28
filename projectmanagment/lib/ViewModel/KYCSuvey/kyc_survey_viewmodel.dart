import 'package:flutter/material.dart';

class KYCViewModel extends ChangeNotifier {
  Map<String, Map<int, int>> selectedOptions2 = {};

  int? getSelectedOptionIndex(String category, int questionIndex) {
    if (selectedOptions2.containsKey(category)) {
      return selectedOptions2[category]![questionIndex];
    } else {
      return null;
    }
  }

  Map<String, Map<String, int>> convertMap() {
    Map<String, Map<String, int>> convertedMap = {};
    selectedOptions2.forEach((category, innerMap) {
      convertedMap[category] =
          innerMap.map((key, value) => MapEntry(key.toString(), value));
    });
    return convertedMap;
  }

  void setSelectedOptionIndex(
      String category, int questionIndex, int selectedIndex) {
    if (!selectedOptions2.containsKey(category)) {
      selectedOptions2[category] = {};
    }
    selectedOptions2[category]![questionIndex] = selectedIndex;
    print(selectedOptions2);
    notifyListeners();
  }

  void clearSelectedOptions() {
    selectedOptions2.clear();
    notifyListeners();
  }
}
