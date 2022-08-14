import 'package:flutter/material.dart';
import 'package:shopping_app/utils/dimensions.dart';
import 'package:shopping_app/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;
  const IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: Dimensions.iconSize24),
        const SizedBox(width: 10),
        SmallText(text: text),
      ],
    );
  }
}
