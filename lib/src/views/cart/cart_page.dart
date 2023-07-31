import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:ihun_shop/src/config/styles/appstyle.dart';
import 'package:ihun_shop/src/config/styles/text_styles.dart';
import 'package:ihun_shop/src/models/get_products.dart';
import 'package:ihun_shop/src/services/cart_helper.dart';

import '../../config/widgets/checkout_btn.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Product>> cart;
  @override
  void initState() {
    super.initState();
    cart = CartHelper().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    AntDesign.close,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "My Cart",
                  style: appstyle(36, Colors.black, FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: FutureBuilder<List<Product>>(
                      future: CartHelper().getCart(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final cart = snapshot.data as List<Product>;
                          if (cart.isNotEmpty) {
                            return ListView.builder(
                                itemCount: cart.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  final data = cart[index];
                                  return ListTile(
                                    contentPadding: const EdgeInsets.all(10),
                                    onTap: () {},
                                    leading: CachedNetworkImage(
                                      height: 75.h,
                                      width: 75.w,
                                      imageUrl: data.cartItem.imageUrl[0],
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(
                                      data.cartItem.name,
                                      style: appstyle(
                                          14.sp, Colors.black, FontWeight.w500),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data.cartItem.category),
                                        Text(data.cartItem.price),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            AntDesign.minus,
                                            size: 20,
                                          ),
                                        ),
                                        Text(
                                          data.quantity.toString(),
                                          style: TextStyles.defaultStyle.bold,
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            AntDesign.plus,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          } else {
                            return const Center(
                              child: Text("No item in cart"),
                            );
                          }
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Error"),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                      },
                    ))
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CheckoutButton(label: "Proceed to Checkout"),
            ),
          ],
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
