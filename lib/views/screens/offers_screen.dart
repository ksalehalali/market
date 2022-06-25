import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Assistants/globals.dart';
import '../../Data/data_for_ui.dart';
import '../../controllers/lang_controller.dart';
import '../../controllers/product_controller.dart';
import '../widgets/departments_shpe.dart';
import 'home/search_area_des.dart';
import 'show_product/product_details.dart';
import 'show_product/product_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OffersScreen extends StatefulWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final ProductsController productController = Get.find();
  final LangController langController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize = Get.size;
    return Container(
      color: myHexColor5,

      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.0.h,
            ),
            SearchAreaDesign(),
            SizedBox(
              height: 6.0.h,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.w),
              child: Container(
                width: screenSize.width.w,
                height: 1.h,
                color: myHexColor.withOpacity(0.6),
              ),
            ),
            SizedBox(
              height: 5.0.h,
            ),
            SizedBox(
                height: screenSize.height * 0.1 + 50.h,
                width: 400.w,
                child: _buildDepartmentsList()),
            Container(
                height: 160.h,
                width: screenSize.width.w,
                child: Image.asset(
                  'assets/images/pexels-artem-beliaikin-2529787 1.jpg',
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: 8.0.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0, left: 8.w,right: 8.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bestsellers_txt'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  ),
                  const Spacer(),
                  Text(
                    'View All_txt'.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                        color: Colors.grey[700]),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14.sp,
                    color: Colors.grey[700],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            _buildHorizontalListOfBestSallersProducts(),
             SizedBox(
              height: 22.0.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Padding(
                  padding: EdgeInsets.only(top: 0.0, left: 8.w,right: 8.w),
                  child: Text(
                    'Women\'s fashon offers_txt'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  ),
                ),
                const Spacer(),
                Text(
                  'View All_txt'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      color: Colors.grey[700]),
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.sp,
                  color: Colors.grey[700],
                )
              ],
            ),
             SizedBox(
              height: 4.0.h,
            ),
            _buildHorizontalListOfOffersProducts(),
             SizedBox(
              height: 28.h,
            ),
            _buildOfferArea()
          ],
        )),
      )),
    );
  }

  Widget _buildDepartmentsList() {
    return Padding(
      padding:  EdgeInsets.only(top: 12.0.h),
      child: Container(
        color: Colors.grey[50],
        child: GridView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.zero, //a
          semanticChildCount: 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 5,
              crossAxisSpacing: 2.0,
              childAspectRatio: 1.4),
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.zero,
                child: DepartmentShapeTile(
                  assetPath: categories[index]['imagePath'],
                  title:langController.appLocal=="en"? categories[index]['catName']:categories[index]['catNameAR'],
                  depId: categories[index]['id']!,
                ));
          },
        ),
      ),
    );
  }

  Widget _buildHorizontalListOfBestSallersProducts() {
    final screenSize = Get.size;
    return SizedBox(
        height:langController.appLocal =="ar"? screenSize.height * 0.4 - 16.h:screenSize.height * 0.4 - 26.h,
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
                      from: "home_ho_rec", press: (){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration:
                          const Duration(milliseconds: 500),
                          reverseTransitionDuration:
                          const Duration(milliseconds: 500),
                          pageBuilder: (context, animation,
                              secondaryAnimation) =>
                              FadeTransition(
                                opacity: animation,
                                child: ProductDetails(
                                  product: productController.recommendedProducts[index],
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
            ),
          ],
        ));
  }

  Widget _buildHorizontalListOfOffersProducts() {
    final screenSize = Get.size;
    return SizedBox(
        height:langController.appLocal =="ar"? screenSize.height * 0.4 - 16.h:screenSize.height * 0.4 - 26.h,
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
                      from: "home_hor_offers",press: (){
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration:
                          const Duration(milliseconds: 500),
                          reverseTransitionDuration:
                          const Duration(milliseconds: 500),
                          pageBuilder: (context, animation,
                              secondaryAnimation) =>
                              FadeTransition(
                                opacity: animation,
                                child: ProductDetails(
                                  product: productController.recommendedProducts[index],
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
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/images/pexels-erik-mclean-4077321.jpg',
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenSize.height * 0.1,
                ),
                 Text(
                  'Offers and Promotions',
                  style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenSize.height * 0.1 - 70.h,
                ),
                Center(
                  child: Text(
                    'On all watches and bags from the most famous world',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[50],
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
