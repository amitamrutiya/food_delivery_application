import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/data/controllers/user_controller.dart';
import 'package:shopping_app/screens/home/food_page_body.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';
import 'package:shopping_app/widgets/big_text.dart';
import 'package:shopping_app/widgets/small_text.dart';

import '../../data/controllers/popular_product_controller.dart';
import '../../data/controllers/recommended_food_controller.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _loadResource,
        child: Column(
          children: [
            //Showing the header
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          BigText(
                            text: "India",
                            color: AppColors.mainColor,
                          ),
                          SmallText(
                            text: Get.find<UserController>().userModel.name,
                            color: Colors.black,
                          )
                        ],
                      ),
                      Container(
                        height: Dimensions.height45,
                        width: Dimensions.width45,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.mainColor),
                        child: Icon(Icons.search,
                            color: Colors.white, size: Dimensions.iconSize24),
                      ),
                    ]),
              ),
            ),
            //Showing a body
            const Expanded(child: SingleChildScrollView(child: FoodPageBody())),
          ],
        ));
  }
}
