import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:ihun_shop/src/config/constants.dart';
import 'package:ihun_shop/src/config/flutter_toast.dart';
import 'package:ihun_shop/src/config/global.dart';

import 'package:ihun_shop/src/config/styles/text_styles.dart';
import 'package:ihun_shop/src/controllers/payment_controller.dart';
import 'package:ihun_shop/src/models/get_products.dart';
import 'package:ihun_shop/src/models/orders_req.dart';
import 'package:ihun_shop/src/services/cart_helper.dart';
import 'package:ihun_shop/src/services/payment_helper.dart';
import 'package:provider/provider.dart';

import '../../config/widgets/checkout_btn.dart';
import '../../controllers/cart_provider.dart';

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
    final cartNotifier = Provider.of<CartNotifier>(context);
    final paymentNotifier = Provider.of<PaymentNotifier>(context);
    cartNotifier.checkout;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyles.defaultStyle.appBarTitle,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
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
                      contentPadding: EdgeInsets.all(10.h),
                      onTap: () {
                        cartNotifier.productIndex = index;
                        cartNotifier.checkout.insert(0, data);
                        print(cartNotifier.checkout.length);
                      },
                      leading: Stack(
                        children: [
                          CachedNetworkImage(
                              imageUrl: data.cartItem.imageUrl[0],
                              width: 60.h,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                              placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Icon(
                              cartNotifier.productIndex == index
                                  ? Feather.check_square
                                  : Feather.square,
                              color: cartNotifier.productIndex == index
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        data.cartItem.name,
                        style: TextStyles.defaultStyle.bold.setTextSize(14.sp),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.cartItem.category,
                            style: TextStyles.defaultStyle.setTextSize(12.sp),
                          ),
                          Text(
                            data.cartItem.price,
                            style: TextStyles.defaultStyle.setTextSize(12.sp),
                          ),
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
                  },
                );
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
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(10.h),
        height: 100,
        child: cartNotifier.checkout.isNotEmpty
            ? CheckoutButton(
                onTap: () {
                  final userId = Global.storageServices
                      .getString(AppConstant.STORAGE_USER_TOKEN_KEY);
                  final data = cartNotifier.checkout[0].cartItem;
                  Order order = Order(
                    userId: userId,
                    cartItems: [
                      CartItem(
                        name: data.name,
                        id: data.id,
                        price: data.price,
                        cartQuantity: 1,
                      )
                    ],
                  );
                  PaymentHelper().makePayment(order).then((value) {
                    // if (value.isNotEmpty) {
                      paymentNotifier.setPaymentUrl = value;
                      toastInfor(text: "Done: ${paymentNotifier.paymentUrl}");
                    // } else {
                    //   toastInfor(text: "Something went wrong");
                    // }
                  });
                },
                label: "Proceed to Checkout",
                color: Colors.black,
              )
            : CheckoutButton(
                onTap: () {
                  toastInfor(text: "No item in cart");
                },
                label: "Proceed to Checkout",
                color: Colors.black.withOpacity(0.5)),
      ),
    );
  }
}
