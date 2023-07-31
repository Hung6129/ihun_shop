import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:ihun_shop/src/config/flutter_toast.dart';

import 'package:ihun_shop/src/config/styles/appstyle.dart';
import 'package:ihun_shop/src/config/widgets/checkout_btn.dart';
import 'package:ihun_shop/src/controllers/authen_provider.dart';
import 'package:ihun_shop/src/controllers/product_provider.dart';

import 'package:ihun_shop/src/models/sneaker_model.dart';
import 'package:ihun_shop/src/services/cart_helper.dart';
import 'package:ihun_shop/src/views/favorite/favorite_page.dart';

import 'package:provider/provider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../controllers/favorites_provider.dart';

// ignore: must_be_immutable
class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.sneaker,
  });
  final Sneakers sneaker;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

  final _cartBox = Hive.box('cart_box');

  int _current = 0;

  Future<void> _createCart(Map<dynamic, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  @override
  Widget build(BuildContext context) {
    final favoriteNotifier = Provider.of<FavoritesNotifier>(context);
    final authNotifier = Provider.of<AuthNotifier>(context);
    favoriteNotifier.getFavorites();
    return Consumer<ProductNotifier>(
      builder: (context, productNotifier, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                title: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          productNotifier.shoeSizes.clear();
                        },
                        child: const Icon(
                          AntDesign.close,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
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
                    ],
                  ),
                ),
                pinned: true,
                floating: true,
                snap: true,
                backgroundColor: Colors.transparent,
                expandedHeight: MediaQuery.of(context).size.height,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.sneaker.image.length,
                            controller: pageController,
                            onPageChanged: (page) {
                              productNotifier.activePage = page;
                              _current = page;
                            },
                            itemBuilder: (context, int index) {
                              return Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.39,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.grey.shade300,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.sneaker.image[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: DotsIndicator(
                                      dotsCount: widget.sneaker.image.length,
                                      position: _current,
                                      decorator: DotsDecorator(
                                        size: Size.square(5.h),
                                        activeSize: Size(25.w, 5.h),
                                        activeShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      Positioned(
                        bottom: 40.h,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.645,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.sneaker.name,
                                    style: appstyle(
                                        30.sp, Colors.black, FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.sneaker.category,
                                        style: appstyle(
                                            20, Colors.grey, FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      RatingBar.builder(
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 22,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 1),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.sneaker.price,
                                        style: appstyle(
                                            26, Colors.black, FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Colors",
                                            style: appstyle(18, Colors.black,
                                                FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const CircleAvatar(
                                            radius: 7,
                                            backgroundColor: Colors.black,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const CircleAvatar(
                                            radius: 7,
                                            backgroundColor: Colors.red,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Select sizes",
                                            style: appstyle(20, Colors.black,
                                                FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "View size guide",
                                            style: appstyle(20, Colors.grey,
                                                FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        child: ListView.builder(
                                            itemCount: productNotifier
                                                .shoeSizes.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final sizes = productNotifier
                                                  .shoeSizes[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                ),
                                                child: ChoiceChip(
                                                  disabledColor: Colors.white,
                                                  label: Text(
                                                    sizes['size'],
                                                    style: appstyle(
                                                        14.sp,
                                                        sizes['isSelected']
                                                            ? Colors.white
                                                            : Colors.black,
                                                        FontWeight.w500),
                                                  ),
                                                  selectedColor: Colors.black,
                                                  selected: sizes['isSelected'],
                                                  onSelected: (newState) {
                                                    if (productNotifier.sizes
                                                        .contains(
                                                            sizes['size'])) {
                                                      productNotifier.sizes
                                                          .remove(
                                                              sizes['size']);
                                                    } else {
                                                      productNotifier.sizes
                                                          .add(sizes['size']);
                                                    }

                                                    productNotifier
                                                        .toggleCheck(index);
                                                  },
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    child: Divider(
                                      indent: 5,
                                      endIndent: 5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    widget.sneaker.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: appstyle(
                                        14.sp, Colors.black, FontWeight.w700),
                                  ),
                                  Text(
                                    widget.sneaker.description,
                                    textAlign: TextAlign.justify,
                                    maxLines: 4,
                                    style: appstyle(
                                        14, Colors.black, FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: CheckoutButton(
              onTap: () async {
                if (authNotifier.isLoggedIn == true) {
                  CartHelper().addToCart(widget.sneaker.id, 1);
                } else {
                  toastInfor(text: "Please login to add to cart");
                }
              },
              label: "Add to Cart",
            ),
          ),
        );
      },
    );
  }
}
