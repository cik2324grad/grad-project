import 'package:flutter/cupertino.dart';
import 'package:projectmanagment/Models/user_model.dart';
import 'package:projectmanagment/Models/user_model_v2.dart';
import 'package:projectmanagment/Service/fetch_users_service.dart';

abstract class IMatchingViewModel {
  List<UserModel> suitableUsers = [];
  Future<void> getSuitableUsers(
      {required String firstCategorie, required String currentUserUID});
  Future<void> sendMatchRequest({required receivedUser, required senderUser});
  bool isLoading = false;
}

final class MatchingViewModel extends ChangeNotifier {
  final _iMatchingServices = MatchingServices();
  @override
  List<UserModel> suitableUsers = [];
  List<int> weights = [];
  @override
  bool isLoading = false;

  List<UserDifference> bestMatch = [];
  Map<String, int>? diffDependsCategories;
  Future<void> getUserWeigths(
      {required String uid,
      required double userWeightValue,
      required UserModel2 currentUserModel,
      required List<String> unMatchableUserIDList}) async {
    try {
      isLoading = true;

      await _iMatchingServices.getUsersWeights(
          uid: uid,
          userWeightValue: userWeightValue,
          currentUserModel: currentUserModel,
          unMatchableUserIDList: unMatchableUserIDList);

      weights = _iMatchingServices.usersWeightList;
      bestMatch = _iMatchingServices.userDifferences;
      print("BESTMATCHH ${bestMatch.length}");
      print("girdin mi bababab");
      isLoading = false;
      diffDependsCategories = _iMatchingServices.differenceDependsCateogories;
    } catch (err) {
      isLoading = false;
      print("hata olustu weightler c ekilirken");
    }
  }

  void backButton() {
    bestMatch.clear();

    _iMatchingServices.cleanBestMatches();
    notifyListeners();
  }

/*
  @override
  Future<void> getSuitableUsers(
      {required String firstCategorie, required String currentUserUID}) async {
    try {
      isLoading = true;
      await _iMatchingServices.checkFirstCategorie(
          firstCategorie: firstCategorie, currentUserUID: currentUserUID);
      suitableUsers = _iMatchingServices.suitableUsers;
      isLoading = false;
    } catch (err) {
      isLoading = false;
      print("Get suitable users error from Matching ViewModel");
    }
  }
 */
  Future<void> sendMatchRequest({
    required receivedUser,
    required senderUser,
  }) async {
    try {
      await _iMatchingServices.createNewMatching(
          receivedUser: receivedUser, senderUser: senderUser);
    } catch (err) {
      print("reate new matching ${err}");
    }
  }
}
