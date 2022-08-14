import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/base/cutome_loder.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';
import 'package:shopping_app/widgets/app_text_field.dart';
import 'package:shopping_app/widgets/big_text.dart';

import '../../base/show_custom_snakbar.dart';
import '../../data/controllers/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneContoller = TextEditingController();
    var passwordContoller = TextEditingController();
    void _login(AuthController authController) {
      String phone = phoneContoller.text.trim();
      String password = passwordContoller.text.trim();

      if (phone.isEmpty) {
        showCustomSnakBar("Type in phone Address", title: "phone Address");
      } else if (!GetUtils.isPhoneNumber(phone)) {
        showCustomSnakBar("Type a vaild phone Address",
            title: "Valid phone Address");
      } else if (password.isEmpty) {
        showCustomSnakBar("Type in your password", title: "Password");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnakBar(status.message.toString());
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    //logo part
                    SizedBox(
                      height: Dimensions.screenHeight * 0.25,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: Dimensions.height20 * 4,
                          backgroundImage:
                              const AssetImage('assets/images/logo part 1.png'),
                        ),
                      ),
                    ),
                    //Hello text
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.width20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font20 * 3 +
                                      Dimensions.font20 / 2),
                            ),
                            SizedBox(height: Dimensions.height10 / 2),
                            Text(
                              "Sign Into Your account",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Dimensions.font20),
                            )
                          ]),
                    ),
                    SizedBox(height: Dimensions.height20),

                    //phone
                    AppTextField(
                        textController: phoneContoller,
                        hintText: "phone",
                        icon: Icons.phone,
                        textInputType: TextInputType.number),
                    SizedBox(height: Dimensions.height20),
                    //password
                    AppTextField(
                      textController: passwordContoller,
                      hintText: "password",
                      icon: Icons.password_sharp,
                    ),
                    SizedBox(height: Dimensions.screenHeight * 0.03),
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.width20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Sign into your account",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font20)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.height45),
                    //SignIn butoon
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _login(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2.5,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius30),
                            color: AppColors.mainColor,
                          ),
                          alignment: Alignment.center,
                          child: BigText(
                            text: "Sign In",
                            size: Dimensions.font20 + Dimensions.font20 / 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: Dimensions.screenHeight * 0.07),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: "Don't have and account?",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Get.toNamed(RouteHelper.getSignUpPage()),
                                text: " Create",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimensions.font20,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }
}
