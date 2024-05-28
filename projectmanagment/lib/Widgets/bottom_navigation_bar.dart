import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Utils/constants.dart';
import 'package:projectmanagment/Views/matching_view.dart';
import 'package:projectmanagment/Views/messages_view.dart';
import 'package:projectmanagment/Views/my_profile_view.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 80),
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo.shade100,
              Color(0xfff90e0ef).withOpacity(1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Get.to(() => MessagesView(), transition: Transition.fadeIn);
                },
                child: const SizedBox.square(
                    dimension: 30, child: Icon(Icons.message_outlined)),
              ),
              InkWell(
                  onTap: () {
                    Get.to(() => const MatchingView(),
                        transition: Transition.downToUp);
                  },
                  child: const Icon(
                    CupertinoIcons.checkmark_alt_circle_fill,
                    size: 30,
                  )),
              InkWell(
                onTap: () {
                  Get.to(() => const MyProfileView(),
                      transition: Transition.fadeIn);
                },
                child: const SizedBox.square(
                    dimension: 30, child: Icon(Icons.person)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
