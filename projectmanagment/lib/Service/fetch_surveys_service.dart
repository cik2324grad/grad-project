import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectmanagment/Models/survey_model.dart';

final class FirebaseSurveyService extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Survey? survey;

  Future<void> fetchSurveys() async {
    try {
      QuerySnapshot querySnapshot =
          await _firebaseFirestore.collection("KYCSurvey").get();
      querySnapshot.docs.forEach((category) {
        final categoryData = category.data() as Map<String, dynamic>;
        final categoryModel = Survey.fromMap(categoryData);
        survey = categoryModel;
      });
    } catch (e) {
      print("survey çekerken hata ${e}");
    }
  }
}
