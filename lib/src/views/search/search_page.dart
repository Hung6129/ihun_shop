import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_shop/src/config/styles/appstyle.dart';
import 'package:ihun_shop/src/models/sneaker_model.dart';
import 'package:ihun_shop/src/services/product_helper.dart';
import 'package:ihun_shop/src/views/product/product_page.dart';
import 'package:provider/provider.dart';

import '../../controllers/product_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productNotifier = Provider.of<ProductNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Searching',
          style: appstyle(18.sp, Colors.black, FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Center(
              child: TextField(
                cursorColor: Colors.black,
                controller: _controller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  suffixIcon: _ClearButton(controller: _controller),
                  labelText: 'Find your favorite sneakers',
                  border: const OutlineInputBorder(),
                  focusColor: Colors.black,
                  labelStyle: appstyle(
                    12.sp,
                    Colors.black,
                    FontWeight.w400,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onEditingComplete: () {
                  setState(() {});
                },
                onTap: () {
                  setState(() {});
                },
                onSubmitted: (value) {
                  value = _controller.text;
                },
              ),
            ),
          ),
          _controller.text.isEmpty
              ? const Center(
                  child: Text('Search for your favorite sneakers'),
                )
              : FutureBuilder<List<Sneakers>>(
                  future: ProductHelper().searchingProducts(_controller.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error ${snapshot.error}");
                    }
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No sneakers found',
                          style: appstyle(16.sp, Colors.black, FontWeight.w400),
                        ),
                      );
                    } else {
                      final data = snapshot.data as List<Sneakers>;
                      return Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final shoe = data[index];
                              return GestureDetector(
                                onTap: () {
                                  productNotifier.shoesSizes = shoe.size;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                        sneaker: shoe,
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  leading: Image.network(
                                    shoe.image[0],
                                    width: 75.w,
                                    height: 75.h,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(
                                    shoe.name,
                                    style: appstyle(
                                        16.sp, Colors.black, FontWeight.w400),
                                  ),
                                  subtitle: Text(
                                    shoe.category,
                                    style: appstyle(
                                        14.sp, Colors.black, FontWeight.w400),
                                  ),
                                  trailing: Text(
                                    shoe.price,
                                    style: appstyle(
                                        16.sp, Colors.black, FontWeight.w400),
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  },
                )
        ],
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () => controller.clear(),
      );
}
