import 'package:shopping_app/models/order_model.dart';
import 'package:shopping_app/screens/address/add_address_screen.dart';
import 'package:shopping_app/screens/address/pick_address_map.dart';
import 'package:shopping_app/screens/auth/sign_in_screen.dart';
import 'package:shopping_app/screens/cart/cart_page.dart';
import 'package:shopping_app/screens/food/popular_food_detail.dart';
import 'package:shopping_app/screens/food/recommend_food_detail.dart';
import 'package:shopping_app/screens/home/homepage.dart';
import 'package:shopping_app/screens/payment/order_success_page.dart';
import 'package:shopping_app/screens/payment/payment_page.dart';
import 'package:shopping_app/screens/spalsh/splash_screen.dart';
import 'package:get/get.dart';

import '../screens/auth/sign_up_screen.dart';

class RouteHelper {
  static const String splashPage = '/splash-page';
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String addAddress = '/add-address';
  static const String pickAddressMap = '/pick-address';
  static const String payment = '/payment';
  static const String orderSuccess = '/order-successful';

  static String getSplashPage() => splashPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) =>
      "$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId, String page) =>
      "$recommendedFood?pageId=$pageId&page=$page";
  static String getCartPage() => cartPage;
  static String getSignInPage() => signIn;
  static String getSignUpPage() => signUp;
  static String getAddressPage() => addAddress;
  static String getPickAddressPage() => pickAddressMap;
  static String getPaymentPage(String id,int userID) => '$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage(String orderID,String status) => '$orderSuccess?id=$orderID&status=$status';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => const SplashScreen()),
    GetPage(
        name: initial,
        page: () => const HomePage(),
        transition: Transition.fade),
    GetPage(
        name: signIn,
        page: () => const SignInScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: signUp,
        page: () => const SignUpScreen(),
        transition: Transition.fadeIn),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(
            pageId: int.parse(pageId as String), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendFoodDetail(
            pageId: int.parse(pageId as String), page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return const CartPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: addAddress,
      page: () {
        return const AddAddressScreen();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: pickAddressMap,
      page: () {
        PickAddressMap pickAddressMap = Get.arguments;
        return pickAddressMap;
      },
    ),
    GetPage(
      name: payment,
      page: () => PaymentScreen(
        orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters['userID']!),
        ),
      ),
    ),
    GetPage(
      name: orderSuccess,
      page: () => OrderSuccessPage(orderID:Get.parameters['id']!,status:Get.parameters['status'].toString().contains("success")?1:0))

  ];
}
