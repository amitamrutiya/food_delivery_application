import 'package:flutter/material.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';
import 'package:shopping_app/widgets/big_text.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  const CommonTextButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Dimensions.height10,
          bottom: Dimensions.height10,
          left: Dimensions.width20,
          right: Dimensions.width20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 10,
                color: AppColors.mainColor.withOpacity(0.3))
          ],
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: AppColors.mainColor),
      child: Center(
        child: BigText(
          text: text,
          color: Colors.white,
        ),
      ),
    );
  }
}
