import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/Views/messages_view.dart';
import 'package:provider/provider.dart';

class ReceivingMatches extends StatefulWidget {
  const ReceivingMatches({super.key});

  @override
  State<ReceivingMatches> createState() => _ReceivingMatchesState();
}

class _ReceivingMatchesState extends State<ReceivingMatches> {
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
                itemCount: authService.receivingRequesstList.length > 1
                    ? authService.receivingRequesstList.length - 1
                    : authService.receivingRequesstList.length,
                itemBuilder: (context, index) {
                  print(
                      "receiving liste uzunlugu ${authService.receivingRequesstList.length}");
                  return ReceivedRequestContainer(
                    userModel: authService.receivingRequesstList[index],
                    currentUserUID: FirebaseAuth.instance.currentUser!.uid,
                    matchingID: authService
                        .userSessionModel?.inComingMatchRequests?[index],
                  );
                }),
          );
        });
  }
}


/*



 */