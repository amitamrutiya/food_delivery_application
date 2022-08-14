import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/base/cutom_button.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage(
      {Key? key, required this.orderID, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(const Duration(seconds: 1), () {});
    }
    return Scaffold(
      body: Center(
          child: SizedBox(
              width: Dimensions.screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    status == 1
                        ? Icons.check_circle_outline
                        : Icons.warning_outlined,
                    size: 100,
                    color: AppColors.mainColor,
                  ),
                  SizedBox(height: Dimensions.height30),
                  Text(
                    status == 1
                        ? "You placed the order successfully"
                        : "Your order failed",
                    style: TextStyle(fontSize: Dimensions.font20),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.height10,
                        vertical: Dimensions.height20),
                    child: Text(
                      status == 1 ? "successful Order" : "failed order",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: Theme.of(context).disabledColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: Dimensions.height15),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.height10),
                    child: CustomButton(
                      buttonText: "Back To Home",
                      onPressed: (() =>
                          Get.offAllNamed(RouteHelper.getInitial())),
                    ),
                  )
                ],
              ))),
    );
  }
}
