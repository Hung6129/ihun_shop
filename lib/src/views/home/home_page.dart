import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_shop/src/controllers/authen_provider.dart';
import 'package:ihun_shop/src/controllers/product_provider.dart';

import 'package:provider/provider.dart';

import '../../config/widgets/home_widget.dart';

import '../../config/styles/appstyle.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                child: Container(
                  padding: EdgeInsets.only(left: 8.w, bottom: 15.h),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Athletics Shoes",
                        style: appstyleWithHt(
                            35.sp, Colors.black, FontWeight.bold, 1.5),
                      ),
                      Text(
                        "Collection",
                        style: appstyleWithHt(
                            35.sp, Colors.black, FontWeight.bold, 1.2),
                      ),
                      TabBar(
                        padding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.black,
                        labelStyle: appstyle(24, Colors.black, FontWeight.bold),
                        unselectedLabelColor: Colors.grey.withOpacity(0.3),
                        tabs: const [
                          Tab(
                            text: "Men Shoes",
                          ),
                          Tab(
                            text: "Women Shoes",
                          ),
                          Tab(
                            text: "Kids Shoes",
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<ProductNotifier>(
                builder: (context, productNotifier, child) => Padding(
                  padding: EdgeInsets.only(top: 180.h),
                  child: Container(
                    padding: EdgeInsets.only(left: 10.w),
                    child: TabBarView(controller: _tabController, children: [
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
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
