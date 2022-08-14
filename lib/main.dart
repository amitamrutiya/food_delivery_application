import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/utils/colors.dart';
import 'data/controllers/cart_controller.dart';
import 'data/controllers/popular_product_controller.dart';
import 'data/controllers/recommended_food_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
          theme:
              ThemeData(primaryColor: AppColors.mainColor, fontFamily: "Lato"),
        );
      });
    });
  }
}
