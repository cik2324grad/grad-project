import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Models/survey_model.dart';
import 'package:projectmanagment/Models/user_model_v2.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/Service/fetch_surveys_service.dart';
import 'package:projectmanagment/ViewModel/KYCSuvey/kyc_survey_viewmodel.dart';
import 'package:projectmanagment/Views/Auth/Survey/kyc_surver_food.dart';
import 'package:projectmanagment/Views/matching_view.dart';
import 'package:provider/provider.dart';

class KYCSurveyArt extends StatefulWidget {
  KYCSurveyArt({super.key});

  @override
  State<KYCSurveyArt> createState() => _KYCFSurveyState();
}

class _KYCFSurveyState extends State<KYCSurveyArt> {
  final service = AuthService();
  @override
  Widget build(BuildContext context) {
    final KYCViewModel kycViewModel = Provider.of<KYCViewModel>(context);
    final AuthService authService = Provider.of<AuthService>(context);

    final AllSurveys allSurveys = AllSurveys();
    final surveyList = [
      allSurveys.artSurvey,
      allSurveys.courses,
      allSurveys.foodSurvey,
      allSurveys.sportsSurvey,
      allSurveys.music
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    120, // ListView'in tüm yüksekliğini kullan
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: surveyList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 40),
                        QuestionAndChoices(
                          survey: surveyList[index],
                          kycViewModel: kycViewModel,
                        ),
                        const Divider()
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              BlueButton(
                  buttonText: "Complete",
                  onTap: () {
                    authService.calculateDouble(kycViewModel.convertMap());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
