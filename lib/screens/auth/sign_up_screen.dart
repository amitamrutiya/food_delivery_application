import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/base/cutome_loder.dart';
import 'package:shopping_app/base/show_custom_snakbar.dart';
import 'package:shopping_app/data/controllers/auth_controller.dart';
import 'package:shopping_app/models/signup_body_model.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';
import 'package:shopping_app/widgets/app_text_field.dart';
import 'package:shopping_app/widgets/big_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailContoller = TextEditingController();
    var passwordContoller = TextEditingController();
    var nameContoller = TextEditingController();
    var phoneContoller = TextEditingController();
    var signUpImages = ['t.png', "f.jpg", "g.png"];

    void _registration(AuthController authController) {
      String email = emailContoller.text.trim();
      String name = nameContoller.text.trim();
      String phone = phoneContoller.text.trim();
      String password = passwordContoller.text.trim();

      if (name.isEmpty) {
        showCustomSnakBar("Type in your name", title: "Name");
      } else if (email.isEmpty) {
        showCustomSnakBar("Type in Email Address", title: "Email Address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnakBar("Type a vaild Email Address",
            title: "Valid Email Address");
      } else if (password.isEmpty) {
        showCustomSnakBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnakBar("Password can not be less than six characters",
            title: "Password");
      } else if (phone.isEmpty) {
        showCustomSnakBar("Type in phone name", title: "Phone Number");
      } else if (phone.length > 10) {
        showCustomSnakBar("Phone number can not be grater than ten Charachter",
            title: "Phone Number");
      } else if (!GetUtils.isPhoneNumber(phone) ||
          !GetUtils.isNumericOnly(phone)) {
        showCustomSnakBar("Type a valid Phone Number", title: "Phone number");
      } else {
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            Get.offNamed(RouteHelper.getInitial());
            Get.snackbar("All Went Well", "Perfect",
                backgroundColor: AppColors.mainColor, colorText: Colors.white);
          } else {
            showCustomSnakBar(status.message.toString());
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        //logo part
                        SizedBox(
                          height: Dimensions.screenHeight * 0.25,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: Dimensions.height20 * 4,
                              backgroundImage: const AssetImage(
                                  'assets/images/logo part 1.png'),
                            ),
                          ),
                        ),
                        //name
                        AppTextField(
                            textController: nameContoller,
                            hintText: "Name",
                            icon: Icons.person),
                        SizedBox(height: Dimensions.height20),
                        //email
                        AppTextField(
                            textController: emailContoller,
                            hintText: "email",
                            icon: Icons.email,
                            textInputType: TextInputType.emailAddress),
                        SizedBox(height: Dimensions.height20),
                        //password
                        AppTextField(
                          textController: passwordContoller,
                          hintText: "password",
                          icon: Icons.password_sharp,
                        ),
                        SizedBox(height: Dimensions.height20),
                        //phone
                        AppTextField(
                            textController: phoneContoller,
                            hintText: "phone",
                            icon: Icons.phone,
                            textInputType: TextInputType.number),
                        SizedBox(height: Dimensions.height20),
                        //SignUp butoon
                        GestureDetector(
                          onTap: (() {
                            _registration(authController);
                          }),
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
                              text: "Sign Up",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.height10),
                        //Go to login text
                        RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    Get.toNamed(RouteHelper.getSignInPage()),
                              text: "Have an account already?",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20)),
                        ),
                        SizedBox(height: Dimensions.screenHeight * 0.02),
                        //Sign up options
                        RichText(
                          text: TextSpan(
                              text:
                                  "Sign up Using one of the following methods",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font16)),
                        ),
                        Wrap(
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: Dimensions.radius30,
                                backgroundImage: AssetImage(
                                    "assets/images/${signUpImages[index]}"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const CustomLoader();
          },
        ));
  }
}
