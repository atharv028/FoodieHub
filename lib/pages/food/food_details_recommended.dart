import 'package:badges/badges.dart';
import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommended_product_controller.dart';
import 'package:delivery_app/data/api/endpoints.dart';
import 'package:delivery_app/pages/cart/cart_page.dart';
import 'package:delivery_app/util/constants/Colors.dart';
import 'package:delivery_app/util/constants/strings.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

import '../../util/route_helper.dart';
import '../../widgets/icons/app_icon.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final String? pageId;
  final String? page;
  RecommendedFoodDetails({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RecommendedProductController>();
    var product = controller.recommendedProductList[int.parse(pageId ?? "0")];
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initProduct(Get.find<CartController>(), product);
      controller.updateTotalItems();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 8.h,
            title: GetBuilder<RecommendedProductController>(builder: (state) {
              print(state.totalItems);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (page == "cartpage") {
                        Get.back();
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back,
                      size: 10.w,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: (state.totalItems != null
                        ? badges.Badge(
                            showBadge: (state.totalItems != null &&
                                state.totalItems > 0),
                            badgeContent: BigText(
                              text: state.totalItems.toString(),
                              color: Colors.white,
                            ),
                            animationType: BadgeAnimationType.scale,
                            badgeColor: AppColors.mainColor,
                            child: AppIcon(
                              icon: Icons.shopping_cart_outlined,
                              size: 11.w,
                            ),
                          )
                        : AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            size: 11.w,
                          )),
                  )
                ],
              );
            }),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(3.h),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.w),
                      topRight: Radius.circular(5.w)),
                  color: Colors.white,
                ),
                child: Center(
                    child: BigText(
                  text: product.name!,
                  size: 16.sp,
                )),
              ),
            ),
            backgroundColor: AppColors.yellowColor,
            pinned: true,
            expandedHeight: 30.h,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
              AppConstants.BASE_URL + Endpoints.UPLOAD_URL + product.img!,
              fit: BoxFit.cover,
              width: double.maxFinite,
            )),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableText(text: product.description!),
                  margin: EdgeInsets.only(left: 5.w, right: 5.w),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    controller.setQuantity(false);
                  },
                  child: AppIcon(
                    icon: Icons.remove,
                    bgColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: 5.w,
                  ),
                ),
                Obx(() {
                  return BigText(
                    text:
                        "\$${product.price} X ${controller.getQuantity.value}",
                    color: AppColors.blackTextColor,
                    size: 16.sp,
                  );
                }),
                InkWell(
                  onTap: () {
                    controller.setQuantity(true);
                  },
                  child: AppIcon(
                    icon: Icons.add,
                    bgColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: 5.w,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 15.h,
            padding: EdgeInsets.only(
                top: 1.5.h, bottom: 1.5.h, left: 5.w, right: 5.w),
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
                        top: 2.h, bottom: 2.h, left: 5.w, right: 5.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.w),
                        color: Colors.white),
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    )),
                Obx(
                  () {
                    return Container(
                      padding: EdgeInsets.only(
                          top: 2.h, bottom: 2.h, left: 3.w, right: 3.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.w),
                          color: AppColors.mainColor),
                      child: InkWell(
                        onTap: () {
                          controller.addItemToCart(product);
                        },
                        child: BigText(
                          text: "\$${controller.getPrice.value} | Add to Cart",
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
