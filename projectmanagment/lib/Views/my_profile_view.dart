import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/ViewModel/Auth/auth_view_model.dart';
import 'package:projectmanagment/Widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = Provider.of<AuthService>(context);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xfffF5F5DC),
            title: const Text(
              "My Profile",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
            )),
        backgroundColor: Color(0xfffF5F5DC),
        bottomNavigationBar: CustomBottomNavigationBar(),
        body: Center(
            child: FutureBuilder(
                future: _authService
                    .fetchUserData(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return Column(
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
                            "https://avatar.iran.liara.run/public/${_authService.userSessionModel?.userPicture}",
                            width:
                                124, // Border'ın içine alınacak resmin boyutu
                            height: 124,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        _authService.userSessionModel?.userName ?? "404",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 19),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          _authService.userSessionModel
                                  ?.userAdditionalInformation ??
                              "404 empty",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                              fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade400),
                              child: const Icon(CupertinoIcons.settings,
                                  size: 30, color: Colors.white)),
                          const SizedBox(width: 16),
                          Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade400),
                              child: const Icon(Icons.camera_alt_outlined,
                                  size: 30, color: Colors.white)),
                          const SizedBox(width: 16),
                          Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade400),
                              child: const Icon(
                                  Icons.mode_edit_outline_outlined,
                                  size: 30,
                                  color: Colors.white)),
                        ],
                      )
                    ],
                  );
                })));
  }
}
