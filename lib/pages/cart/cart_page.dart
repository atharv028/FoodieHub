import 'package:delivery_app/controllers/auth_controller.dart';
import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommended_product_controller.dart';
import 'package:delivery_app/data/api/endpoints.dart';
import 'package:delivery_app/data/models/CartModel/cart_model.dart';
import 'package:delivery_app/util/constants/Colors.dart';
import 'package:delivery_app/util/constants/strings.dart';
import 'package:delivery_app/util/route_helper.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/icons/app_icon.dart';
import 'package:delivery_app/widgets/no_data_page.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  var controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.updateTotalAmount();
    });
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 7.h,
                left: 5.w,
                right: 3.w,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back,
                        iconColor: Colors.white,
                        bgColor: AppColors.mainColor,
                        iconSize: 5.w,
                      ),
                    ),
                    SizedBox(
                      width: 54.w,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        bgColor: AppColors.mainColor,
                        iconSize: 5.w,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      iconColor: Colors.white,
                      bgColor: AppColors.mainColor,
                      iconSize: 5.w,
                    )
                  ],
                )),
            Positioned(
                top: 12.h,
                left: 5.w,
                right: 5.w,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: 1.h),
                  // color: Colors.red,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (controller) {
                        return controller.cartItems.values.isNotEmpty
                            ? ListView.builder(
                                itemCount: controller.cartItems.values.length,
                                itemBuilder: ((context, index) {
                                  return buildListItem(controller
                                      .cartItems.values
                                      .toList()[index]);
                                }))
                            : const NoDataPage(text: "No Item found");
                      },
                    ),
                  ),
                ))
          ],
        ),
        bottomNavigationBar: Container(
            height: 15.h,
            padding:
                EdgeInsets.only(top: 2.h, bottom: 2.h, left: 5.w, right: 5.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.w),
                    topRight: Radius.circular(10.w)),
                color: AppColors.buttonBackgroundColor),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 2.h, bottom: 2.h, left: 2.5.w, right: 2.5.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.w),
                        color: Colors.white),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 3.w,
                        ),
                        Obx(() {
                          return BigText(
                              text: "\$ ${controller.totalAmount.value}");
                        }),
                        SizedBox(
                          width: 3.w,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (Get.find<AuthController>().isLoggedIn.value) {
                        controller.addItemsToHistory();
                      } else {
                        Get.toNamed(RouteHelper.getSignInPage());
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.only(
                            top: 2.h, bottom: 2.h, left: 3.w, right: 3.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.w),
                            color: AppColors.mainColor),
                        child: BigText(
                          text: "Checkout",
                          color: Colors.white,
                        )),
                  )
                ])));
  }

  Widget buildListItem(Cart cart) {
    return InkWell(
      onTap: () {
        var isPopular = Get.find<PopularProductController>()
            .popularProductList
            .indexWhere(((element) => element.name! == cart.product!.name));

        if (isPopular < 0) {
          var isRecommended = Get.find<RecommendedProductController>()
              .recommendedProductList
              .indexWhere(((element) => element.name! == cart.product!.name));
          Get.toNamed(
              RouteHelper.getRecommendedFood(isRecommended, "cartpage"));
        } else {
          Get.toNamed(RouteHelper.getPopularFood(isPopular, "cartpage"));
        }
      },
      child: Container(
        width: double.maxFinite,
        height: 15.h,
        child: Row(
          children: [
            Container(
              width: 20.w,
              height: 10.h,
              padding: EdgeInsets.only(bottom: 2.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.w),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          Endpoints.UPLOAD_URL +
                          cart.img!))),
            ),
            SizedBox(
              width: 2.5.w,
            ),
            Expanded(
                child: Container(
              height: 10.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BigText(
                    text: cart.name!,
                    size: 14.sp,
                    color: Colors.black54,
                  ),
                  SmallText(
                    text: "Spicy",
                    color: Colors.black12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: "\$ ${cart.price}",
                        size: 14.sp,
                        color: Colors.redAccent,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.w),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.addItem(
                                    controller.cartItems[cart.id!]!.product!,
                                    -1);
                              },
                              child: const Icon(
                                Icons.remove,
                                color: AppColors.signColor,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Obx(() => BigText(
                                text: controller
                                    .itemQuantity(cart.id)
                                    .value
                                    .toString())),
                            SizedBox(
                              width: 3.w,
                            ),
                            InkWell(
                              onTap: () {
                                controller.addItem(
                                    controller.cartItems[cart.id]!.product!, 1);
                              },
                              child: const Icon(
                                Icons.add,
                                color: AppColors.signColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
