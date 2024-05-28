import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:projectmanagment/Models/match_model.dart';
import 'package:projectmanagment/Models/user_model.dart';
import 'package:projectmanagment/Models/user_model_v2.dart';
import 'package:projectmanagment/Utils/enums.dart';
import 'package:uuid/uuid.dart';

final class MatchingServices extends ChangeNotifier {
  Map<String, int>? differenceDependsCateogories;
//  user: User, diff: {sports: 4, skills: 5, food: 12, ..}

  List<UserDifference> userDifferences = [];

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  final List<UserModel> suitableUsers = [];
  var minScore = 0;
  final List<int> usersWeightList = [];
  List<UserModel2> bestMatches = []; // Birden fazla eşleşmeyi tutacak liste
  void cleanBestMatches() {
    bestMatches.clear();
    notifyListeners();
  }

  Future<void> getUsersWeights(
      {required String uid,
      required double userWeightValue,
      required UserModel2 currentUserModel,
      required List<String> unMatchableUserIDList}) async {
    try {
      cleanBestMatches();
      print("buraya nereden kaç girdi");
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("Users")
          .where('uid', isNotEqualTo: currentUserModel.uid)
          .get();
      querySnapshot.docs.forEach((document) async {
        final userData = document.data() as Map<String, dynamic>;

        final weight = userData[UserDocumentFieldsNew.weight.name];
        var upperWeightValue = (userWeightValue * 1.6);
        var lowerWeightValue = (userWeightValue * 0.4);

        print("bu fonksiyona girdi mi 1");
        if (weight >= lowerWeightValue && weight < upperWeightValue) {
          final UserModel2 userModel = UserModel2(
              uid: userData[UserDocumentFieldsNew.uid.name],
              userName: userData[UserDocumentFieldsNew.userName.name],
              userAdditionalInformation: userData[
                  UserDocumentFieldsNew.userAdditionalInformation.name],
              phoneNumber: userData["phoneNumber"],
              userAge: userData[UserDocumentFieldsNew.age.name],
              inComingMatchRequests: userData["inComingMatchRequests"],
              userPicture: userData[UserDocumentFieldsNew.userPicture.name],
              acceptingMatching:
                  userData[UserDocumentFieldsNew.acceptingMatching.name],
              rejectingMatching:
                  userData[UserDocumentFieldsNew.rejectingMatcing.name],
              waitingMatching:
                  userData[UserDocumentFieldsNew.waitingMatching.name],
              userCategoryList:
                  userData[UserDocumentFieldsNew.userCategoryList.name],
              weight: userData[UserDocumentFieldsNew.weight.name],
              sharePhoneNumber: userData['sharePhoneNumber'],
              userMail: userData['userMail']);
          if (!unMatchableUserIDList.contains(userModel.uid)) {
            print("unMatchableUserIDList ${unMatchableUserIDList}");

            Map<String, int> differences = calculateScore(
                currentUserModel.userCategoryList ?? {},
                userModel.userCategoryList!);
            userDifferences
                .add(UserDifference(user: userModel, differences: differences));
            print("buraya kaçıncı girişi ");

            userDifferences.sort((a, b) {
              int sumA = a.differences.values
                  .reduce((value, element) => value + element);
              int sumB = b.differences.values
                  .reduce((value, element) => value + element);
              return sumA.compareTo(sumB);
            });
          } else {
            print("çözüm önerileri");
          }
        }
      });
      print(
          "user diff üzerine bazı konus${userDifferences[0].differences} and ${userDifferences[1].differences}");
    } catch (e) {
      print("Buradan gelen hata ${e}");
    }
    notifyListeners();
  }

