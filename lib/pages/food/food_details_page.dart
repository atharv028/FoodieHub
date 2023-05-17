import 'package:badges/badges.dart';
import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/data/api/endpoints.dart';
import 'package:delivery_app/pages/cart/cart_page.dart';
import 'package:delivery_app/util/constants/strings.dart';
import 'package:delivery_app/widgets/expandable_text.dart';
import 'package:delivery_app/widgets/icons/app_icon.dart';
import 'package:delivery_app/widgets/reusable_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart' as badges;

import '../../util/constants/Colors.dart';
import '../../util/route_helper.dart';
import '../../widgets/big_text.dart';

class FoodDetails extends StatefulWidget {
  final String? pageId;
  final String? page;
  const FoodDetails({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PopularProductController>();
    var product =
        controller.popularProductList[int.parse(widget.pageId ?? "0")];
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initProduct(Get.find<CartController>(), product);
      controller.updateTotalItems();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                  width: double.maxFinite,
                  height: 35.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(AppConstants.BASE_URL +
                              Endpoints.UPLOAD_URL +
                              product.img!))))),
          GetBuilder<PopularProductController>(builder: (state) {
            return Positioned(
                top: 5.h,
                left: 5.w,
                right: 5.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if (widget.page == "cartpage") {
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
                ));
          }),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 30.h,
              child: Container(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7.w),
                          topLeft: Radius.circular(7.w)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                        titleText: product.name!,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      BigText(text: "Introduce"),
                      SizedBox(
                        height: 2.h,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableText(text: product.description!)),
                      )
                    ],
                  )))
        ],
      ),
      bottomNavigationBar: Container(
        height: 15.h,
        padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 5.w, right: 5.w),
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
                  InkWell(
                    onTap: () => controller.setQuantity(false),
                    child: const Icon(
                      Icons.remove,
                      color: AppColors.signColor,
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Obx(() {
                    return BigText(text: controller.getCartItems.toString());
                  }),
                  SizedBox(
                    width: 3.w,
                  ),
                  InkWell(
                    onTap: () => controller.setQuantity(true),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.signColor,
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                    top: 2.h, bottom: 2.h, left: 3.w, right: 3.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.w),
                    color: AppColors.mainColor),
                child: Obx(
                  (() {
                    var price = controller.getPrice;
                    print(price);
                    return InkWell(
                        onTap: () {
                          controller.addItemToCart(product);
                        },
                        child: BigText(
                          text: "\$${controller.getPrice} | Add to Cart",
                          color: Colors.white,
                        ));
                  }),
                ))
          ],
        ),
      ),
    );
  }
}
