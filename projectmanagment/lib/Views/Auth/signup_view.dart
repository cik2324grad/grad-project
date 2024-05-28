import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Views/Auth/sign_in_view.dart';
import 'package:projectmanagment/Views/Auth/signup_user_information_view.dart';
import 'package:projectmanagment/Views/matching_view.dart';
import 'package:projectmanagment/Widgets/Buttons/gradient_functional_button.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text("Find new friends\nWork, have fun\nOn Campus",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 0),
                          spreadRadius: 2)
                    ],
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
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 0),
                          spreadRadius: 2)
                    ],
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
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 0),
                          spreadRadius: 2)
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5, // Kenar kalınlığı
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      "https://avatar.iran.liara.run/public/65",
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
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 0),
                          spreadRadius: 2)
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5, // Kenar kalınlığı
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      "https://avatar.iran.liara.run/public/80",
                      width: 124, // Border'ın içine alınacak resmin boyutu
                      height: 124,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 0),
                          spreadRadius: 2)
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5, // Kenar kalınlığı
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      "https://avatar.iran.liara.run/public/88",
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
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 0),
                          spreadRadius: 2)
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5, // Kenar kalınlığı
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      "https://avatar.iran.liara.run/public/49",
                      width: 124, // Border'ın içine alınacak resmin boyutu
                      height: 124,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            BlueButton(
                buttonText: "Let's Start ",
                onTap: () {
                  Get.to(SignupUserInformationView(),
                      transition: Transition.leftToRight);
                }),
            const SizedBox(height: 20),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Do you already have an account?",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 17)),
                TextSpan(
                  text: " Log in",
                  style: const TextStyle(
                    color: Color(0xfff2026ef),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    decoration:
                        TextDecoration.underline, // Altı çizili metni ekleyin
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Tıklanabilirlik işlemi buraya eklenir
                      Get.to(const SignInView());
                    },
                )
              ])),
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
