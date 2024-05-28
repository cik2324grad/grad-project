import 'package:flutter/material.dart';
import 'package:projectmanagment/Models/survey_model.dart';
import 'package:projectmanagment/Service/fetch_surveys_service.dart';
import 'package:projectmanagment/ViewModel/KYCSuvey/kyc_survey_viewmodel.dart';
import 'package:provider/provider.dart';

class KYCFSurvey extends StatefulWidget {
  KYCFSurvey({super.key});

  @override
  State<KYCFSurvey> createState() => _KYCFSurveyState();
}

class _KYCFSurveyState extends State<KYCFSurvey> {
  @override
  Widget build(BuildContext context) {
    final FirebaseSurveyService surveyService =
        Provider.of<FirebaseSurveyService>(context);
    final KYCViewModel kycViewModel = Provider.of<KYCViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                QuestionAndChoices(
                    survey: AllSurveys().foodSurvey, kycViewModel: kycViewModel)
              ],
            )),
      ),
    );
  }
}

class QuestionAndChoices extends StatelessWidget {
  QuestionAndChoices({
    super.key,
    required this.survey,
    required this.kycViewModel,
  });

  final Survey survey;
  final KYCViewModel kycViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Fill it out according to your\n level and interest\n ${survey.title}",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            softWrap: true,
            overflow: TextOverflow.visible,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: survey.questions.length,
          itemBuilder: (context, questionIndex) {
            final question = survey.questions[questionIndex];
            int optionIndexCounter = 0; // Option index counter
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  question.question,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: question.options.map((option) {
                    final optionIndex =
                        optionIndexCounter++; // Increment counter
                    return RadioListTile<int>(
                      title: Text(option),
                      value: optionIndex,
                      groupValue: kycViewModel.getSelectedOptionIndex(
                              survey.title, questionIndex) ??
                          -1, // Null check
                      onChanged: (value) {
                        kycViewModel.setSelectedOptionIndex(
                            survey.title, questionIndex, value!);
                      },
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class AllSurveys {
  final Survey artSurvey = Survey(
    title: "Art & Culture",
    questions: [
      Question(
        question: "Cinema",
        options: [
          "I go once a month",
          "I go twice a month",
          "I go three times a month",
          "I go four times a month",
          "I go more than four times a month",
        ],
      ),
      Question(
        question: "Theatre",
        options: [
          "I go once a month",
          "I go once every two months",
          "I go once every three months",
          "I go once every four months",
          "I go once every five months",
        ],
      ),
      Question(
        question: "Opera",
        options: [
          "I never went",
          "I went once",
          "I went a few times",
          "I went many times",
          "I LOVE IT",
        ],
      ),
      Question(
        question: "Dancing",
        options: [
          "I never did",
          "I did it a few times",
          "I did it many times",
          "I like it",
          "I love it",
        ],
      ),
      Question(
        question: "Drawing",
        options: [
          "I am at a bad level",
          "I am at a manageable level",
          "I am intermediate",
          "I am at a good level",
          "I am advanced",
        ],
      ),
    ],
  );

  final Survey foodSurvey = Survey(
    title: 'Food & Cuisine Survey',
    questions: [
      Question(
        question: 'Italian',
        options: [
          'I do not like at all',
          'I do not like',
          'I like',
          'I like a lot',
          'I love it'
        ],
      ),
      Question(
        question: 'Mexican',
        options: [
          'I do not like at all',
          'I do not like',
          'I like',
          'I like a lot',
          'I love it'
        ],
      ),
      Question(
        question: 'Fast Food',
        options: [
          'I do not like at all',
          'I do not like',
          'I like',
          'I like a lot',
          'I love it'
        ],
      ),
      Question(
        question: 'Chinese',
        options: [
          'I do not like at all',
          'I do not like',
          'I like',
          'I like a lot',
          'I love it'
        ],
      ),
      Question(
        question: 'Desserts',
        options: [
          'I do not like at all',
          'I do not like',
          'I like',
          'I like a lot',
          'I love it'
        ],
      ),
    ],
  );

  final Survey music = Survey(
    title: "Music",
    questions: [
      Question(
        question: "Pop&HipHop",
        options: [
          "I'm not interested",
          "I have some interest",
          "I'm interested",
          "I am very interested",
          "I love it",
        ],
      ),
      Question(
        question: "Rock",
        options: [
          "I'm not interested",
          "I have some interest",
          "I'm interested",
          "I am very interested",
          "I love it",
        ],
      ),
      Question(
        question: "Arabesque",
        options: [
          "I'm not interested",
          "I have some interest",
          "I'm interested",
          "I am very interested",
          "I love it",
        ],
      ),
      Question(
        question: "Classical",
        options: [
          "I'm not interested",
          "I have some interest",
          "I'm interested",
          "I am very interested",
          "I love it",
        ],
      ),
      Question(
        question: "Turkish Folkloric Music",
        options: [
          "I'm not interested",
          "I have some interest",
          "I'm interested",
          "I am very interested",
          "I love it",
        ],
      ),
    ],
  );

  final Survey courses = Survey(
    title: "Academic Courses",
    questions: [
      Question(
        question: "Industrial Engineering Core Courses",
        options: [
          "I am at a bad level",
          "I am at a manageable level",
          "I am intermediate",
          "I am at a good level",
          "I am advanced",
        ],
      ),
      Question(
        question: "Foreign Language(English)",
        options: [
          "A1",
          "A2",
          "B1",
          "B2",
          "C1 or C2",
        ],
      ),
      Question(
        question: "Software(Python or JavaScript)",
        options: [
          "I am not interested",
          "I have some interest",
          "I am interested",
          "I am very interested",
          "I am incredibly interested",
        ],
      ),
      Question(
        question: "Mathematics",
        options: [
          "I am at a bad level",
          "I am at a manageable level",
          "I am intermediate",
          "I am at a good level",
          "I am advanced",
        ],
      ),
      Question(
        question: "Pure Sciences",
        options: [
          "I am not interested",
          "I have some interest",
          "I am interested",
          "I am very interested",
          "I am incredibly interested",
        ],
      ),
    ],
  );
  final Survey sportsSurvey = Survey(
    title: "Sport",
    questions: [
      Question(
        question: "Football",
        options: [
          "I'm not interested",
          "I have some interest",
          "I'm interested",
          "I am very interested",
          "I love it",
        ],
      ),
      Question(
        question: "Fitness",
        options: [
          "less than 1 year",
          "1-2 years",
          "2-3 years",
          "3-4 years",
          "more than 4 years",
        ],
      ),
      Question(
        question: "Basketball",
        options: [
          "I'm not interested",
          "I have some interest",
          "I'm interested",
          "I am very interested",
          "I love it",
        ],
      ),
      Question(
        question: "Swimming",
        options: [
          "I have just started",
          "Amateur level",
          "Middle level",
          "Advanced level",
          "Professional",
        ],
      ),
      Question(
        question: "Athleticism",
        options: [
          "less than 1 year",
          "1-2 years",
          "2-3 years",
          "3-4 years",
          "more than 4 years",
        ],
      ),
    ],
  );
}
