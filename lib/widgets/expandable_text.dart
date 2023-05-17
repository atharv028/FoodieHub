import 'package:delivery_app/util/constants/Colors.dart';
import 'package:delivery_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool isLong = true;
  bool isShown = false;
  double textHeight = 20.h;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      isLong = false;
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLong
          ? Column(
              children: [
                SmallText(
                  text:
                      isShown ? (firstHalf + secondHalf) : (firstHalf + "..."),
                  size: 11.sp,
                  color: AppColors.paraColor,
                  height: 1.5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isShown = !isShown;
                    });
                  },
                  child: Row(children: [
                    SmallText(
                      text: isShown ? "Show Less" : "Show More",
                      color: AppColors.mainColor,
                    ),
                    Icon(
                      isShown ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: AppColors.mainColor,
                    )
                  ]),
                )
              ],
            )
          : SmallText(text: widget.text),
    );
  }
}
