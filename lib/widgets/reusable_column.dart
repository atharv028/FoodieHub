import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../util/constants/Colors.dart';
import 'big_text.dart';
import 'details_widget.dart';

class AppColumn extends StatelessWidget {
  final String titleText;
  const AppColumn({Key? key, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 2.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: titleText,
            size: 16.sp,
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Row(
            children: [
              Wrap(
                children: List.generate(
                    5,
                    (index) => const Icon(
                          Icons.star,
                          color: AppColors.mainColor,
                          size: 15,
                        )),
              ),
              SizedBox(
                width: 1.w,
              ),
              SmallText(text: "4.5"),
              SizedBox(
                width: 1.w,
              ),
              SmallText(text: "1567"),
              SizedBox(
                width: 1.w,
              ),
              SmallText(text: "Comments")
            ],
          ),
          SizedBox(
            height: 2.5.h,
          ),
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
    );
  }
}
