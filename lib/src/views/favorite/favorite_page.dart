import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:ihun_shop/src/config/constants.dart';
import 'package:ihun_shop/src/config/styles/appstyle.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final _favBox = Hive.box('fav_box');
  List<dynamic> favList = [];
  deleteItem(int key) async {
    await _favBox.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    final data = _favBox.keys.map((e) {
      final item = _favBox.get(e);
      return {
        'key': e,
        'id': item['id'],
        'name': item['name'],
        'category': item['category'],
        'imageUrl': item['imageUrl'],
        'price': item['price'],
      };
    }).toList();
    favList = data.reversed.toList();
    return Scaffold(
      body: favList.isEmpty
          ? Center(
              child: Text(
                'No Favorite Yet',
                style: appstyle(
                  18.sp,
                  Colors.black,
                  FontWeight.bold,
                ),
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: favList.length,
                padding: const EdgeInsets.only(top: 100),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {},
                    leading: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      imageUrl: favList[index]['imageUrl'],
                      fit: BoxFit.cover,
                    ),
                    title: Text(favList[index]['name']),
                    subtitle: Text(favList[index]['price'].toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deleteItem(favList[index]['key']);
                        id.removeWhere(
                            (element) => element == favList[index]['id']);
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
