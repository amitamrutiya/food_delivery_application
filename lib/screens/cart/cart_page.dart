import 'package:flutter/material.dart';
import 'package:shopping_app/base/common_text_button.dart';
import 'package:shopping_app/base/no_data_page.dart';
import 'package:shopping_app/base/show_custom_snakbar.dart';
import 'package:shopping_app/data/controllers/auth_controller.dart';
import 'package:shopping_app/data/controllers/cart_controller.dart';
import 'package:shopping_app/data/controllers/location_controller.dart';
import 'package:shopping_app/data/controllers/order_controller.dart';
import 'package:shopping_app/data/controllers/popular_product_controller.dart';
import 'package:shopping_app/data/controllers/recommended_food_controller.dart';
import 'package:shopping_app/data/controllers/user_controller.dart';
import 'package:shopping_app/models/place_order.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/screens/order/delivery_option.dart';
import 'package:shopping_app/utils/app_constants.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';
import 'package:shopping_app/utils/styles.dart';
import 'package:shopping_app/widgets/app_icon.dart';
import 'package:shopping_app/widgets/app_text_field.dart';
import 'package:shopping_app/widgets/big_text.dart';
import 'package:shopping_app/screens/order/payment_option_button.dart';
import 'package:shopping_app/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController noteController = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
                left: Dimensions.width20,
                top: Dimensions.height20 * 3,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: AppIcon(
                        icon: Icons.arrow_back,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    SizedBox(width: Dimensions.width20 * 5),
                    GestureDetector(
                      onTap: () => Get.toNamed(RouteHelper.initial),
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ],
                )),
            GetBuilder<CartController>(builder: (cartController) {
              return cartController.getItems.isNotEmpty
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeBottom: true,
                        child: Container(
                          margin: EdgeInsets.only(top: Dimensions.height15),
                          // padding: EdgeInsets.only(bottom: Dimensions.height10),
                          // color: Colors.red,
                          child: GetBuilder<CartController>(
                            builder: ((cartController) {
                              var cartList = cartController.getItems;
                              return ListView.builder(
                                  itemCount: cartList.length,
                                  itemBuilder: (contex, index) {
                                    return Container(
                                      height: Dimensions.height20 * 5,
                                      width: double.maxFinite,
                                      margin: EdgeInsets.only(
                                          bottom: Dimensions.height10),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              var popularIndex = Get.find<
                                                      PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(
                                                      cartList[index].product!);
                                              if (popularIndex >= 0) {
                                                Get.toNamed(
                                                    RouteHelper.getPopularFood(
                                                        popularIndex,
                                                        "cartpage"));
                                              } else {
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(cartList[index]
                                                        .product!);
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedFood(
                                                        recommendedIndex,
                                                        'cartpage'));

                                                if (recommendedIndex <= 0) {
                                                  Get.snackbar(
                                                      "History Product",
                                                      "Product review is not available for history product",
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                      colorText: Colors.white);
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          'cartpage'));
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: Dimensions.height20 * 5,
                                              height: Dimensions.height20 * 5,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          AppConstants
                                                                  .BASE_URL +
                                                              AppConstants
                                                                  .UPLOAD_URL +
                                                              cartController
                                                                  .getItems[
                                                                      index]
                                                                  .img!)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20),
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width10),
                                          Expanded(
                                            child: SizedBox(
                                              height: Dimensions.height20 * 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  BigText(
                                                    text: cartController
                                                        .getItems[index].name!,
                                                    color: Colors.black54,
                                                  ),
                                                  SmallText(text: "Spicy"),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      BigText(
                                                        text:
                                                            "\$ ${cartController.getItems[index].price}",
                                                        color: Colors.redAccent,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            top: Dimensions
                                                                .height10,
                                                            bottom: Dimensions
                                                                .height10,
                                                            left: Dimensions
                                                                .width10,
                                                            right: Dimensions
                                                                .width10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius20),
                                                          color: Colors.white,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                                onTap: (() {
                                                                  cartController
                                                                      .addItem(
                                                                          cartList[index]
                                                                              .product!,
                                                                          -1);
                                                                }),
                                                                child:
                                                                    const Icon(
                                                                  Icons.remove,
                                                                  color: AppColors
                                                                      .signColor,
                                                                )),
                                                            SizedBox(
                                                                width: Dimensions
                                                                    .width10),
                                                            BigText(
                                                                text: cartList[
                                                                        index]
                                                                    .quantity
                                                                    .toString()),
                                                            // BigText(text: "${popularProduct.inCartItems}"),
                                                            SizedBox(
                                                                width: Dimensions
                                                                    .width10),
                                                            GestureDetector(
                                                                onTap: (() {
                                                                  cartController
                                                                      .addItem(
                                                                          cartList[index]
                                                                              .product!,
                                                                          1);
                                                                }),
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  color: AppColors
                                                                      .signColor,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }),
                          ),
                        ),
                      ),
                    )
                  : const NoDataPage(text: "Your cart is empty !");
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<OrderController>(
          builder: (orderController) {
            noteController.text = orderController.foodNote;
            return GetBuilder<CartController>(
              builder: ((cartController) {
                return Container(
                  height: Dimensions.bottomHeightBar,
                  padding: EdgeInsets.only(
                    top: Dimensions.height10,
                    // bottom: Dimensions.height10,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(
                        Dimensions.radius20,
                      ),
                    ),
                    color: cartController.getItems.isNotEmpty
                        ? AppColors.buttonBackgroundColor
                        : Colors.white,
                  ),
                  child: cartController.getItems.isNotEmpty
                      ? Column(
                          children: [
                            InkWell(
                              onTap: () => showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (_) {
                                        return Column(
                                          children: [
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.9,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          Dimensions.radius20),
                                                      topRight: Radius.circular(
                                                          Dimensions.radius20),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: Dimensions
                                                              .width20,
                                                          right: Dimensions
                                                              .width20,
                                                          top: Dimensions
                                                              .height20,
                                                        ),
                                                        height: 520,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const PaymentOptionButton(
                                                              icon: Icons.money,
                                                              title:
                                                                  "Cash On Delivery",
                                                              subTitle:
                                                                  "you pay after getting the delivery",
                                                              index: 0,
                                                            ),
                                                            SizedBox(
                                                                height: Dimensions
                                                                    .height10),
                                                            const PaymentOptionButton(
                                                              icon:
                                                                  Icons.paypal,
                                                              title:
                                                                  "Digital Payment",
                                                              subTitle:
                                                                  "safer and faster way of payment",
                                                              index: 1,
                                                            ),
                                                            SizedBox(
                                                                height: Dimensions
                                                                    .height30),
                                                            Text(
                                                                "Delivery options",
                                                                style:
                                                                    robotMedium),
                                                            SizedBox(
                                                                height: Dimensions
                                                                        .height10 /
                                                                    2),
                                                            DeliveryOptions(
                                                                value:
                                                                    "delivery",
                                                                title:
                                                                    "Home delivery",
                                                                amount: double.parse(Get
                                                                        .find<
                                                                            CartController>()
                                                                    .totalAmout
                                                                    .toString()),
                                                                isFree: false),
                                                            SizedBox(
                                                                height: Dimensions
                                                                        .height10 /
                                                                    2),
                                                            const DeliveryOptions(
                                                                value:
                                                                    "take away",
                                                                title:
                                                                    "Take away",
                                                                amount: 10.0,
                                                                isFree: true),
                                                            SizedBox(
                                                                height: Dimensions
                                                                    .height20),
                                                            Text(
                                                                "Additional notes",
                                                                style:
                                                                    robotMedium),
                                                            SizedBox(
                                                                height: Dimensions
                                                                    .height20),
                                                            AppTextField(
                                                              textController:
                                                                  noteController,
                                                              hintText:
                                                                  "Like Extra Suger,More Spicee etc",
                                                                  
                                                              maxLines: true,
                                                              icon: Icons.note,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      })
                                  .whenComplete(() => orderController
                                      .setFoodNote(noteController.text.trim())),
                              child: SizedBox(
                                height: Dimensions.height10 * 6,
                                width: double.maxFinite,
                                child: const CommonTextButton(
                                    text: "Payment Options"),
                              ),
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: Dimensions.height10,
                                      bottom: Dimensions.height10,
                                      left: Dimensions.width20,
                                      right: Dimensions.width20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: Dimensions.width10 / 2),
                                      BigText(
                                          text:
                                              "\$ ${cartController.totalAmout.toString()}  "),
                                      SizedBox(width: Dimensions.width10 / 2),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggenIn()) {
                                        cartController.addToHistory();
                                        if (Get.find<LocationController>()
                                            .addressList
                                            .isEmpty) {
                                          Get.toNamed(
                                              RouteHelper.getAddressPage());
                                        } else {
                                          var location =
                                              Get.find<LocationController>()
                                                  .getUserAddress();
                                          var user = Get.find<UserController>()
                                              .userModel;
                                          var cart = Get.find<CartController>()
                                              .getItems;
                                          PlaceOrderBody placeOrder =
                                              PlaceOrderBody(
                                            cart: cart,
                                            orderAmount: 100.0,
                                            orderNote: orderController.foodNote,
                                            address: location.address,
                                            latitude: location.latitude,
                                            longitude: location.longitude!,
                                            contactPersonName: user.name,
                                            contactPersonNumber: user.phone,
                                            scheduleAt: "",
                                            distance: 10.0,
                                            orderType:
                                                orderController.orderType,
                                            paymentMethod:
                                                orderController.paymentIndex ==
                                                        0
                                                    ? 'cash_on_delivery'
                                                    : 'digital_payment',
                                          );
                                          Get.find<OrderController>()
                                              .placeOrder(
                                                  placeOrder, _callback);
                                        }
                                      } else {
                                        Get.toNamed(
                                            RouteHelper.getSignInPage());
                                      }
                                    },
                                    child: const CommonTextButton(
                                      text: "CheckOut",
                                    ))
                              ],
                            ),
                          ],
                        )
                      : Container(),
                );
              }),
            );
          },
        ));
  }

  void _callback(bool isSucces, String message, String orderID) {
    if (isSucces) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, "success"));
      } else {
        Get.offNamed(RouteHelper.getPaymentPage(
            orderID, Get.find<UserController>().userModel.id));
      }
    } else {
      showCustomSnakBar(message);
    }
  }
}
