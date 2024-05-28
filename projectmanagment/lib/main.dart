import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/Service/fetch_surveys_service.dart';
import 'package:projectmanagment/Service/fetch_users_service.dart';
import 'package:projectmanagment/ViewModel/Auth/auth_view_model.dart';
import 'package:projectmanagment/ViewModel/Auth/select_categories_view_model.dart';
import 'package:projectmanagment/ViewModel/KYCSuvey/kyc_survey_viewmodel.dart';
import 'package:projectmanagment/ViewModel/MatchingViewModel/matching_view_model.dart';
import 'package:projectmanagment/Views/Auth/signup_view.dart';
import 'package:projectmanagment/Views/matching_view.dart';
import 'package:projectmanagment/firebase_options.dart';
import 'package:provider/provider.dart';

// 16 %100
// 8 x
//16x = 800
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => SelectCategoriesViewModel()),
    ChangeNotifierProvider(create: (context) => AuthenticationViewModel()),
    ChangeNotifierProvider(create: (context) => MatchingServices()),
    ChangeNotifierProvider(create: (context) => MatchingServices()),
    ChangeNotifierProvider(create: (context) => MatchingViewModel()),
    ChangeNotifierProvider(create: (context) => KYCViewModel()),
    ChangeNotifierProvider(create: (context) => FirebaseSurveyService()),
    ChangeNotifierProvider(create: (context) => AuthService()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OnboardView(),
    );
  }
}

/*

olumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
            child: RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: "Hello İbrahim\n",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 27),
              ),
              TextSpan(
                  text: "We find new friend just for u",
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      fontSize: 24))
            ])),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.5, // Kenar kalınlığı
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    "https://avatar.iran.liara.run/public/37",
                    width: 124, // Border'ın içine alınacak resmin boyutu
                    height: 124,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.5, // Kenar kalınlığı
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    "https://avatar.iran.liara.run/public/11",
                    width: 124, // Border'ın içine alınacak resmin boyutu
                    height: 124,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Center(
            child: InkWell(
              onTap: () {
                Get.to(const AutoMatchingView(), transition: Transition.fadeIn);
              },
              child: Container(
                height: 53,
                width: context.width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xfff2026ef)),
                child: const Center(
                  child: Text(
                    "View now",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 21),
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
 */