import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:market/controllers/lang_controller.dart';
import 'package:market/core/info_widget.dart';
import 'package:market/views/screens/categories/veiw_all_screen.dart';
import 'package:market/views/screens/home/search_area_des.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Assistants/globals.dart';
import '../../../Data/data_for_ui.dart';
import '../../../controllers/address_location_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../address/address_on_map.dart';
import '../../address/list_addresses.dart';
import '../../address/search_address_screen.dart';
import '../../widgets/departments_shpe.dart';
import '../../widgets/flash_messages_screen.dart';
import '../../widgets/horizontal_listOfProducts.dart';
import '../show_product/product_details.dart';
import '../show_product/product_item.dart';
import '../../address/address_area.dart';
import 'head_home_screen.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'dart:developer';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductsController productController = Get.find();
  final AddressController addressController = Get.find();
  final LangController langController = Get.find();

  ScrollController? scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(listenBottom);
  }

  void listenBottom() {
    if (kDebugMode) {}
    //final direction = controller.position.userScrollDirection;
    if (scrollController!.position.pixels >= 200) {
      addressController.showHideAddress(false);
    } else {
      addressController.showHideAddress(true);
    }
  }

  static const defaultPadding = 20.0;
  static const cartBarHeight = 100.0;
  static const headerHeight = 85.0;
  var images = [
  Image.asset(
  'assets/images/pexels-markus-spiske-3806753.jpg',
  fit: BoxFit.fill),
  Image.asset('assets/images/productsample.jpg',
  fit: BoxFit.fill),
  Image.asset(
  'assets/images/Qatar-Online-Marketing-Profile.jpg',
  fit: BoxFit.fill),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = Get.size;
    return Container(
        color: myHexColor5.withOpacity(0.2),

        child: SafeArea(
            child: Scaffold(
                body: InfoWidget(
                  builder: (context, deviceInfo) {
                    print('device type is : ${deviceInfo.deviceType}');

                    print('wed height : ${deviceInfo.localHeight}');
                    print('wed width : ${deviceInfo.localWidth}');

                    return Stack(children: [
          Positioned(
              top: 6.h,
              child: InkWell(
                      onTap: () async {

                      },
                      child: headHomeScreen(MediaQuery.of(context)))),
          Positioned(top: 54.h,right:12.w , width: screenSize.width.w, child: SearchAreaDesign()),

          Positioned(
            top: screenSize.height <650? screenSize.height *0.1+29.h:screenSize.height *0.1+39.h,
            child: Obx(() => AnimatedContainer(
                      duration: 400.milliseconds,
                      height: addressController.addressWidgetSize.value,
                      child: InkWell(
                        onTap: () {
                          addressController.getMyAddresses();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListAddresses(
                                        fromCart: false,
                                        fromAccount: false,
                                      )));
                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 10.0.w),
                          child: addressHomeScreen(MediaQuery.of(context)),
                        ),
                      ),
                    )),
          ),
          Positioned(
            top:screenSize.height <650 ? screenSize.height *0.1+48.h:screenSize.height *0.1+58.h,
            width: screenSize.width,

            child: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              height: screenSize.height.h,
              width: screenSize.width.w,
              child: Obx(()=>ListView(
                      controller: scrollController,
                      padding: EdgeInsets.zero,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 170.0.h,
                          width:screenSize.width,
                          child: CarouselSlider(
                            options: CarouselOptions(height: screenSize.width,
                            viewportFraction: 1,
                              autoPlay: true
                            ),
                            items: images.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                      width: screenSize.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white
                                      ),
                                      child: i
                                  );
                                },
                              );
                            }).toList(),
                        ),),
                         SizedBox(
                          height: 22.0.h,
                        ),
                         Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                          child: Text(
                            'Shop by category_txt'.tr,
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                          ),
                        ),
                        SizedBox(
                            height: screenSize.height * 0.2 + 95.h,
                            width: 400.w,
                            child: _buildDepartmentsList()),
                        SizedBox(
                          height: screenSize.height * 0.1 - 64.h,
                        ),
                        Row(
                          children: [
                             Padding(
                              padding: EdgeInsets.only(
                                top: 0.0,
                                left: 12,
                                right: 12
                              ),
                              child: Text(
                                'Latest Products_txt'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14.sp),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewAllScreen(dep: 1, list:productController.latestProducts.value )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, left: 0, right: 0.0),
                                child: Text(
                                  'View All_txt'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                      color: Colors.grey[700]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 8, right: 8),
                              child: Icon(
                                langController.appLocal == 'en'?Icons.arrow_forward_ios_rounded:Icons.arrow_back_ios_new_rounded,
                                size: 14,
                                color: Colors.grey[700],
                              ),
                            )
                          ],
                        ),
                         SizedBox(
                          height: 6.0.h,
                        ),
                        productController.gotProductsByCat.value ==true ?  Container(child: buildHorizontalListOfProducts(false)):SizedBox(
                            height: 400.h,
                            child: buildProductShimmer()),
                         SizedBox(
                          height: 12.0.h,
                        ),
                        Row(
                          children: [
                             Padding(
                               padding: EdgeInsets.only(top: 0.0, left: 12,right: 12),
                              child: Text(
                                'Recommended for you_txt'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14.sp),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewAllScreen(dep: 1, list:productController.recommendedProducts.value )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, left: 0, right: 0.0),
                                child: Text(
                                  'View All_txt'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                      color: Colors.grey[700]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 8, right: 8),
                              child: Icon(
                                langController.appLocal == 'en'?Icons.arrow_forward_ios_rounded:Icons.arrow_back_ios_new_rounded,
                                size: 14.sp,
                                color: Colors.grey[700],
                              ),
                            )
                          ],
                        ),
                         SizedBox(
                          height: 6.0.h,
                        ),
                        _buildHorizontalListOfRecommendedProducts(),
                         SizedBox(
                          height: 12.0.h,
                        ),
                        Row(
                          children: [
                             Padding(
                              padding: EdgeInsets.only(top: 0.0, left: 12,right: 12),
                              child: Text(
                                'Offers_txt'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14.sp),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewAllScreen(dep: 1, list:productController.offersProducts.value )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, left: 0, right: 0.0),
                                child: Text(
                                  'View All_txt'.tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                      color: Colors.grey[700]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 8, right: 8),
                              child: Icon(
                                langController.appLocal == 'en'?Icons.arrow_forward_ios_rounded:Icons.arrow_back_ios_new_rounded,
                                size: 14.sp,
                                color: Colors.grey[700],
                              ),
                            )
                          ],
                        ),
                         SizedBox(
                          height: 6.0.h,
                        ),
                        _buildHorizontalListOfOffersProducts(),
                         SizedBox(
                          height: 22.h,
                        ),
                        _buildOfferArea(),
                        SizedBox(height: 95.h,),
                      ],
                    ),
              ),
            ),
          ),
        ]);
                  }
                ))));

  }
  Widget _buildDepartmentsList() {
    final size = Get.size;
    return Padding(
      padding:  EdgeInsets.only(top: 12.0.h,right:10.w),
      child: Container(
        color: Colors.grey[50],
        child: GridView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          semanticChildCount: 0,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 3,
              crossAxisSpacing: 5.0,
              childAspectRatio:size.width<390? 1.1:1.2),
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.zero,
                child: DepartmentShapeTile(
                  assetPath: categories[index]['imagePath'],
                  title:langController.appLocal=='en' ?categories[index]['catName']:categories[index]['catNameAR'],
                  depId: categories[index]['id']!,
                ));
          },
        ),
      ),
    );
  }

  Widget _buildHorizontalListOfRecommendedProducts() {
    final screenSize = Get.size;
    return SizedBox(
        height:langController.appLocal =="ar"? screenSize.height * 0.4 - 16.h:screenSize.height * 0.4 - 26.h,
        child: Padding(
          padding:  EdgeInsets.only(right: 5.0.w),
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: [
              Obx(
                () => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ProductItemCard(
                        product: productController.recommendedProducts[index],
                        fromDetails: false,
                        from: "home_ho_rec",
                        press: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 200),
                              reverseTransitionDuration:
                                  const Duration(milliseconds: 200),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      FadeTransition(
                                opacity: animation,
                                child: ProductDetails(
                                  product: productController
                                      .recommendedProducts[index],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: productController.recommendedProducts.length,
                    semanticIndexOffset: 2,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildHorizontalListOfOffersProducts() {
    final screenSize = Get.size;
    return SizedBox(
        height:langController.appLocal =="ar"? screenSize.height * 0.4 - 16.h:screenSize.height * 0.4 - 26.h,
        child: Padding(
          padding:  EdgeInsets.only(right: 5.0.w),
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: [
              Obx(
                () => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ProductItemCard(
                        product: productController.offersProducts[index],
                        fromDetails: false,
                        from: "home_hor_offers",
                        press: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 200),
                              reverseTransitionDuration:
                                  const Duration(milliseconds: 200),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      FadeTransition(
                                opacity: animation,
                                child: ProductDetails(
                                  product: productController
                                      .recommendedProducts[index],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: productController.offersProducts.length,
                    semanticIndexOffset: 2,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildOfferArea() {
    final screenSize = Get.size;
    return InkWell(
      onTap: () {
        if (kDebugMode) {
          print('tap');
        }
      },
      child: Padding(
        padding:  EdgeInsets.only(bottom: 22.0.h),
        child: Stack(
          children: [
            FittedBox(
              child: SizedBox(
                height: screenSize.height * 0.2.h,
                width: screenSize.width.w,
                child: Container(
                    decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    const BoxShadow(color: Colors.black),
                    BoxShadow(color: myHexColor1),
                  ],
                  image: const DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage(
                      'assets/images/aniket-narula-XjNI-C5G6mI-unsplash.jpg',
                    ),
                  ),
                )),
              ),
            ),
            Positioned(
              top: 0.0,
              child: Container(
                color: Colors.black.withOpacity(0.4),
                height: 200.h,
                width: screenSize.width,
              ),
            ),
            Positioned(
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenSize.height * 0.1.h,
                    width: screenSize.width,
                  ),
                   Text(
                    'Offers and Promotions_txt'.tr,textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.1 - 70.h,
                  ),
                  Text(
                    'On all men\'s suits from the most famous world_txt'.tr,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[50],
                        fontWeight: FontWeight.bold),
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

Widget buildProductShimmer() {
  final screenSize = Get.size;

  return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: screenSize.height * 0.2 + 20.h,
                    width: screenSize.width * 0.5 - 40.w,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      height: 12.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 4.0.h),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      height: 12.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 4.0.h),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      height: 12.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                )
              ],
            ));
      });

}

