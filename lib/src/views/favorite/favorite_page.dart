import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ihun_shop/src/config/styles/appstyle.dart';
import 'package:ihun_shop/src/config/styles/text_styles.dart';
import 'package:ihun_shop/src/controllers/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key, required this.autoLeading});
  final bool autoLeading;
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final favNotifier = Provider.of<FavoritesNotifier>(context);
    favNotifier.getAllData();
    return Scaffold(
      appBar: AppBar(
        leading: widget.autoLeading
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
        automaticallyImplyLeading: widget.autoLeading,
        title: Text(
          "My Favorites",
          style: TextStyles.defaultStyle.appBarTitle,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: favNotifier.fav.isEmpty
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
                itemCount: favNotifier.fav.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    onTap: () {},
                    leading: CachedNetworkImage(
                      height: 75.h,
                      width: 75.w,
                      imageUrl: favNotifier.fav[index]['imageUrl'],
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      favNotifier.fav[index]['name'],
                      style: appstyle(14.sp, Colors.black, FontWeight.w500),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(favNotifier.fav[index]['category'].toString()),
                        Text(favNotifier.fav[index]['price'].toString()),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        favNotifier
                            .removeFromFav(favNotifier.fav[index]['key']);
                        favNotifier.ids.remove(favNotifier.fav[index]['id']);
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
