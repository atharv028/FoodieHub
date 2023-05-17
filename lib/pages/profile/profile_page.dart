import 'package:delivery_app/controllers/auth_controller.dart';
import 'package:delivery_app/data/repository/auth_repo.dart';
import 'package:delivery_app/util/constants/Colors.dart';
import 'package:delivery_app/util/route_helper.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/icons/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text("Profile"),
      ),
      body: Obx(() {
        return authController.isLoggedIn.value
            ? Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 2.h),
                      child: AppIcon(
                        icon: Icons.person,
                        size: 20.h,
                        iconSize: 15.h,
                        bgColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //Profile
                          ListTile(
                            tileColor: Colors.white,
                            contentPadding: EdgeInsets.all(10),
                            leading: AppIcon(
                              icon: Icons.person,
                            ),
                            title: BigText(text: "Atharv Tare"),
                          ),
                          //Name
                          ListTile(
                            tileColor: Colors.white,
                            contentPadding: EdgeInsets.all(10),
                            leading: AppIcon(
                              icon: Icons.phone,
                              bgColor: AppColors.iconColor2,
                              iconColor: Colors.white,
                            ),
                            title: BigText(text: "+917000897944"),
                          ),
                          //Phone
                          ListTile(
                            tileColor: Colors.white,
                            contentPadding: EdgeInsets.all(10),
                            leading: AppIcon(
                                icon: Icons.email,
                                bgColor: AppColors.iconColor2,
                                iconColor: Colors.white),
                            title: BigText(text: "atharvtare512@gmail.com"),
                          ),
                          //Address
                          ListTile(
                            tileColor: Colors.white,
                            contentPadding: EdgeInsets.all(10),
                            leading: AppIcon(
                                icon: Icons.location_city,
                                bgColor: AppColors.iconColor2,
                                iconColor: Colors.white),
                            title: BigText(text: "Burhanpur, Madhya Pradesh"),
                          ),
                          //Message
                          ListTile(
                            onTap: () async {
                              await Get.find<AuthRepo>().logout();
                              authController.isLoggedIn.value = false;
                              Get.toNamed(RouteHelper.getInitial());
                            },
                            tileColor: Colors.white,
                            contentPadding: EdgeInsets.all(10),
                            leading: AppIcon(
                                icon: Icons.logout,
                                bgColor: AppColors.iconColor2,
                                iconColor: Colors.white),
                            title: BigText(text: "Logout"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.getSignInPage());
                },
                child: Center(
                  child: BigText(text: "Please Log in"),
                ));
      }),
    );
  }
}
