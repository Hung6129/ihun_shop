import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:ihun_shop/config/styles/appstyle.dart';
import 'package:ihun_shop/models/sneaker_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.sneaker,
  });

  final Sneakers sneaker;

  @override
  Widget build(BuildContext context) {
    bool selected = true;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: 250.w,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(sneaker.image[0]),
                      fit: BoxFit.cover,
                    )),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: null,
                      child: const Icon(MaterialCommunityIcons.heart_outline),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sneaker.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: appstyleWithHt(
                        25.sp,
                        Colors.black,
                        FontWeight.bold,
                        1.1,
                      ),
                    ),
                    Text(
                      sneaker.category,
                      style: appstyleWithHt(
                          15.sp, Colors.grey, FontWeight.bold, 1.5),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sneaker.price,
                      style: appstyle(20.sp, Colors.black, FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          "Colors",
                          style: appstyle(15.sp, Colors.grey, FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ChoiceChip(
                          label: const Text(" "),
                          selected: selected,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
