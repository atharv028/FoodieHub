import 'package:delivery_app/controllers/auth_controller.dart';
import 'package:delivery_app/data/models/sign_up_request.dart';
import 'package:delivery_app/util/constants/Colors.dart';
import 'package:delivery_app/util/route_helper.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/custom_toast.dart';
import 'package:delivery_app/widgets/editable_list_tile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var authController = Get.find<AuthController>();
    var signUpImages = [
      "assets/image/t.png",
      "assets/image/f.png",
      "assets/image/g.png"
    ];

    void _registration() {
      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      if (name.isEmpty) {
        showSnackbar("Name is Empty", title: "Name");
      } else if (phone.isEmpty) {
        showSnackbar("Phone is Empty", title: "Phoen");
      } else if (email.isEmpty) {
        showSnackbar("Email is Empty", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showSnackbar("Please enter valid email", title: "Email");
      } else if (password.isEmpty) {
        showSnackbar("Password is Empty", title: "Password");
      } else if (password.length < 6) {
        showSnackbar("Password should be more than 5 characters",
            title: "Password");
      } else {
        authController
            .register(SignUpRequest(
                name: name, phone: phone, email: email, password: password))
            .then((value) {
          if (value.isOk) {
            authController.loginState();
            Get.offAndToNamed(RouteHelper.getInitial());
          } else {
            showSnackbar(value.toString());
          }
        });
      }
    }

    return Scaffold(body: Obx(() {
      return !authController.isLoading.value
          ? SingleChildScrollView(
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
                        backgroundImage: AssetImage("assets/image/logo_1.png"),
                      ),
                    ),
                  ),
                  EditableTile(
                      controller: nameController,
                      hintText: "Name",
                      icon: Icons.person),
                  EditableTile(
                      controller: phoneController,
                      hintText: "Phone",
                      icon: Icons.phone_iphone),
                  EditableTile(
                      controller: emailController,
                      hintText: "Email",
                      icon: Icons.email),
                  EditableTile(
                    controller: passwordController,
                    hintText: "Password",
                    icon: Icons.password_sharp,
                    isObscure: true,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  InkWell(
                    onTap: () => {_registration()},
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(5.w)),
                        width: 40.w,
                        height: 6.h,
                        child: Center(
                          child: BigText(
                            text: "Sign up",
                            color: Colors.white,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey[500], fontSize: 16.sp),
                          text: "Have an account already?",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {Get.back()})),
                  SizedBox(
                    height: 5.h,
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.grey[500], fontSize: 14.sp),
                          text: "Signup using one of the following methods",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {Get.back()})),
                  Wrap(
                    children: List.generate(3, (index) {
                      return Container(
                        width: 20.w,
                        height: 10.h,
                        padding: EdgeInsets.all(8),
                        child: Image(
                          image: AssetImage(signUpImages[index]),
                          fit: BoxFit.contain,
                        ),
                      );
                    }),
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            );
    }));
  }
}
