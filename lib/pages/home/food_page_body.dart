import 'package:delivery_app/controllers/popular_product_controller.dart';
import 'package:delivery_app/controllers/recommended_product_controller.dart';
import 'package:delivery_app/data/api/endpoints.dart';
import 'package:delivery_app/data/models/popular_item/product.dart';
import 'package:delivery_app/pages/food/food_details_page.dart';
import 'package:delivery_app/pages/home/main_food_page.dart';
import 'package:delivery_app/util/constants/Colors.dart';
import 'package:delivery_app/util/constants/strings.dart';
import 'package:delivery_app/util/dimensions.dart';
import 'package:delivery_app/util/route_helper.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/details_widget.dart';
import 'package:delivery_app/widgets/reusable_column.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sizer/sizer.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double scaleFactor = 0.8;
  double height = Dimensions.pageViewConatiner;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(
          builder: (controller) {
            return controller.isLoaded
                ? Container(
                    height: 40.h,
                    child: PageView.builder(
                        itemCount: controller.popularProductList.length,
                        controller: pageController,
                        itemBuilder: (context, pos) {
                          return _buildPageItem(
                              pos, controller.popularProductList[pos]);
                        }))
                : SizedBox(
                    height: 40.h,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    ),
                  );
          },
        ),
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.length > 0
                ? popularProducts.popularProductList.length
                : 1,
            position: _currPageValue,
            decorator: const DotsDecorator(
                size: Size.square(9.0),
                activeColor: AppColors.mainColor,
                activeSize: Size(18.0, 8.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(5), right: Radius.circular(5)))),
          );
        }),
        // Popular Text
        SizedBox(
          height: 3.h,
        ),
        Container(
          margin: EdgeInsets.only(left: 7.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                text: "Recommended",
                size: 15.sp,
              ),
              SizedBox(
                width: 2.w,
              ),
              BigText(
                text: ".",
                size: 15.sp,
                color: Colors.black26,
              ),
              SizedBox(
                width: 2.w,
              ),
              SmallText(
                text: "Food Pairing",
                color: Colors.black26,
              )
            ],
          ),
        ),
        GetBuilder<RecommendedProductController>(
          builder: (controller) {
            if (controller.isLoaded) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.recommendedProductList.length,
                  itemBuilder: (context, pos) {
                    return _buildListItem(
                        pos, controller.recommendedProductList[pos]);
                  });
            } else {
              return SizedBox(
                height: 40.h,
                child: const Center(
                    child:
                        CircularProgressIndicator(color: AppColors.mainColor)),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildListItem(int pos, Product product) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getRecommendedFood(pos, "home"));
      },
      child: Container(
        margin: EdgeInsets.only(left: 3.w, right: 5.w, top: 2.h, bottom: 2.h),
        child: Row(children: [
          Container(
              height: 15.h,
              width: 30.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(AppConstants.BASE_URL +
                        Endpoints.UPLOAD_URL +
                        product.img!),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.white38)),
          Expanded(
            child: Container(
              height: 10.h,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.white),
              child: Padding(
                padding: EdgeInsets.only(left: 2.w, top: 1.h, bottom: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BigText(
                      text: product.name!,
                      size: 14.sp,
                    ),
                    // SizedBox(
                    //   height: 1.h,
                    // ),
                    Text(
                      product.description!,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 9.sp, overflow: TextOverflow.ellipsis),
                    ),
                    // SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        IconAndTextWidget(
                            icon: Icons.circle_sharp,
                            text: "Normal",
                            iconColor: AppColors.iconColor1),
                        IconAndTextWidget(
                            icon: Icons.location_on,
                            text: "1.7 Km",
                            iconColor: AppColors.mainColor),
                        IconAndTextWidget(
                            icon: Icons.access_time_rounded,
                            text: "32min",
                            iconColor: AppColors.iconColor2)
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildPageItem(int pos, Product product) {
    Matrix4 matrix = Matrix4.identity();

    if (pos == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - pos) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (pos == _currPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (_currPageValue - pos + 1) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (pos == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - pos) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: InkWell(
        onTap: () {
          Get.toNamed(RouteHelper.getPopularFood(pos, "home"));
        },
        child: Stack(
          children: [
            Container(
              height: 25.h,
              margin: EdgeInsets.only(left: 2.h, right: 2.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: pos.isEven
                      ? const Color(0xFF69c5df)
                      : const Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          Endpoints.UPLOAD_URL +
                          product.img!))),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 15.h,
                  margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 4.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xFFe8e8e8),
                            blurRadius: 5.0,
                            offset: Offset(0, 5)),
                        BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                        BoxShadow(color: Colors.white, offset: Offset(5, 0))
                      ]),
                  child: AppColumn(titleText: product.name!)),
            )
          ],
        ),
      ),
    );
  }
}
