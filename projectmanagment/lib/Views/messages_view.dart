import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Models/user_model_v2.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/Service/fetch_users_service.dart';
import 'package:projectmanagment/Utils/constants.dart';
import 'package:projectmanagment/Views/MatchingStatus/completed_matches.dart';
import 'package:projectmanagment/Views/MatchingStatus/receiving_matches.dart';
import 'package:projectmanagment/Views/MatchingStatus/waiting_matches.dart';
import 'package:projectmanagment/Views/got_other_user_profile.dart';
import 'package:projectmanagment/Views/matching_view.dart';
import 'package:projectmanagment/Widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class MessagesView extends StatefulWidget {
  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffF5F5DC),
      appBar: AppBar(
        backgroundColor: Color(0xfffF5F5DC),
        title: Text("Matches"),
        bottom: TabBar(
          indicatorColor: Color(0xfff2026ef),
          controller: _tabController,
          tabs: [
            Tab(text: "Waiting Matches"),
            Tab(text: "Receiving Matches"),
            Tab(text: "Completed Matches"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [WaitingMatches(), ReceivingMatches(), CompletedMatches()],
      ),
    );
  }
}

class WaitingRequestContainer extends StatelessWidget {
  WaitingRequestContainer({super.key, required this.userModel});

  UserModel2 userModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkWell(
        onTap: () {
          Get.to(OtherProfileView(userModel2: userModel),
              transition: Transition.rightToLeft);
        },
        child: Container(
          height: 80,
          width: context.width,
          child: Row(
            children: [
              Container(
                width: 53,
                height: 53,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.5, // Kenar kalınlığı
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    "${BaseURL.baseURL}+ ${userModel.userPicture ?? ""}}",
                    width: 124, // Border'ın içine alınacak resmin boyutu
                    height: 124,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.userName ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17.5),
                  ),
                  Text(
                    "${userModel.userAge.toString()} years old",
                    style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.5),
                  ),
                ],
              ),
              const Spacer(),
              const Text("Waiting Status",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 17,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}

class ReceivedRequestContainer extends StatelessWidget {
  ReceivedRequestContainer(
      {super.key,
      required this.userModel,
      required this.currentUserUID,
      required this.matchingID});

  UserModel2 userModel;
  final String currentUserUID;
  final String matchingID;
  @override
  Widget build(BuildContext context) {
    final _iMatchingServices = MatchingServices();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 80,
        width: context.width,
        child: Row(
          children: [
            Container(
              width: 53,
              height: 53,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.5, // Kenar kalınlığı
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  "${BaseURL.baseURL}+${userModel.userPicture ?? ""}}",
                  width: 124, // Border'ın içine alınacak resmin boyutu
                  height: 124,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.userName ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 17.5),
                ),
                Text(
                  userModel.userAge.toString(),
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: 14.5),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _iMatchingServices.whenRequestTakenUserRejectRequest(
                          takenUserUID: currentUserUID,
                          senderUserUID: userModel.uid!,
                          matchDocID: matchingID);
                    },
                    icon: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red.shade300),
                        child: const Icon(Icons.close,
                            size: 30, color: Colors.white))),
                IconButton(
                    onPressed: () {
                      _iMatchingServices.whenRequestTakenUserAcceptRequest(
                          takenUserUID: currentUserUID,
                          senderUserUID: userModel.uid!,
                          matchDocID: matchingID);
                    },
                    icon: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green.shade200),
                        child: const Icon(Icons.task_alt_rounded,
                            size: 30, color: Colors.white))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AcceptedMatches extends StatelessWidget {
  AcceptedMatches({super.key, required this.userModel});

  UserModel2 userModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 80,
        width: context.width,
        child: Row(
          children: [
            Container(
              width: 53,
              height: 53,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.5, // Kenar kalınlığı
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  "${BaseURL.baseURL}+${userModel.userPicture ?? ""}}",
                  width: 124, // Border'ın içine alınacak resmin boyutu
                  height: 124,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@${userModel.userName ?? ""}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 17.5),
                ),
                userModel.sharePhoneNumber == true
                    ? Text(
                        userModel.phoneNumber ?? "+905319279040",
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.5),
                      )
                    : Text(
                        userModel.uid ?? "+",
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.normal,
                            fontSize: 14.5),
                      ),
              ],
            ),
            const Spacer(),
            const Text("Matching",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal))
          ],
        ),
      ),
    );
  }
}

/*
   Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green.shade300),
                        child: const Icon(Icons.delete_forever_sharp,
                            size: 30, color: Colors.white))),
                IconButton(
                    onPressed: () {},
                    icon: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green.shade300),
                        child: const Icon(Icons.add_circle_outline_sharp,
                            size: 30, color: Colors.white))),
              ],
            )


 */