  Map<String, int> calculateScore(Map<String, dynamic> mainUserCategories,
      Map<dynamic, dynamic> otherUserCategories) {
    print("girdi mi calculatesocrea");
    Map<String, int> categoryDifferenceScores = {};

    // Her kategori ve alt kategori için skor hesapla
    mainUserCategories.forEach((key, value) {
      Map<String, dynamic>? userCategory = otherUserCategories[key];
      if (userCategory != null) {
        int categoryTotalDifference =
            0; // Her kategori için toplam farklılık skoru
        userCategory.forEach((subKey, subValue) {
          print(
              " main olan ${mainUserCategories[key][subKey]} ////////// DBDEN GELEN ${subKey} VALUE -> ${subValue}");
          if (mainUserCategories[key][subKey] != null) {
            // Kullanıcının seçtiği değere göre skoru hesapla
            int userChoice = userCategory[subKey];
            int mainUserChoice = mainUserCategories[key][subKey];
            int difference = (userChoice - mainUserChoice).abs();
            categoryTotalDifference += difference;
          }
        });
        print("Kategori: $key, Farklılık skoru: $categoryTotalDifference");
        categoryDifferenceScores[key] =
            categoryTotalDifference; // Her kategori için farklılık skorunu sakla
      }
    });

    print("Kategoriye göre farklılık skorları: $categoryDifferenceScores");

    return categoryDifferenceScores;
  }

  final _uuid = const Uuid();

//BUNU KULLAN KARŞI TARAF İSTEĞİ REDDETİĞİ ZAMAN İSTEĞİ YOLLAYAN KİŞİYİ VE ALAN BU ŞEKİLDE GÜNCELLEYECEĞİZ
  Future<void> whenMatchCancelledCompleteLogicsForSender(
      {required String uid,
      required String rejectingMatchID,
      required String matchDocID}) async {
    await updateSenderMatchingStatusWhenRejecting(
        uid: uid, rejectingMatchID: rejectingMatchID);
    await moveMatchIDToRejectings(uid: uid, rejectingMatchID: rejectingMatchID);
    await rejectMatching(matchDocID: matchDocID);
  }

//MARK: BUNLARI KULLANCAZ
  Future<void> whenRequestTakenUserAcceptRequest(
      {required String takenUserUID,
      required String senderUserUID,
      required String matchDocID}) async {
    await removeInComingMatchRequest(uid: takenUserUID, matchDocID: matchDocID);
    await moveMatchIDToAcceptings(
        uid: takenUserUID, acceptingMatchID: matchDocID);
    await moveMatchIDToAcceptings(
        uid: senderUserUID, acceptingMatchID: matchDocID);

    await moveMatchIDToAcceptings(
        uid: senderUserUID, acceptingMatchID: matchDocID);
    await deleteFromWaitingMatching(
        uid: senderUserUID, rejectingMatchID: matchDocID);
    await acceptMatching(matchDocID: matchDocID);
  }

  Future<void> whenRequestTakenUserRejectRequest(
      {required String takenUserUID,
      required String senderUserUID,
      required String matchDocID}) async {
    await removeInComingMatchRequest(uid: takenUserUID, matchDocID: matchDocID);
    await moveMatchIDToRejectings(
        uid: takenUserUID, rejectingMatchID: matchDocID);
    await moveMatchIDToRejectings(
        uid: senderUserUID, rejectingMatchID: matchDocID);
    await deleteFromWaitingMatching(
        uid: senderUserUID, rejectingMatchID: matchDocID);
    await rejectMatching(matchDocID: matchDocID);
  }

//Private logicler

//user onaylasa da reddetse de bu çalışacak
  Future<void> removeInComingMatchRequest(
      {required String uid, required String matchDocID}) async {
    await _firebaseFirestore
        .collection(Collections.Users.name)
        .doc(uid)
        .update({
      'inComingMatchRequests': FieldValue.arrayRemove([matchDocID])
    });
  }

  Future<void> acceptMatching({required String matchDocID}) async {
    await _firebaseFirestore
        .collection(Collections.Matchings.name)
        .doc(matchDocID)
        .update({'matchingStatus': 'Accepted'});
  }

