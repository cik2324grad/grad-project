import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/Views/matching_view.dart';

final class AuthenticationViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool signUpProgress = false;
  bool signInProgress = false;
  bool signOutProgress = false;
  bool deleteAccountProgress = false;
  bool? thrownErrorSignup;
  bool? thrownErrorSignin;

//Sign up to application logic
  Future<void> signUp(
      {required String email,
      required String password,
      required String fullName,
      required String userName,
      required String userAdditionalInformation,
      required String universityDepartmant,
      required Map<String, dynamic> categories,
      required int age,
      required bool sharePhoneNumber,
      required String phoneNumber,
      required String userMail,
      required String profilePircture,
      required double weight}) async {
    signUpProgress = true;
    notifyListeners();
    try {
      await _authService.signUp(
          phoneNumber: phoneNumber,
          email: email,
          password: password,
          fullName: fullName,
          userName: userName,
          userAdditionalInformation: userAdditionalInformation,
          universityDepartmant: universityDepartmant,
          categories: categories,
          age: age,
          sharePhoneNunber: sharePhoneNumber,
          userMail: userMail,
          profilePircture: profilePircture,
          weight: weight);

      if (_authService.thrownErrorSignup != null &&
          _authService.thrownErrorSignup == true) {
        thrownErrorSignup = true;
        notifyListeners();
      } else {
        signUpProgress = false;
        print("kayıt tamam");
        Get.to(const MatchingView(), transition: Transition.fadeIn);
        //TO DO
      }
    } catch (er) {
      print("hata oldu");
    }
    signUpProgress = false;
    notifyListeners();
  }

//Sign in your accout logic
  Future<void> signIn({required String email, required String password}) async {
    signInProgress = true;
    notifyListeners();
    try {
      await _authService.signInWithAccount(email, password);
      if (_authService.thrownErrorSignin != null &&
          _authService.thrownErrorSignin == true) {
        signInProgress = false;

        thrownErrorSignin = true;
        notifyListeners();
      } else {
        signInProgress = false;
        notifyListeners();
        //  TO DO
        //navigate to home view
      }
    } catch (e) {
      print(e);
    }
    signInProgress = false;
    thrownErrorSignin = true;
    notifyListeners();
  }

//Sign out from account logic
  Future<void> signOut() async {
    signInProgress = true;
    notifyListeners();
    try {
      await _authService.signOut();
      signInProgress = false;
      // TO DO Navigate onboarding view
    } catch (e) {
      print("When sign out from account some errors thrown. $e");
    }
  }

//Delete Account Logic
  Future<void> deleteAccount() async {
    deleteAccountProgress = true;
    try {
      await _authService.deleteAccout();
      deleteAccountProgress = false;
      //TO DO navigate to onboarding view
    } catch (e) {
      print("When deleting account some errors thrown $e");
    }
  }
}
