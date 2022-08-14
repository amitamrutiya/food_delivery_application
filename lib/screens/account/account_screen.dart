import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/base/custome_appbar.dart';
import 'package:shopping_app/base/cutome_loder.dart';
import 'package:shopping_app/data/controllers/auth_controller.dart';
import 'package:shopping_app/data/controllers/cart_controller.dart';
import 'package:shopping_app/data/controllers/location_controller.dart';
import 'package:shopping_app/data/controllers/user_controller.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';
import 'package:shopping_app/widgets/account_widget.dart';
import 'package:shopping_app/widgets/app_icon.dart';
import 'package:shopping_app/widgets/big_text.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggenIn = Get.find<AuthController>().userLoggenIn();
    if (userLoggenIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: const CustomerAppBar(
        title: "Profile",
        backButtonExist: false,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return userLoggenIn
              ? (userController.isLoading)
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimensions.height20),
                      child: Column(
                        children: [
                          //profile icon
                          AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height15 * 5,
                            size: Dimensions.height15 * 10,
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          //name
                          Expanded(
                            child: SingleChildScrollView(
                                child: Column(children: [
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.person,
                                  backgroundColor: AppColors.mainColor,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                  iconColor: Colors.white,
                                ),
                                bigText: BigText(
                                  text: userController.userModel.name,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //phone
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.phone,
                                  backgroundColor: AppColors.yellowColor,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                  iconColor: Colors.white,
                                ),
                                bigText: BigText(
                                  text: userController.userModel.phone,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //email
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.mail,
                                  backgroundColor: AppColors.yellowColor,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                  iconColor: Colors.white,
                                ),
                                bigText: BigText(
                                  text: userController.userModel.email,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //address
                              GetBuilder<LocationController>(
                                  builder: (locationController) {
                                if (userLoggenIn &&
                                    locationController
                                        .addressTypeList.isEmpty) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteHelper.getAddressPage());
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        backgroundColor: AppColors.yellowColor,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                        iconColor: Colors.white,
                                      ),
                                      bigText: BigText(
                                        text: "Fill in your address",
                                      ),
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteHelper.getAddressPage());
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.location_on,
                                        backgroundColor: AppColors.yellowColor,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                        iconColor: Colors.white,
                                      ),
                                      bigText: BigText(
                                        text: "Your address",
                                      ),
                                    ),
                                  );
                                }
                              }),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //mesage
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.message,
                                  backgroundColor: Colors.redAccent,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                  iconColor: Colors.white,
                                ),
                                bigText: BigText(
                                  text: "Messages",
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),

                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .userLoggenIn()) {
                                    Get.find<AuthController>()
                                        .clearSharedData();
                                    Get.find<LocationController>()
                                        .clearAddressList();
                                    Get.find<CartController>().clear();
                                    Get.find<CartController>()
                                        .clearCartHistory();
                                    Get.offNamed(RouteHelper.getSignInPage());
                                  } else {
                                    Get.offNamed(RouteHelper.getSignInPage());
                                  }
                                },
                                child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.logout,
                                    backgroundColor: Colors.redAccent,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                    iconColor: Colors.white,
                                  ),
                                  bigText: BigText(
                                    text: "Logout",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                            ])),
                          ),
                        ],
                      ),
                    )
                  : const CustomLoader()
              : Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          width: double.infinity,
                          height: Dimensions.height30 * 11,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/signintocontinue.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            width: double.infinity,
                            height: Dimensions.height30 * 4,
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20)),
                            child: BigText(
                              text: 'Sign In For Profile',
                              color: Colors.white,
                              size: Dimensions.font26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
