import 'package:flutter/material.dart';

class GradientFunctionalButton extends StatelessWidget {
  GradientFunctionalButton(
      {super.key, required this.buttonText, required this.onTap});
  final String buttonText;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: 70.0,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.purple, Colors.deepPurple],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black, blurRadius: 10, offset: Offset(0, 2))
                ]),
            child: Center(
                child: Text(
              buttonText,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22),
            ))),
      ),
    );
  }
}
