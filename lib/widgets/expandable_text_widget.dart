import 'package:flutter/material.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';
import 'package:shopping_app/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              height: 1.8,
              color: AppColors.pargColor,
              size: Dimensions.font16,
              text: firstHalf)
          : Column(
              children: [
                SmallText(
                    height: 1.8,
                    size: Dimensions.font16,
                    text: hiddenText
                        ? ("$firstHalf...")
                        : (firstHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText ? hiddenText = false : hiddenText = true;
                    });
                  },
                  child: Row(
                    children: [
                      hiddenText
                          ? SmallText(
                              text: "Show More", color: AppColors.mainColor)
                          : SmallText(
                              text: "Show less",
                              color: AppColors.mainColor,
                            ),
                      hiddenText
                          ? const Icon(Icons.arrow_drop_down,
                              color: AppColors.mainColor)
                          : const Icon(Icons.arrow_drop_up,
                              color: AppColors.mainColor),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
