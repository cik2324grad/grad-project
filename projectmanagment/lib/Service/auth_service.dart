import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Models/user_model_v2.dart';
import 'package:projectmanagment/Utils/enums.dart';
import 'package:projectmanagment/Views/Auth/account_details_view.dart';
import 'package:projectmanagment/Views/matching_view.dart';

final class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<UserModel2> waitingRequestList = [];
  List<UserModel2> acceptedRequestList = [];
  List<UserModel2> receivingRequesstList = [];

  bool? thrownErrorSignup;
  bool? thrownErrorSignin;

  UserModel2? userSessionModel;
  late final UserCredential? userSession;
  double mainWeight = 0.0;
  //Sign in Account

  Future<void> fetchUserData(String userID) async {
    waitingRequestList.clear();
    acceptedRequestList.clear();
    receivingRequesstList.clear();

    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firebaseFirestore
        .collection(Collections.Users.name)
        .doc(userID)
        .get();

    try {
      if (snapshot.exists) {
        UserModel2 userSessionData = UserModel2(
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
          inComingMatchRequests: snapshot["inComingMatchRequests"],
          phoneNumber: snapshot["phoneNumber"],
          userMail: snapshot["userMail"],
          sharePhoneNumber: snapshot["sharePhoneNumber"],
        );

        userSessionModel = userSessionData;
        print(userSessionModel);

        print("beklenen liste${userSessionModel!.waitingMatching}");
        await userWatchOwnWaitingRequest(
            waitingMatches: userSessionModel!.waitingMatching ?? []);
        await userWatchOwnReceivingRequest(
            waitingMatches: userSessionModel!.inComingMatchRequests ?? []);
        await userWatchOwnAcceptingRequests(
            waitingMatches: userSessionModel!.acceptingMatching ?? []);
        print("bu tekrar çalıştı mı ");
      }
    } catch (e) {
      print("error when fetching data $e");
    }
  }

  Future<Map<String, dynamic>> fetchCategoryWeights() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("Deneme")
        .doc("userCategoryList")
        .get();
    return documentSnapshot.data() as Map<String, dynamic>;
  }

  List<String> returnUnmatchableUserIDList(
      {required List<UserModel2> waitingRequestList,
      required List<UserModel2> acceptedRequestList,
      required List<UserModel2> receivingRequesstList,
      required String currentUserUID}) {
    List<UserModel2> unMatchableUserList = [];
    unMatchableUserList.addAll(waitingRequestList);
    unMatchableUserList.addAll(acceptedRequestList);
    unMatchableUserList.addAll(receivingRequesstList);
    List<String> unMatchableUserIDList = [];
    for (var user in unMatchableUserList) {
      unMatchableUserIDList.add(user.uid ?? "");
    }
    unMatchableUserIDList.add(currentUserUID);
    return unMatchableUserIDList;
  }

