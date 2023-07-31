import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:ihun_shop/src/config/flutter_toast.dart';

import 'package:ihun_shop/src/config/styles/appstyle.dart';
import 'package:ihun_shop/src/controllers/authen_provider.dart';

import 'package:ihun_shop/src/models/sneaker_model.dart';
import 'package:provider/provider.dart';

import '../../controllers/favorites_provider.dart';
import '../../views/favorite/favorite_page.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.sneaker,
  });
  final Sneakers sneaker;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final favoriteNotifier = Provider.of<FavoritesNotifier>(context);
    final authNotifier = Provider.of<AuthNotifier>(context);
    favoriteNotifier.getFavorites();
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
                        image: NetworkImage(widget.sneaker.image[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () {
                        if (authNotifier.isLoggedIn == true) {
                          if (favoriteNotifier.ids
                              .contains(widget.sneaker.id)) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FavoritePage(
                                  autoLeading: true,
                                ),
                              ),
                            );
                          } else {
                            favoriteNotifier.addToFav({
                              "id": widget.sneaker.id,
                              "name": widget.sneaker.name,
                              "category": widget.sneaker.category,
                              "imageUrl": widget.sneaker.image[0],
                              "price": widget.sneaker.price,
                            });
                          }
                        } else {
                          toastInfor(text: "Please login to add to favorite");
                        }
                      },
                      child: favoriteNotifier.ids.contains(widget.sneaker.id)
                          ? const Icon(
                              AntDesign.heart,
                              color: Colors.black,
                            )
                          : const Icon(
                              AntDesign.hearto,
                              color: Colors.black,
                            ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.sneaker.name,
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
                      widget.sneaker.category,
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
                      widget.sneaker.price,
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
