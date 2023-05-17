import 'package:delivery_app/controllers/cart_controller.dart';
import 'package:delivery_app/data/api/endpoints.dart';
import 'package:delivery_app/data/models/history/history.dart';
import 'package:delivery_app/util/constants/Colors.dart';
import 'package:delivery_app/util/constants/strings.dart';
import 'package:delivery_app/util/route_helper.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../data/models/CartModel/cart_model.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  var controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    Widget _buildListItem(History history) {
      return Container(
        padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
        width: double.maxFinite,
        height: 18.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(
                text: DateFormat.yMMMMd()
                    .add_jm()
                    .format(DateTime.parse(history.time!))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                    direction: Axis.horizontal,
                    children: List.generate(
                        history.cart!.length <= 2 ? history.cart!.length : 3,
                        (index) {
                      return Container(
                        padding: EdgeInsets.all(4.w),
                        height: 10.h,
                        width: 22.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.w),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(AppConstants.BASE_URL +
                                    Endpoints.UPLOAD_URL +
                                    history.cart![index].img!))),
                      );
                    })),
                SizedBox(
                  height: 12.h,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SmallText(text: "Total"),
                        BigText(text: "${history.cart!.length} items"),
                        InkWell(
                          onTap: () {
                            history.cart!.forEach((element) {
                              controller.addItem(
                                  element.product!, element.quantity!);
                            });
                            Get.toNamed(RouteHelper.getCartPage());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.w, vertical: 1.h),
                            child: SmallText(
                              text: "one more",
                              color: AppColors.mainColor,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.w),
                                border: Border.all(
                                    width: 1, color: AppColors.mainColor)),
                          ),
                        )
                      ]),
                )
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Cart History"),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: InkWell(
                  onTap: () => Get.toNamed(RouteHelper.getCartPage()),
                  child: const Icon(Icons.shopping_cart_outlined))),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: controller.historyDao.getAllOrders(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    var data =
                        (snapshot.data as List<History>).reversed.toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return _buildListItem(data[index]);
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
          )
        ],
      ),
    );
  }
}
