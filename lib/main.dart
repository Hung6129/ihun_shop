import 'package:flutter/material.dart';

import 'package:ihun_shop/src/ihun_shop.dart';

import 'src/config/global.dart';

// entrypoint of the app
void main() async {
  await Global.init();
  //method that initializes the app and run top level wigets
  runApp(iHunShopEnter);
}
