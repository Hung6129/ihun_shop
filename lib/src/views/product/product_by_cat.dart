import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:ihun_shop/src/config/styles/appstyle.dart';
import 'package:ihun_shop/src/models/sneaker_model.dart';
import 'package:ihun_shop/src/services/helper.dart';

import '../../config/widgets/category_btn.dart';
import '../../config/widgets/custom_spacer.dart';
import '../../config/widgets/latest_shoes.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFemaleSneakers();
  }

  void getkids() {
    _kids = Helper().getKidsSneakers();
  }

  @override
  void initState() {
    super.initState();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
    getMale();
    getkids();

    getFemale();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/top_image.png"),
                      fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            AntDesign.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            FontAwesome.sliders,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: appstyle(24, Colors.white, FontWeight.bold),
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
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.175,
                  left: 16,
                  right: 12),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(controller: _tabController, children: [
                  LatestShoes(male: _male),
                  LatestShoes(male: _female),
                  LatestShoes(male: _kids),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double sildeSalue = 100;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      useSafeArea: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.h),
              topRight: Radius.circular(25.h),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.h),
              height: 5,
              width: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.black38,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  const CustomSpacer(),
                  Text(
                    "Filter",
                    style: appstyle(25.sp, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  Text(
                    "Gender",
                    style: appstyle(15.sp, Colors.black, FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    spacing: 10,
                    children: [
                      CategoryBtn(
                        label: "Men",
                        buttonClr: Colors.black,
                      ),
                      CategoryBtn(
                        label: "Women",
                        buttonClr: Colors.grey,
                      ),
                      CategoryBtn(
                        label: "Kids",
                        buttonClr: Colors.grey,
                      ),
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    "Category",
                    style: appstyle(15.sp, Colors.black, FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    spacing: 10,
                    children: [
                      CategoryBtn(
                        label: "Shoes",
                        buttonClr: Colors.black,
                      ),
                      CategoryBtn(
                        label: "Apparrels",
                        buttonClr: Colors.grey,
                      ),
                      CategoryBtn(
                        label: "Accessories",
                        buttonClr: Colors.grey,
                      ),
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    "Price",
                    style: appstyle(15.sp, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  Slider(
                      value: sildeSalue,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      thumbColor: Colors.black,
                      max: 500,
                      divisions: 50,
                      label: sildeSalue.toString(),
                      secondaryTrackValue: 200,
                      onChanged: (double value) {}),
                  const CustomSpacer(),
                  Text(
                    "Brand",
                    style: appstyle(15.sp, Colors.black, FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 70,
                    child: ListView.builder(
                        itemCount: brand.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: Image.asset(
                                brand[index],
                                height: 60,
                                width: 80,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
