import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Assistants/globals.dart';
import '../../Data/data_for_ui.dart';
import '../../controllers/product_controller.dart';
import '../widgets/departments_shpe.dart';
import 'home/search_area_des.dart';
import 'show_product/product_details.dart';
import 'show_product/product_item.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final ProductsController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize = Get.size;
    return Container(
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.0,
            ),
            SearchAreaDesign(),
            SizedBox(
              height: 6.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                width: screenSize.width,
                height: 2,
                color: myHexColor.withOpacity(0.6),
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            SizedBox(
                height: screenSize.height * 0.1 + 50,
                width: 400,
                child: _buildDepartmentsList()),
            Container(
                height: 160,
                width: screenSize.width,
                child: Image.asset(
                  'assets/images/apple_3d_logo_wallpaper.jpeg',
                  fit: BoxFit.fill,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, right: 12, left: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bestsellers',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const Spacer(),
                  Text(
                    'View all',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey[700]),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: Colors.grey[700],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            _buildHorizontalListOfBestSallersProducts(),
            const SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 0.0, left: 12),
                  child: Text(
                    'Women\'s fashon offers',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 0.0, left: 12, right: 5.0),
                  child: Text(
                    'View all',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey[700]),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Colors.grey[700],
                )
              ],
            ),
            const SizedBox(
              height: 12.0,
            ),
            _buildHorizontalListOfOffersProducts(),
            const SizedBox(
              height: 28,
            ),
            _buildOfferArea()
          ],
        )),
      )),
    );
  }

  Widget _buildDepartmentsList() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
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
              childAspectRatio: 1.7),
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.zero,
                child: DepartmentShapeTile(
                  assetPath: categories[index]['imagePath'],
                  title: categories[index]['catName'],
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
        height: screenSize.height * 0.4 - 28,
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
        height: screenSize.height * 0.4 - 28,
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
        padding: const EdgeInsets.only(bottom: 22.0),
        child: Stack(
          children: [
            FittedBox(
              child: SizedBox(
                height: screenSize.height * 0.2,
                width: screenSize.width,
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
                height: 200,
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
                const Text(
                  'Offers and Promotions',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenSize.height * 0.1 - 70,
                ),
                Center(
                  child: Text(
                    'On all watches and bags from the most famous world',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
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