  Future<void> rejectMatching({required String matchDocID}) async {
    await _firebaseFirestore
        .collection(Collections.Matchings.name)
        .doc(matchDocID)
        .update({'matchingStatus': 'Rejected'});
  }

  Future<void> updateSenderMatchingStatusWhenRejecting(
      {required String uid, required String rejectingMatchID}) async {
    await _firebaseFirestore.collection("Users").doc(uid).update({
      'waitingMatcing': FieldValue.arrayRemove([rejectingMatchID])
    });
  }

  Future<void> moveMatchIDToRejectings(
      {required String uid, required String rejectingMatchID}) async {
    try {
      await _firebaseFirestore.collection("Users").doc(uid).update({
        'rejectingMatching': FieldValue.arrayUnion([rejectingMatchID])
      });
      print("tamamlandı burası ${uid}");
    } catch (e) {
      print("b çalıştı mı ${e}");
    }
  }

  Future<void> moveMatchIDToAcceptings(
      {required String uid, required String acceptingMatchID}) async {
    try {
      await _firebaseFirestore.collection("Users").doc(uid).update({
        'acceptingMatching': FieldValue.arrayUnion([acceptingMatchID])
      });
      print("tamamlandı burası ${uid}");
    } catch (e) {
      print("b çalıştı mı ${e}");
    }
  }

  Future<void> deleteFromWaitingMatching(
      {required String uid, required String rejectingMatchID}) async {
    try {
      await _firebaseFirestore.collection("Users").doc(uid).update({
        'waitingMatching': FieldValue.arrayRemove([rejectingMatchID])
      });
      print("tamamlandı burası ${uid}");
    } catch (e) {
      print("b çalıştı mı ${e}");
    }
  }

  Future<void> updateSenderMatchingStatusWhenAccepting(
      {required String senderUserUID, required String acceptingMatchID}) async {
    await _firebaseFirestore.collection("Users").doc(senderUserUID).update({
      'waitingMatcing': FieldValue.arrayRemove([acceptingMatchID])
    });
  }

  Future<void> moveMatchIDToAccepting(
      {required String uid, required String rejectingMatchID}) async {
    try {
      await _firebaseFirestore.collection("Users").doc(uid).update({
        'acceptingMatching': FieldValue.arrayUnion([rejectingMatchID])
      });
    } catch (e) {
      print("buradam mo heliyo ${e}");
    }
  }

  Future<void> createNewMatching(
      {required String receivedUser, required String senderUser}) async {
    final uuid = _uuid.v1();
    final matching = MatchModel(
        matchID: uuid,
        matchingStatus: "Waiting",
        receivedUser: receivedUser,
        senderUser: senderUser);
    await _firebaseFirestore
        .collection(Collections.Matchings.name)
        .doc(uuid)
        .set(matching.toJson());

    await addMaatchIDToReceivingUser(receivedUser: receivedUser, matchID: uuid);
    await addMatchIdToSenderUserWaitingList(
        senderID: senderUser, matchID: uuid);
  }

//Adding the matching uid to the documentation of the user receiving the request
  Future<void> addMaatchIDToReceivingUser(
      {required String receivedUser, required String matchID}) async {
    try {
      await _firebaseFirestore
          .collection(Collections.Users.name)
          .doc(receivedUser)
          .update({
        'inComingMatchRequests': FieldValue.arrayUnion([matchID])
      });
    } catch (err) {
      print("When received user waiting request writing error : ${err}");
    }
  }

  Future<void> addMatchIdToSenderUserWaitingList(
      {required String senderID, required String matchID}) async {
    try {
      await _firebaseFirestore
          .collection(Collections.Users.name)
          .doc(senderID)
          .update({
        UserDocumentFields.waitingMatching.name:
            FieldValue.arrayUnion([matchID])
      });
    } catch (err) {
      print("When received user waiting request writing error : ${err}");
    }
  }
}
