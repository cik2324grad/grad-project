import 'package:flutter/material.dart';
import 'package:projectmanagment/Widgets/InputDecoration/custom_input_decoration.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.obscureText,
      required this.textInputType,
      required this.textInputAction,
      required this.hint,
      this.additionalInformation = false});

  TextEditingController controller = TextEditingController();
  TextInputType textInputType;
  TextInputAction textInputAction;
  bool obscureText;
  String hint;
  bool? additionalInformation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        minLines: additionalInformation == true ? 4 : null,
        maxLines: obscureText ? 1 : null,
        maxLength: additionalInformation == true ? 120 : null,
        controller: controller,
        cursorColor: Colors.grey,
        obscureText: obscureText,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 0.01,
              style: BorderStyle.none,
            ),
          ),
          hintText: hint,
          focusColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
