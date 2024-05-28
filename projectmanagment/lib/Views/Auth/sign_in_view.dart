import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Extension/mediaquery+extension.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/Widgets/Appbar/custom_appbar.dart';
import 'package:projectmanagment/Widgets/Auth/user_inputs.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
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
                        "https://avatar.iran.liara.run/public/34",
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
                        "https://avatar.iran.liara.run/public/51",
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
                        "https://avatar.iran.liara.run/public/12",
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
                        "https://avatar.iran.liara.run/public/73",
                        width: 124, // Border'ın içine alınacak resmin boyutu
                        height: 124,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              UserInputs.loginMail,
              UserInputs.loginPassword,
              const SizedBox(height: 50),
              Center(
                  child: InkWell(
                      onTap: () {
                        authService.signInWithAccount(
                            UserInputs.loginMail.controller.text,
                            UserInputs.loginPassword.controller.text);
                      },
                      child: Container(
                          height: 53,
                          width: context.width * 0.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xfff2026ef)),
                          child: const Center(
                            child: Text(
                              "Complete",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 21),
                            ),
                          )))),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
