import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectmanagment/Models/user_model.dart';
import 'package:projectmanagment/Models/user_model_v2.dart';
import 'package:projectmanagment/Utils/enums.dart';

final class WatchMatchs extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<UserModel2> waitingRequestList = [];

  Future<void> userWatchOwnWaitingRequest(
      {required List<String> waitingMatches}) async {
    Future<void> userWatchOwnWaitingRequest(
        {required List<String> waitingMatches}) async {
      waitingRequestList.clear(); // Eski verileri temizle

      for (String matchId in waitingMatches) {
        try {
          // Matchings koleksiyonundan dokümanı al
          final matchDoc = await _firebaseFirestore
              .collection("Matchings")
              .doc(matchId)
              .get();

          if (matchDoc.exists) {
            // Matchings dokümanı içindeki ID'yi kullanarak Users2 koleksiyonundan kullanıcıyı al
            final userId = matchDoc.data()?[
                'userId']; // Burada, 'userId' alanı Matchings dokümanında bulunmalı

            if (userId != null) {
              UserModel2? user = await fetchUserData(userId);

              if (user != null) {
                // Kullanıcı verisini userList listesine ekle
                waitingRequestList.add(user);
              }
            }
          }
        } catch (e) {
          print("Hata: $e");
        }
      }

      notifyListeners(); // Değişiklikleri dinleyicilere bildir
    }
  }
}

extension FetchSuitableUserForWatchMatchs on WatchMatchs {
  Future<UserModel2?> fetchUserData(String userID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection(Collections.Users.name)
        .doc(userID)
        .get();
    try {
      if (snapshot.exists) {
        UserModel2 userModel2 = UserModel2(
            uid: snapshot["uid"],
            userName: snapshot["userName"],
            userAdditionalInformation: snapshot["userAdditionalInformation"],
            userCategoryList: snapshot["userCategoryList"],
            userAge: snapshot["userAge"],
            userPicture: snapshot["userPicture"],
            weight: snapshot["weight"],
            acceptingMatching: snapshot["acceptingMatching"],
            rejectingMatching: snapshot["rejectingMatching"],
            waitingMatching: snapshot["waitingMatching"],
            inComingMatchRequests: snapshot['inComingMatchRequests'],
            phoneNumber: snapshot['phoneNumber'],
            sharePhoneNumber: snapshot['sharePhoneNumber'],
            userMail: snapshot['userMail']);
        return userModel2;
      }
    } catch (e) {
      print("errer when fetcingf data $e");
    }
    return null;
  }
}
