import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/Views/messages_view.dart';
import 'package:provider/provider.dart';

class CompletedMatches extends StatefulWidget {
  const CompletedMatches({super.key});

  @override
  State<CompletedMatches> createState() => _CompletedMatchesState();
}

class _CompletedMatchesState extends State<CompletedMatches> {
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
        future:
            authService.fetchUserData(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return SizedBox(
            height: 300,
            width: context.width,
            child: ListView.builder(
                itemCount: authService.acceptedRequestList.length,
                itemBuilder: (context, index) {
                  return AcceptedMatches(
                      userModel: authService.acceptedRequestList[index]);
                }),
          );
        });
  }
}



/*
 FutureBuilder(
        future:
            authService.fetchUserData(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return SizedBox(
            height: 300,
            width: context.width,
            child: ListView.builder(
                itemCount: authService.acceptedRequestList.length,
                itemBuilder: (context, index) {
                  return AcceptedMatches(
                      userModel: authService.acceptedRequestList[index]);
                }),
          );
        });


 */