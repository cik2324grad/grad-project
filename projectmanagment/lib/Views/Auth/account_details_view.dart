import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/Extension/mediaquery+extension.dart';
import 'package:projectmanagment/Service/auth_service.dart';
import 'package:projectmanagment/ViewModel/Auth/auth_view_model.dart';
import 'package:projectmanagment/ViewModel/Auth/select_categories_view_model.dart';
import 'package:projectmanagment/ViewModel/KYCSuvey/kyc_survey_viewmodel.dart';
import 'package:projectmanagment/Widgets/Appbar/custom_appbar.dart';
import 'package:projectmanagment/Widgets/Auth/user_inputs.dart';
import 'package:projectmanagment/Widgets/Buttons/gradient_functional_button.dart';
import 'package:provider/provider.dart';

class AccountDetailsView extends StatelessWidget {
  const AccountDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationViewModel authenticationViewModel =
        Provider.of<AuthenticationViewModel>(context);
    final SelectCategoriesViewModel selectCategoriesViewModel =
        Provider.of<SelectCategoriesViewModel>(context);
    final KYCViewModel kycViewModel = Provider.of<KYCViewModel>(context);
    final AuthService authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text("Last step\nto start",
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 35)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 0),
                          spreadRadius: 2)
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5, // Kenar kalınlığı
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      "https://avatar.iran.liara.run/public/27",
                      width: 124, // Border'ın içine alınacak resmin boyutu
                      height: 124,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 0),
                          spreadRadius: 2)
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5, // Kenar kalınlığı
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      "https://avatar.iran.liara.run/public/71",
                      width: 124, // Border'ın içine alınacak resmin boyutu
                      height: 124,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 0),
                          spreadRadius: 2)
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5, // Kenar kalınlığı
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      "https://avatar.iran.liara.run/public/45",
                      width: 124, // Border'ın içine alınacak resmin boyutu
                      height: 124,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 0),
                          spreadRadius: 2)
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5, // Kenar kalınlığı
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      "https://avatar.iran.liara.run/public/33",
                      width: 124, // Border'ın içine alınacak resmin boyutu
                      height: 124,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            UserInputs.signInMail,
            UserInputs.signInPassword,
            Spacer(),
            Center(
                child: InkWell(
                    onTap: () {
                      authenticationViewModel.signUp(
                          phoneNumber: UserInputs.phoneNumber.controller.text,
                          userMail: UserInputs.signInMail.controller.text,
                          email: UserInputs.signInMail.controller.text,
                          password: UserInputs.signInPassword.controller.text,
                          fullName: UserInputs.firstName.controller.text,
                          userName: UserInputs.userName.controller.text,
                          userAdditionalInformation:
                              UserInputs.additionalInformation.controller.text,
                          universityDepartmant:
                              UserInputs.universityDepartment.controller.text,
                          categories: kycViewModel.convertMap(),
                          weight: authService.mainWeight,
                          age: int.parse(UserInputs.age.controller.text),
                          sharePhoneNumber:
                              selectCategoriesViewModel.checboxType,
                          profilePircture: selectCategoriesViewModel
                              .selectedImageIndex
                              .toString());
                    },
                    child: Container(
                        height: 53,
                        width: context.width * 0.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xfff2026ef)),
                        child: const Center(
                          child: Text(
                            "Complete",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 21),
                          ),
                        )))),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
