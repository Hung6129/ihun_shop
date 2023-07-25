import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_shop/src/config/styles/appstyle.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
    this.onTap,
    required this.label,
  });
  final void Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(12.h))),
          height: 50.h,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Text(
              label,
              style: appstyle(18.sp, Colors.white, FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
