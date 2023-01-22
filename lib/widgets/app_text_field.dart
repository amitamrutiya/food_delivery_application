import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool maxLines;
  final TextInputType? textInputType;
  AppTextField(
      {Key? key,
      required this.textController,
      required this.hintText,
      required this.icon,
      this.textInputType,
      this.maxLines = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.height20, right: Dimensions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                spreadRadius: 1,
                offset: const Offset(1, 1),
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: TextFormField(
        maxLines: maxLines ? 3 : 1,
        keyboardType: textInputType,
        obscureText: hintText == "password" ? true : false,
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: AppColors.yellowColor,
          ),
          hintText: hintText,

          // prefix: const Icon(Icons.email, color: AppColors.yellowColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
          ),
        ),
      ),
    );
  }
}
