import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/base/cutome_loder.dart';
import 'package:shopping_app/data/controllers/order_controller.dart';
import 'package:shopping_app/models/order_model.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';
import 'package:shopping_app/utils/styles.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrect;

  const ViewOrder({Key? key, required this.isCurrect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(
        builder: (orderController) {
          if (orderController.isLoading == false) {
            late List<OrderModel> orderlist;
            if (orderController.currentOrderList.isNotEmpty) {
              orderlist = isCurrect
                  ? orderController.currentOrderList.reversed.toList()
                  : orderController.historyOrderList.reversed.toList();
            } else {
              // orderlist = [OrderModel(id: 20, userId: 34)];
              orderlist = [];
            }
            return SizedBox(
              width: Dimensions.screenWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10 / 2,
                    vertical: Dimensions.height10 / 2),
                child: ListView.builder(
                    itemCount: orderlist.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                          onTap: (() => null),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Order ID",
                                            style: robotRegular.copyWith(
                                                fontSize: Dimensions.font12)),
                                        SizedBox(
                                          width: Dimensions.width10 / 2,
                                        ),
                                        Text(
                                            "#${orderlist[index].id.toString()}")
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.mainColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20 /
                                                            2)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width10,
                                                vertical:
                                                    Dimensions.width10 / 2),
                                            child: Text(
                                                "${orderlist[index].orderStatus}",
                                                style: robotMedium.copyWith(
                                                  fontSize: Dimensions.font12,
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                ))),
                                        SizedBox(
                                          height: Dimensions.height10 / 2,
                                        ),
                                        InkWell(
                                          onTap: () => null,
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.width10,
                                                  vertical:
                                                      Dimensions.width10 / 2),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20 /
                                                              2)),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/image/tracking.png',
                                                    height: Dimensions.height15,
                                                    width: Dimensions.width15,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        Dimensions.width10 / 2,
                                                  ),
                                                  Text(
                                                    "Track Order",
                                                    style: robotMedium.copyWith(
                                                        fontSize:
                                                            Dimensions.font12,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                ],
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.height10),
                            ],
                          ));
                    })),
              ),
            );
          } else {
            return const CustomLoader();
          }
        },
      ),
    );
  }
}
