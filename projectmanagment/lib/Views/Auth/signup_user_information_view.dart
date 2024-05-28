import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectmanagment/ViewModel/Auth/select_categories_view_model.dart';
import 'package:projectmanagment/Views/Auth/Survey/kyc_survey_art.dart';
import 'package:projectmanagment/Views/Auth/select_profile_picture.dart';
import 'package:projectmanagment/Widgets/Appbar/custom_appbar.dart';
import 'package:projectmanagment/Widgets/Auth/user_inputs.dart';
import 'package:projectmanagment/Widgets/Buttons/gradient_functional_button.dart';
import 'package:provider/provider.dart';

class SignupUserInformationView extends StatelessWidget {
  SignupUserInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectCategoriesViewModel selectCategoriesViewModel =
        Provider.of<SelectCategoriesViewModel>(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const Text(
                    "Let's get to know you better",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(ImageListScreen());
                      },
                      child: const CircleAvatar()),
                  UserInputs.firstName,
                  UserInputs.userName,
                  UserInputs.universityDepartment,
                  UserInputs.age,
                  UserInputs.additionalInformation,
                  const SizedBox(height: 10),
                  Text(selectCategoriesViewModel.checboxType == true
                      ? "Eşleştiğim kullanıcı ile e-postamı paylaş"
                      : "Eşleştiğim kullanıcı ile telefon numaramı paylaş"),
                  ContactType(
                      checkBoxType: selectCategoriesViewModel.checboxType),
                  selectCategoriesViewModel.checboxType == true
                      ? UserInputs.phoneNumber
                      : SizedBox(height: 0.1),
                  const SizedBox(height: 20),
                  Center(
                      child: InkWell(
                          onTap: () {
                            Get.to(KYCSurveyArt(),
                                transition: Transition.leftToRightWithFade);
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
          ),
        ]),
      ),
    );
  }
}

class CircleAvatar extends StatelessWidget {
  const CircleAvatar({
    super.key,
  });
  final baseURL = "https://avatar.iran.liara.run/public/";
  @override
  Widget build(BuildContext context) {
    final SelectCategoriesViewModel selectCategoriesViewModel =
        Provider.of<SelectCategoriesViewModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 0),
                      spreadRadius: 2)
                ],
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xfff2026ef), width: 2)),
            child: selectCategoriesViewModel.selectedImageIndex == -1
                ? Icon(
                    Icons.person,
                    size: 90,
                    color: Colors.grey.shade300,
                  )
                : Image.network(
                    baseURL + "${selectCategoriesViewModel.selectedImageIndex}",
                    fit: BoxFit.fill,
                  )),
      ),
    );
  }
}
