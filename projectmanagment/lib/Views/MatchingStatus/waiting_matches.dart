import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/Views/messages_view.dart';
import 'package:provider/provider.dart';

class WaitingMatches extends StatefulWidget {
  const WaitingMatches({super.key});

  @override
  State<WaitingMatches> createState() => _WaitingMatchesState();
}

class _WaitingMatchesState extends State<WaitingMatches> {
  late Future<void> _fetchUserDataFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AuthService authService =
        Provider.of<AuthService>(context, listen: false);
    _fetchUserDataFuture =
        authService.fetchUserData(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);

    return FutureBuilder(
      future: _fetchUserDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: authService.waitingRequestList.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Unfortunately this place is empty\nfind new matches now",
                        style: TextStyle(color: Colors.grey, fontSize: 19),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: Image.asset(
                          "assets/images/nomatchh.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: authService.waitingRequestList.length,
                  itemBuilder: (context, index) {
                    return WaitingRequestContainer(
                      userModel: authService.waitingRequestList[index],
                    );
                  },
                ),
        );
      },
    );
  }
}
