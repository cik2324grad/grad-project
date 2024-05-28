import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/Utils/constants.dart';
import 'package:projectmanagment/Views/auto_match_view.dart';
import 'package:projectmanagment/Widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class MatchingView extends StatelessWidget {
  const MatchingView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService =
        Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xfffF5F5DC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
              future: authService
                  .fetchUserData(FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                        text: "Hello",
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
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Hello ${authService.userSessionModel?.userName}\n",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 27),
                    ),
                    const TextSpan(
                        text: "We find new friend just for u",
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            fontSize: 24))
                  ])),
                );
              }),
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
          BlueButton(
              buttonText: "View now",
              onTap: () {
                Get.to(const AutoMatchingView(), transition: Transition.fadeIn);
              }),
          Spacer(),
          CustomBottomNavigationBar()
        ],
      ),
    );
  }
}

class BlueButton extends StatelessWidget {
  const BlueButton({super.key, required this.buttonText, required this.onTap});

  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 53,
          width: context.width * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xfff2026ef)),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 21),
            ),
          ),
        ),
      ),
    );
  }
}

/* */

class MatchingViewUpdated extends StatelessWidget {
  const MatchingViewUpdated({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Selam İbrahim"),
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
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
                width: 70,
                height: 70,
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
              Center(
                child: InkWell(
                  onTap: () {
                    Get.to(const AutoMatchingView(),
                        transition: Transition.fadeIn);
                  },
                  child: Container(
                    height: 70,
                    width: context.width * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xfff2026ef)),
                    child: const Center(
                      child: Text(
                        "View now",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
