import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class EditableTile extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isObscure;
  const EditableTile(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.icon,
      this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h, bottom: 2.h),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 1.w,
                offset: Offset(1, 10),
                color: Colors.grey.withOpacity(0.2)),
          ],
          borderRadius: BorderRadius.circular(10.w)),
      child: TextField(
          obscureText: isObscure,
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(icon),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.w),
                  borderSide:
                      const BorderSide(width: 1.0, color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.w),
                  borderSide:
                      const BorderSide(width: 1.0, color: Colors.white)))),
    );
  }
}
