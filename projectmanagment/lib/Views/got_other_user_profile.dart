import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectmanagment/Models/user_model_v2.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/Widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class OtherProfileView extends StatelessWidget {
  OtherProfileView({super.key, required this.userModel2});
  UserModel2 userModel2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xfffF5F5DC),
            title: const Text(
              "Back Matches",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
            )),
        backgroundColor: Color(0xfffF5F5DC),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: Center(
            child: Column(
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
                  userModel2.userPicture ?? "",
                  width: 124, // Border'ın içine alınacak resmin boyutu
                  height: 124,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              userModel2.userName ?? "",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 19),
            ),
            Text(
              userModel2.userAdditionalInformation ?? "404 empty",
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w300,
                  fontSize: 16),
            ),
            Text(
              userModel2.userAge.toString(),
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w200,
                  fontSize: 15),
            ),
          ],
        )));
  }
}
