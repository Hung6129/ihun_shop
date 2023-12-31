import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/text_styles.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
    this.onTap,
    required this.label,
    required this.color,
  });
  final void Function()? onTap;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: Container(
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(12.h))),
          height: 50.h,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Text(
              label,
              style: TextStyles.customStyle.bold.whiteText.setTextSize(20.sp),
            ),
          ),
        ),
      ),
    );
  }
}
