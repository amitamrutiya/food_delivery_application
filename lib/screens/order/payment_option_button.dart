import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/data/controllers/order_controller.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';
import 'package:shopping_app/utils/styles.dart';

class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final int index;
  const PaymentOptionButton(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subTitle,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      bool selecteed = orderController.paymentIndex == index;
      return InkWell(
        onTap: (() => orderController.setPaymentIndex(index)),
        child: Container(
          padding: EdgeInsets.only(bottom: Dimensions.height10 / 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20 / 4),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1)
              ]),
          child: ListTile(
              leading: Icon(
                icon,
                size: 40,
                color: selecteed
                    ? AppColors.mainColor
                    : Theme.of(context).disabledColor,
              ),
              title: Text(
                title,
                style: robotMedium.copyWith(
                  fontSize: Dimensions.font20,
                ),
              ),
              subtitle: Text(
                subTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: robotRegular.copyWith(
                  color: Theme.of(context).disabledColor,
                  fontSize: Dimensions.font12,
                ),
              ),
              trailing: selecteed
                  ? const Icon(
                      Icons.check_circle,
                      color: AppColors.mainColor,
                    )
                  : null),
        ),
      );
    });
  }
}
