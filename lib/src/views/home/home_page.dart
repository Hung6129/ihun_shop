import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_shop/src/config/styles/text_styles.dart';
import 'package:ihun_shop/src/controllers/authen_provider.dart';
import 'package:ihun_shop/src/controllers/product_provider.dart';

import 'package:provider/provider.dart';

import '../../config/widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    authNotifier.getIsLoggedIn;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 100.h,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Athletics Shoes", style: TextStyles.defaultStyle.appTitle),
              Text("Collection", style: TextStyles.customStyle.appTitle),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                child: Text("Men", style: TextStyles.customStyle.appBarTitle),
              ),
              Tab(
                child: Text("Women", style: TextStyles.customStyle.appBarTitle),
              ),
              Tab(
                child: Text("Kid", style: TextStyles.customStyle.appBarTitle),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Consumer<ProductNotifier>(
            builder: (context, productNotifier, child) => Container(
              padding: EdgeInsets.only(left: 10.w, top: 30.h),
              height: MediaQuery.of(context).size.height - 150,
              width: MediaQuery.of(context).size.width,
              child: TabBarView(
                controller: _tabController,
                children: [
                  HomeWidget(
                    male: productNotifier.getMale(),
                    tabIndex: 0,
                  ),
                  HomeWidget(
                    male: productNotifier.getFemale(),
                    tabIndex: 1,
                  ),
                  HomeWidget(
                    male: productNotifier.getkids(),
                    tabIndex: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