// Çarpıp toplama fonksiyonu
  double calculateWeightedSum(
      Map<String, Map<String, Map<String, double>>> firestoreData,
      Map<String, dynamic> userSelectedCategories) {
    double totalSum = 0.0;

    for (int i = 0; i <= 4; i++) {
      double totalWeight = 0;
      totalWeight += firestoreData["Food & Cuisine"]![i.toString()]![
              userSelectedCategories["Food & Cuisine Survey"][i.toString()]
                  .toString()] ??
          0.0;
      totalSum += totalWeight * 1.19;
    }
    for (int i = 0; i <= 4; i++) {
      double totalWeight = 0;

      totalWeight += firestoreData["Music"]![i.toString()]![
              userSelectedCategories["Music"][i.toString()].toString()] ??
          0.0;

      totalSum += totalWeight * 1.19;
    }
    for (int i = 0; i <= 4; i++) {
      double totalWeight = 0;

      totalWeight += firestoreData["Academic"]![i.toString()]![
              userSelectedCategories["Academic Courses"][i.toString()]
                  .toString()] ??
          0.0;

      totalSum += totalWeight * 1.20;
    }
    for (int i = 0; i <= 4; i++) {
      double totalWeight = 0;

      totalWeight += firestoreData["Art & Culture"]![i.toString()]![
              userSelectedCategories["Art & Culture"][i.toString()]
                  .toString()] ??
          0.0;

      totalSum += totalWeight * 1.20;
    }

    for (int i = 0; i <= 4; i++) {
      double totalWeight = 0;

      totalWeight += firestoreData["Sport"]![i.toString()]![
              userSelectedCategories["Sport"][i.toString()].toString()] ??
          0.0;

      totalSum += totalWeight * 1.21;
    }

    print("------TOTAL SUMM ${totalSum}");
    return totalSum;
  }

  void calculateDouble(Map<String, dynamic> categ) async {
    Map<String, Map<String, Map<String, double>>> firestoreData =
        SurveyWeights.preferences;
    mainWeight = calculateWeightedSum(firestoreData, categ);
    Get.to(const AccountDetailsView());
  }

  Future<void> createUser213213(Map<String, dynamic> categ) async {
    print(
        "--------------------------buraya girdi mi--------------------------");
    try {
      print(
          "--------------------------buraya girdi mi--------------------------");
      final user = UserModel2(userCategoryList: categ);
      print("-------------USERRRR ${user.userCategoryList}");
      await _firebaseFirestore
          .collection("Deneme")
          .doc("tPuxrUHaA4IYkh6v4r6m")
          .set(user.toJson());

      print("başalarılı");
    } catch (e) {
      print("kullanıcı yazarken hataaaaa ${e}");
    }
    Map<String, dynamic> firestoreData = await fetchCategoryWeights();
    //calculateWeightedSum(firestoreData, categ);
  }

  Future<UserCredential> signInWithAccount(
      String email, String password) async {
    try {
      final userSession = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.to(MatchingView());
      return userSession;
    } catch (e) {
      thrownErrorSignin = true;
      notifyListeners();
      rethrow;
    }
  }

  @override
  //Sign up campus project.
  Future<UserCredential?> signUp(
      {required String email,
      required String password,
      required String fullName,
      required String userName,
      required String userAdditionalInformation,
      required String universityDepartmant,
      required Map<String, dynamic> categories,
      required int age,
      required bool sharePhoneNunber,
      required String userMail,
      required String profilePircture,
      required String phoneNumber,
      required double weight}) async {
    try {
      final newUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      userSession = newUser;
      notifyListeners();
      createUserDocumentation(
          sharePhoneNumber: sharePhoneNunber,
          phoneNumber: phoneNumber,
          fullName: fullName,
          userName: userName,
          userAdditionalInformation: userAdditionalInformation,
          universityDepartmant: universityDepartmant,
          categories: categories,
          age: age,
          profilePircture: profilePircture,
          userMail: userMail,
          weight: weight);
      return newUser;
    } catch (e) {
      //catched error
      thrownErrorSignup = true;
      return null;
    }
  }

  //MARK: Sign out and Delete account Logics.
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> deleteAccout() async {
    if (_firebaseAuth.currentUser != null) {
      try {
        await _firebaseAuth.currentUser!.delete();
        await _firebaseFirestore
            .collection(Collections.Users.name)
            .doc(_firebaseAuth.currentUser!.uid)
            .delete();
      } catch (err) {
        print("When user account deleting from db throwing error ${err}");
      }
    }
  }
}

//Create user documentation on Users Collection from db.
extension UserDocumentation on AuthService {
  Future<void> createUserDocumentation(
      {required String fullName,
      required String userName,
      required String userAdditionalInformation,
      required String universityDepartmant,
      required Map<String, dynamic> categories,
      required int age,
      required String phoneNumber,
      required String userMail,
      required bool sharePhoneNumber,
      required String profilePircture,
      required double weight}) async {
    final cUser = FirebaseAuth.instance.currentUser!;
    final user = UserModel2(
      sharePhoneNumber: sharePhoneNumber,
      uid: cUser.uid,
      userName: userName,
      userAdditionalInformation: userAdditionalInformation,
      userCategoryList: categories,
      userAge: age,
      userPicture: profilePircture,
      weight: weight,
      phoneNumber: phoneNumber,
      userMail: userMail,
      inComingMatchRequests: null,
      acceptingMatching: null,
      rejectingMatching: null,
      waitingMatching: null,
    );
    print(" SDAJFKHASDKASHJ ${user}");

    await _firebaseFirestore
        .collection(Collections.Users.name)
        .doc(cUser.uid)
        .set(user.toJson());
  }
}

