import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/Views/matching_view.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void _startSplashScreen() async {
    // Buraya fonksiyonunuzun içeriğini yazabilirsiniz.
    // Örneğin, bir süre bekletip sonra ana ekrana geçiş yapabilirsiniz.
    await Future.delayed(Duration(seconds: 2));
    Get.to(MatchingView());
  }

  @override
  void initState() {
    super.initState();
    _startSplashScreen();

    // authService'i initState içerisinde doğru şekilde alın
    final AuthService authService =
        Provider.of<AuthService>(context, listen: false);
    authService.fetchUserData(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text("Spğlash screen")],
      ),
    );
  }
}
