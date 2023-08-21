import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../services/storage_services.dart';

/// Make a global class to store all the global variables
class Global {
  static late StorageServices storageServices;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await Hive.openBox('fav_box');
    storageServices = await StorageServices().init();
  }
}
