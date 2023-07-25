import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_shop/src/config/styles/appstyle.dart';

class CategoryBtn extends StatelessWidget {
  const CategoryBtn(
      {super.key, this.onPress, required this.buttonClr, required this.label});
  final void Function()? onPress;
  final Color buttonClr;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonClr,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9.h),
        ),
      ),
      child: Text(
        label,
        style: appstyle(14.sp, buttonClr, FontWeight.w600),
      ),
    )
        // Container(
        //   height: 45.h,
        //   padding: EdgeInsets.symmetric(horizontal: 10.w),
        //   decoration: BoxDecoration(
        //       border: Border.all(
        //         width: 1,
        //         color: buttonClr,
        //         style: BorderStyle.solid,
        //       ),
        //       borderRadius: BorderRadius.all(Radius.circular(9.h))),
        //   child: Center(
        //     child: Text(
        //       label,
        //       overflow: TextOverflow.ellipsis,
        //       maxLines: 1,
        //       style: appstyle(14.sp, buttonClr, FontWeight.w600),
        //     ),
        //   ),
        // )
        ;
  }
}
