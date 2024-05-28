import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Models/user_model_v2.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/ViewModel/MatchingViewModel/matching_view_model.dart';
import 'package:projectmanagment/Widgets/favorites_containers.dart';
import 'package:provider/provider.dart';

class AutoMatchingView extends StatefulWidget {
  const AutoMatchingView({super.key});

  @override
  State<AutoMatchingView> createState() => _AutoMatchingViewState();
}

class _AutoMatchingViewState extends State<AutoMatchingView> {
  late Future<void> _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AuthService authService =
        Provider.of<AuthService>(context, listen: false);
    final MatchingViewModel matchingViewModel =
        Provider.of<MatchingViewModel>(context, listen: false);

    _future = matchingViewModel.getUserWeigths(
      uid: FirebaseAuth.instance.currentUser!.uid,
      userWeightValue: authService.userSessionModel?.weight ?? 0,
      currentUserModel: authService.userSessionModel ?? UserModel2(),
      unMatchableUserIDList: authService.returnUnmatchableUserIDList(
        waitingRequestList: authService.waitingRequestList,
        acceptedRequestList: authService.acceptedRequestList,
        receivingRequesstList: authService.receivingRequesstList,
        currentUserUID: FirebaseAuth.instance.currentUser!.uid,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String baseURL = "https://avatar.iran.liara.run/public/";
    final MatchingViewModel matchingViewModel =
        Provider.of<MatchingViewModel>(context);
    final AuthService authService = Provider.of<AuthService>(context);
    final PageController _pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffF5F5DC),
        leading: IconButton(
          onPressed: () {
            matchingViewModel.backButton();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: const Color(0xfffF5F5DC),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return PageView.builder(
                    controller: _pageController,
                    itemCount: matchingViewModel.bestMatch.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.5, // Kenar kalınlığı
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                "${baseURL}+${matchingViewModel.bestMatch[index].user.userPicture ?? ""}",
                                width:
                                    124, // Border'ın içine alınacak resmin boyutu
                                height: 124,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            matchingViewModel.bestMatch[index].user.userName ??
                                "",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              matchingViewModel.bestMatch[index].user
                                      .userAdditionalInformation ??
                                  "",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    FavoriteCategory(
                                      color: Colors.amber,
                                      categoryName: "Academic Courses",
                                      percantage: matchingViewModel
                                          .bestMatch[index]
                                          .differences["Academic Courses"]!
                                          .toDouble(),
                                    ),
                                    const SizedBox(width: 10),
                                    FavoriteCategory(
                                      color: Colors.blueGrey.shade200,
                                      categoryName: "Art & Culture",
                                      percantage: matchingViewModel
                                          .bestMatch[index]
                                          .differences["Art & Culture"]!
                                          .toDouble(),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FavoriteCategory(
                                      color: Colors.red,
                                      categoryName: "Food & Cuisine",
                                      percantage: matchingViewModel
                                          .bestMatch[index]
                                          .differences["Food & Cuisine Survey"]!
                                          .toDouble(),
                                    ),
                                    const SizedBox(width: 12),
                                    FavoriteCategory(
                                      color: Colors.green,
                                      categoryName: "Sport",
                                      percantage: matchingViewModel
                                          .bestMatch[index]
                                          .differences["Sport"]!
                                          .toDouble(),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                FavoriteCategory(
                                  color: Color.fromARGB(255, 24, 135, 169),
                                  categoryName: "Music",
                                  percantage: matchingViewModel
                                      .bestMatch[index].differences["Music"]!
                                      .toDouble(),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                icon: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 0),
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.navigate_before_outlined,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 0),
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(Icons.close,
                                      size: 30, color: Colors.red),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  matchingViewModel.sendMatchRequest(
                                    receivedUser: matchingViewModel
                                        .bestMatch[index].user.uid,
                                    senderUser:
                                        FirebaseAuth.instance.currentUser!.uid,
                                  );
                                  Navigator.pop(context);
                                },
                                icon: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 0),
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(Icons.star,
                                      size: 30, color: Color(0xfff2026ef)),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOutQuint,
                                  );
                                },
                                icon: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 0),
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.navigate_next_outlined,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