extension GetCurrentUser on AuthService {
  Future<void> userWatchOwnReceivingRequest(
      {required List<dynamic> waitingMatches}) async {
    receivingRequesstList.clear();
    for (String matchId in waitingMatches) {
      try {
        // Matchings koleksiyonundan dokümanı al
        final matchDoc =
            await _firebaseFirestore.collection("Matchings").doc(matchId).get();

        if (matchDoc.exists) {
          // Matchings dokümanı içindeki ID'yi kullanarak Users2 koleksiyonundan kullanıcıyı al
          final userId = matchDoc.data()?[
              'senderUser']; // Burada, 'userId' alanı Matchings dokümanında bulunmalı
          print("userid veriyo mu ${userId}");
          if (userId != null) {
            UserModel2? user = await fetchUserData2(userId);

            if (user != null) {
              // Kullanıcı verisini userList listesine ekle
              receivingRequesstList.add(user);
              print("waiting reques lits pirn ${receivingRequesstList}");
            }
          }
        }
      } catch (e) {
        print("Hata: $e");
      }
    }
  }

  Future<void> userWatchOwnWaitingRequest(
      {required List<dynamic> waitingMatches}) async {
    waitingRequestList.clear(); // Eski verileri temizle

    for (String matchId in waitingMatches) {
      try {
        // Matchings koleksiyonundan dokümanı al
        final matchDoc =
            await _firebaseFirestore.collection("Matchings").doc(matchId).get();

        if (matchDoc.exists) {
          // Matchings dokümanı içindeki ID'yi kullanarak Users2 koleksiyonundan kullanıcıyı al
          final userId = matchDoc.data()?[
              'receivedUser']; // Burada, 'userId' alanı Matchings dokümanında bulunmalı
          print("userid veriyo mu ${userId}");
          if (userId != null) {
            UserModel2? user = await fetchUserData2(userId);

            if (user != null) {
              // Kullanıcı verisini userList listesine ekle
              waitingRequestList.add(user);
              print("waiting reques lits pirn ${waitingRequestList}");
            }
          }
        }
      } catch (e) {
        print("Hata: $e");
      }
    }
  }

  Future<void> userWatchOwnAcceptingRequests(
      {required List<dynamic> waitingMatches}) async {
    // Eski verileri temizle
    acceptedRequestList.clear();
    for (String matchId in waitingMatches) {
      try {
        // Matchings koleksiyonundan dokümanı al
        final matchDoc =
            await _firebaseFirestore.collection("Matchings").doc(matchId).get();

        if (matchDoc.exists) {
          // Matchings dokümanı içindeki ID'yi kullanarak Users2 koleksiyonundan kullanıcıyı al
          final senderUserID = matchDoc.data()?[
              'senderUser']; // Burada, 'userId' alanı Matchings dokümanında bulunmalı
          final receivedUserId = matchDoc.data()?[
              'receivedUser']; // Burada, 'userId' alanı Matchings dokümanında bulunmalı

          if (senderUserID == userSessionModel!.uid) {
            print("buraya girdi 1.kez");

            final userId = receivedUserId;
            if (userId != null) {
              UserModel2? user = await fetchUserData2(userId);

              if (user != null) {
                // Kullanıcı verisini userList listesine ekle
                acceptedRequestList.add(user);
                print("waiting reques lits pirn ${waitingRequestList}");
              }
            }
          } else if (receivedUserId == userSessionModel!.uid) {
            print("buraya girdi 2.kez");
            final userId = senderUserID;

            UserModel2? user = await fetchUserData2(userId);

            if (user != null) {
              // Kullanıcı verisini userList listesine ekle
              acceptedRequestList.add(user);
              print("waiting reques lits pirn ${acceptedRequestList}");
            }
          }
        }
      } catch (e) {
        print("Hata: $e");
      }
    }
  }

