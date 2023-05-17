import 'package:delivery_app/controllers/auth_controller.dart';
import 'package:delivery_app/data/models/sign_in_request.dart';
import 'package:delivery_app/pages/auth/signup_page.dart';
import 'package:delivery_app/util/route_helper.dart';
import 'package:delivery_app/widgets/custom_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../util/constants/Colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/editable_list_tile.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var signUpImages = [
      "assets/image/t.png",
      "assets/image/f.png",
      "assets/image/g.png"
    ];

    _login() async {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      if (phone.isEmpty) {
        showSnackbar("Phone is Empty", title: "Phone");
      } else if (password.isEmpty) {
        showSnackbar("Password is Empty", title: "Password");
      } else if (password.length < 6) {
        showSnackbar("Password must be greater than 5 characters",
            title: "Password");
      } else if (!GetUtils.isPhoneNumber(phone)) {
        showSnackbar("Enter a valid phone number", title: "Phone");
      } else {
        var response = await authController
            .login(SignInRequest(phone: phone, password: password));
        if (response.isOk) {
          authController.loginState();
          Get.offAndToNamed(RouteHelper.getInitial());
        } else {
          showSnackbar(response.bodyString!, title: "Auth");
        }
      }
    }

    return Scaffold(
      body: Obx(() {
        return !authController.isLoading.value
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                      child: SizedBox(
                        child: CircleAvatar(
                          radius: 30.w,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage("assets/image/logo_1.png"),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 4.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              BigText(text: "Sign in to your account")
                            ],
                          ),
                        ),
                      ],
                    ),
                    EditableTile(
                        controller: phoneController,
                        hintText: "Phone",
                        icon: Icons.phone_iphone),
                    EditableTile(
                        isObscure: true,
                        controller: passwordController,
                        hintText: "Password",
                        icon: Icons.password_sharp),
                    SizedBox(
                      height: 4.h,
                    ),
                    InkWell(
                      onTap: () => {_login()},
                      child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(5.w)),
                          width: 30.w,
                          height: 7.h,
                          child: Center(
                            child: BigText(
                              text: "Sign up",
                              color: Colors.white,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 14.sp),
                            text: "Don\'t have an account? ",
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => {
                                        Get.to(() => SignUpPage(),
                                            transition: Transition.fade)
                                      },
                                text: "Create",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {Get.back()})),
                  ],
                ),
              )
            : const Center(
                child: SingleChildScrollView(),
              );
      }),
    );
  }
}
