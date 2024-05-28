import 'package:flutter/material.dart';
import 'package:projectmanagment/ViewModel/Auth/select_categories_view_model.dart';
import 'package:projectmanagment/Widgets/Auth/custom_text_field.dart';
import 'package:provider/provider.dart';

class UserInputs {
  static final loginMail = CustomTextField(
      obscureText: false,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      hint: "E-mail");

  static final loginPassword = CustomTextField(
      additionalInformation: false,
      obscureText: true,
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      hint: "Password");

  static final signInMail = CustomTextField(
      obscureText: false,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      hint: "E-mail");

  static final signInPassword = CustomTextField(
      additionalInformation: false,
      obscureText: true,
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      hint: "Password");

  static final signInPasswordAgain = CustomTextField(
      obscureText: true,
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      hint: "passwordAgain");

  static final firstName = CustomTextField(
      obscureText: false,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      hint: "First Name");

  static final lastName = CustomTextField(
      obscureText: false,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      hint: "Last Name");

  static final userName = CustomTextField(
      obscureText: false,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      hint: "@Username");

  static final universityDepartment = CustomTextField(
      obscureText: false,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      hint: "University Department");
  static final age = CustomTextField(
      obscureText: false,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.next,
      hint: "Age");

  static final phoneNumber = CustomTextField(
      obscureText: false,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.next,
      hint: "Phoe Number");

  static final additionalInformation = CustomTextField(
      obscureText: false,
      additionalInformation: true,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      hint: "Additional Informations");
}

class ContactType extends StatelessWidget {
  const ContactType({super.key, required this.checkBoxType});
  final bool checkBoxType;
  @override
  Widget build(BuildContext context) {
    final SelectCategoriesViewModel selectCategoriesViewModel =
        Provider.of<SelectCategoriesViewModel>(context);

    return Checkbox(
        value: checkBoxType,
        onChanged: (value) {
          selectCategoriesViewModel.changeCheckboxType();
        });
  }
}
