import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:ihun_shop/config/styles/appstyle.dart';
import 'package:ihun_shop/models/sneaker_model.dart';
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
  final _favBox = Hive.box('fav_box');

  Future<void> _addToFav(Map<String, dynamic> item) async {
    await _favBox.add(item);
    getFavorites();
  }

  getFavorites() {
    final favProvider = Provider.of<FavoritesNotifier>(context, listen: false);
    final favData = _favBox.keys.map((key) {
      final value = _favBox.get(key);
      return {
        'key': key,
        'id': value['id'],
      };
    }).toList();
    favProvider.favorites = favData.toList();
    favProvider.ids = favProvider.favorites.map((e) => e['id']).toList();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteNotifier = Provider.of<FavoritesNotifier>(context);
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
                        if (favoriteNotifier.ids.contains(widget.sneaker.id)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FavoritePage(),
                            ),
                          );
                        } else {
                          _addToFav({
                            "id": widget.sneaker.id,
                            "name": widget.sneaker.name,
                            "category": widget.sneaker.category,
                            "imageUrl": widget.sneaker.image[0],
                            "price": widget.sneaker.price,
                          });
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