  Future<UserModel2?> fetchUserData2(String userID) async {
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
            inComingMatchRequests: snapshot["inComingMatchRequests"],
            phoneNumber: snapshot["phoneNumber"],
            sharePhoneNumber: snapshot["sharePhoneNumber"],
            userMail: snapshot["userMail"]);
        return userModel2;
      }
    } catch (e) {
      print("errer when fetcingf data $e");
    }
    return null;
  }
}

class SurveyWeights {
  static Map<String, Map<String, Map<String, double>>> preferences = {
    "Music": {
      "0": {"0": 0.20, "1": 0.23, "2": 0.13, "3": 0.23, "4": 0.20},
      "1": {"0": 0.24, "1": 0.16, "2": 0.17, "3": 0.23, "4": 0.21},
      "2": {"0": 0.20, "1": 0.21, "2": 0.25, "3": 0.15, "4": 0.19},
      "3": {"0": 0.17, "1": 0.19, "2": 0.25, "3": 0.23, "4": 0.16},
      "4": {"0": 0.15, "1": 0.21, "2": 0.15, "3": 0.25, "4": 0.25},
    },
    "Art & Culture": {
      "0": {"0": 0.22, "1": 0.21, "2": 0.14, "3": 0.23, "4": 0.20},
      "1": {"0": 0.24, "1": 0.16, "2": 0.14, "3": 0.23, "4": 0.23},
      "2": {"0": 0.22, "1": 0.19, "2": 0.21, "3": 0.19, "4": 0.19},
      "3": {"0": 0.17, "1": 0.19, "2": 0.25, "3": 0.23, "4": 0.16},
      "4": {"0": 0.21, "1": 0.15, "2": 0.25, "3": 0.18, "4": 0.21},
    },
    "Academic": {
      "0": {"0": 0.23, "1": 0.20, "2": 0.16, "3": 0.21, "4": 0.20},
      "1": {"0": 0.23, "1": 0.17, "2": 0.17, "3": 0.21, "4": 0.23},
      "2": {"0": 0.21, "1": 0.20, "2": 0.22, "3": 0.19, "4": 0.19},
      "3": {"0": 0.19, "1": 0.17, "2": 0.23, "3": 0.25, "4": 0.16},
      "4": {"0": 0.14, "1": 0.22, "2": 0.18, "3": 0.25, "4": 0.21},
    },
    "Sport": {
      "0": {"0": 0.17, "1": 0.20, "2": 0.23, "3": 0.21, "4": 0.20},
      "1": {"0": 0.16, "1": 0.24, "2": 0.23, "3": 0.14, "4": 0.23},
      "2": {"0": 0.20, "1": 0.21, "2": 0.15, "3": 0.25, "4": 0.19},
      "3": {"0": 0.19, "1": 0.23, "2": 0.17, "3": 0.18, "4": 0.23},
      "4": {"0": 0.21, "1": 0.25, "2": 0.15, "3": 0.18, "4": 0.21},
    },
    "Food & Cuisine": {
      "0": {"0": 0.21, "1": 0.23, "2": 0.14, "3": 0.23, "4": 0.20},
      "1": {"0": 0.24, "1": 0.17, "2": 0.15, "3": 0.22, "4": 0.23},
      "2": {"0": 0.20, "1": 0.13, "2": 0.25, "3": 0.15, "4": 0.19},
      "3": {"0": 0.17, "1": 0.19, "2": 0.25, "3": 0.23, "4": 0.16},
      "4": {"0": 0.17, "1": 0.19, "2": 0.15, "3": 0.27, "4": 0.25},
    },
  };
}
