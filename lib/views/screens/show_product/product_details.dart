import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../Assistants/globals.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/lang_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/product_model.dart';
import '../../widgets/horizontal_listOfProducts.dart';
import '../auth/register.dart';
import '../categories/categories_screen.dart';
import '../order/Cart.dart';
import '../account/account.dart';
import '../home/home.dart';
import '../home/search_area_des.dart';
import 'package:html/parser.dart' show parse;


class ProductDetails extends StatefulWidget {
  final ProductModel? product;

  const ProductDetails({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

int indexListImages = 0;
double scaleOfCart = 1.0;
double scaleOfItem = 1.0;
int activeIndex =0;
int duration = 800;

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ProductsController productController = Get.find();
  final CartController cartController = Get.find();
  final screenSize = Get.size;
  final LangController langController = Get.find();

  final List<Color> _colorSize = [
    myHexColor3,
  ];
  final List<Color> _colorSizeBorder = [
    myHexColor3,
  ];
  Color? _color = myHexColor3;
  Color? _color2 = Colors.grey[700];

  final List<Color> _colorColor = [
    myHexColor3,
  ];
  final List<Color> _colorColorBorder = [
    myHexColor3,
  ];

  bool showOver = false;
  bool showSpec = false;
  String _colorId = "";
  String _sizeId = "";
  int currentSizeIndex = 0;

  Widget? flyingcart = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.getMyCartProds(false,langController.appLocal);
    setIds();
  }

  setIds()async{
    Future.delayed(const Duration(milliseconds: 3500), (){
      _colorId = productController.imagesData[0].colorId;
      _sizeId = productController.sizes[0]['sizeID'];
      print('auto id selected color: ' + _colorId);
      print('auto id selected size: ' + _sizeId);
    });



  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    final bool success = true;
    productController.addProductToFav(widget.product!.id!);

    /// if failed, you can do nothing
    return success ? !isLiked : isLiked;

    //return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = 31;
    final screenSize = Get.size;
    return Container(
      color: Colors.white,
      child: Obx(
        () => Stack(
          key: const Key('s2'),
          children: [
            productController.getDetailsDone.value == true
                ? Obx(() => Container(
                      color: myHexColor,
                      child: SafeArea(
                        top: true,
                        bottom: false,
                        child: Scaffold(
                          backgroundColor: Colors.white,
                          body: Container(
                            height: screenSize.height,
                            width: screenSize.width,
                            child: SingleChildScrollView(
                              child: Column(
                                key: const Key('l'),
                                // padding: EdgeInsets.zero,
                                // shrinkWrap: true,
                                children: [
                                  SizedBox(
                                    height: 4.0.h,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();

                                          print(productController
                                              .latestProducts.length);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 12.0.w, left: 10.w),
                                          child: SvgPicture.asset(
                                              'assets/icons/left arrow.svg',
                                              alignment: Alignment.center,
                                              //color:,
                                              height: 22.h,
                                              width: 22.w,
                                              semanticsLabel: 'A red up arrow'),
                                        ),
                                      ),
                                      const Expanded(child: SearchAreaDesign()),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Cart()));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child: Container(
                                            height: 40.h,
                                            width: 40.w,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                AnimatedScale(
                                                  scale: scaleOfCart,
                                                  duration:
                                                      duration.milliseconds,
                                                  alignment: Alignment.center,
                                                  curve: Curves.easeInOutBack,
                                                  child: SvgPicture.asset(
                                                      'assets/icons/cart-fill.svg',
                                                      alignment:
                                                          Alignment.center,
                                                      //color:,
                                                      height: 29.h,
                                                      width: 29.w,
                                                      semanticsLabel:
                                                          'A red up arrow'),
                                                ),
                                                Positioned(
                                                    right: 0.0,
                                                    top: 0.0,
                                                    child: Container(
                                                        height: 14.h,
                                                        width: 14.w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                246,
                                                                138,
                                                                24)),
                                                        child: Center(
                                                          child: Obx(
                                                            () => Text(
                                                              cartController
                                                                  .myPrCartProducts
                                                                  .length
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        )))
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Obx(
                                    () => Stack(
                                      key: const Key('s'),
                                      children: [
                                        productController
                                                    .getDetailsDone.value ==
                                                true
                                            ? Column(
                                                children: [
                                                  SizedBox(
                                                    height: screenSize.height *
                                                        0.4.h,
                                                    width: double.infinity,
                                                    child: Column(
                                                      children: [
                                                        CarouselSlider.builder(
                                                          itemCount: productController.imagesWidget.value[indexListImages].length,
                                                          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => InkWell(
                                                            onTap: (){
                                                              gallery(itemIndex);
                                                            },
                                                            child: Container(
                                                              width: screenSize.width,
                                                                          child: productController.imagesWidget.value[indexListImages][itemIndex],
                                                                        ),
                                                          ),
                                                                      options: CarouselOptions(
                                                                          viewportFraction: 1,
                                                                          height: 300,
                                                                          pageSnapping: true,
                                                                          //autoPlay: true,
                                                                          enableInfiniteScroll: true,
                                                                      enlargeCenterPage: true,
                                                                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                                                                        autoPlayInterval: 2500.milliseconds,
                                                                        onPageChanged:(index,reason ){
                                                                            setState(() {
                                                                              activeIndex = index;
                                                                            });
                                                                        },

                                                                      ),
                                                                    ),
                                                        SizedBox(height: 4.0,),
                                                        buildIndicator(productController.imagesWidget.value[indexListImages].length),
                                                      ],
                                                    )

                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        productController
                                                    .getDetailsDone.value ==
                                                true
                                            ? Positioned(
                                                top: 8.0.h,
                                                left: 10.0.w,
                                                width:
                                                    screenSize.width * .1 + 0.w,
                                                height:
                                                    screenSize.width * .1 + 0.w,
                                                child: LikeButton(
                                                  size: buttonSize + 5,
                                                  onTap: onLikeButtonTapped,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  // padding: EdgeInsets.only(
                                                  //     left: screenSize.width * .1 - 37,
                                                  //     top: 2),
                                                  circleColor:
                                                      const CircleColor(
                                                          start:
                                                              Color(0xff00ddff),
                                                          end: Color(
                                                              0xff0099cc)),
                                                  bubblesColor:
                                                      const BubblesColor(
                                                    dotPrimaryColor:
                                                        Color(0xff33b5e5),
                                                    dotSecondaryColor:
                                                        Color(0xff0099cc),
                                                  ),
                                                  likeBuilder: (bool isLiked) {
                                                    return Container(
                                                      width: screenSize.width *
                                                          .1.w,
                                                      height: screenSize.width *
                                                          .1.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: Colors.white,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: SvgPicture.asset(
                                                            'assets/icons/heart.svg',
                                                            alignment: Alignment
                                                                .center,
                                                            color: isLiked
                                                                ? myHexColor3
                                                                : Colors
                                                                    .grey[600],
                                                            height: buttonSize,
                                                            width: buttonSize,
                                                            semanticsLabel:
                                                                'A red up arrow'),
                                                      ),
                                                    );
                                                  },
                                                ))
                                            : Container(),
                                        productController
                                                    .getDetailsDone.value ==
                                                true
                                            ? Positioned(
                                                top: screenSize.height * .1 -
                                                    23.h,
                                                left: 10..w,
                                                child: Container(
                                                  padding: EdgeInsets.zero,
                                                  margin: EdgeInsets.zero,
                                                  width: screenSize.width * .1 -
                                                      5.w,
                                                  height:
                                                      screenSize.width * .1 -
                                                          5.w,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: Colors.white
                                                          .withOpacity(1)),
                                                  child: LikeButton(
                                                    size: buttonSize - 10,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    onTap: (isLiked) async {
                                                      print('share');
                                                      return isLiked;
                                                    },
                                                    circleColor:
                                                        const CircleColor(
                                                            start: Colors.grey,
                                                            end: Colors.grey),
                                                    bubblesColor:
                                                        const BubblesColor(
                                                      dotPrimaryColor:
                                                          Color(0xff33b5e5),
                                                      dotSecondaryColor:
                                                          Color(0xff0099cc),
                                                    ),
                                                    likeBuilder:
                                                        (bool isLiked) {
                                                      return SvgPicture.asset(
                                                          'assets/icons/share3.svg',
                                                          alignment:
                                                              Alignment.center,
                                                          color: isLiked
                                                              ? myHexColor3
                                                              : Colors
                                                                  .grey[600],
                                                          height: buttonSize,
                                                          width: buttonSize,
                                                          semanticsLabel:
                                                              'A red up arrow');
                                                    },
                                                  ),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0.w),
                                    child: Obx(
                                      () => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.0.h,
                                          ),
                                          Text(
                                            '${productController.productDetails.providerName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp,
                                                color: myHexColor1),
                                          ),
                                          SizedBox(
                                            height:
                                                screenSize.height * 0.1 - 70.h,
                                          ),
                                          Text(
                                            productController
                                                .productDetails.en_name!
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.sp,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height:
                                                screenSize.height * 0.1 - 72.h,
                                          ),
                                          Text(
                                            '${productController.productDetails.price! - productController.offerFromPrice.value} QAR',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.sp,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height:
                                                screenSize.height * 0.1 - 60.h,
                                          ),
                                          Text(
                                            'Size',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14.sp,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          _buildSizesOptions(screenSize),
                                          SizedBox(
                                            height: 22.0.h,
                                          ),
                                          Text(
                                            'Color',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14.sp,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          _buildColorsOptions(screenSize),
                                          SizedBox(
                                            height: 22.0.h,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey[500]!,
                                                )),
                                            width: screenSize.width,
                                            height:
                                                screenSize.height * 0.1 - 30.h,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10.0.w,
                                                ),
                                                SvgPicture.asset(
                                                    'assets/icons/shipping.svg',
                                                    color: Colors.grey[600],
                                                    height: 18.0.h,
                                                    width: 18.0.w,
                                                    semanticsLabel:
                                                        'A red up arrow'),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                const Text('Delivery time :'),
                                                const Spacer(),
                                                const Text(' Jan 28 - Jan 30'),
                                                SizedBox(
                                                  width:
                                                      screenSize.width * 0.1 -
                                                          12.w,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 14.0.h),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.h),
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 18.0.h,
                                                    horizontal: 12.w),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/images/svg/9593997931634472866.svg',
                                                        // color: Colors.black,
                                                        height: 21.00.h,
                                                        width: 21.0.w,
                                                        semanticsLabel:
                                                            'A red up arrow'),
                                                    const SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      'Seller',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15.sp),
                                                    ),
                                                    SizedBox(
                                                      width: 8.0.w,
                                                    ),
                                                    Text(
                                                      'QR Market',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16.sp,
                                                          color: myHexColor3),
                                                    ),
                                                    const Spacer(),
                                                    const Icon(Icons
                                                        .keyboard_arrow_right)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _color = myHexColor3;
                                            _color2 = Colors.grey[700];
                                            showOver = true;
                                            showSpec = false;
                                          });
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                                duration: 11.seconds,
                                                curve: Curves.easeIn,
                                                child: Text('Overview',
                                                    style: TextStyle(
                                                        color: _color,
                                                        fontWeight:
                                                            FontWeight.w500))),
                                            SizedBox(
                                              height: 10.0.h,
                                            ),
                                            AnimatedContainer(
                                              curve: Curves.easeInOut,
                                              width: screenSize.width / 2.w,
                                              height: 2.5.h,
                                              color: _color,
                                              duration: 900.milliseconds,
                                            )
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _color2 = myHexColor3;
                                            _color = Colors.grey[700];
                                            showOver = false;
                                            showSpec = true;
                                          });
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedContainer(
                                                curve: Curves.easeIn,
                                                duration: 14.seconds,
                                                child: Text(
                                                  'Specifications',
                                                  style: TextStyle(
                                                      color: _color2,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                            SizedBox(
                                              height: 10.0.h,
                                            ),
                                            AnimatedContainer(
                                              curve: Curves.easeInOut,
                                              width: screenSize.width / 2.w,
                                              height: 2.5.h,
                                              color: _color2,
                                              duration: 900.milliseconds,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  showSpec
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 14.0.h,
                                                  horizontal: 12.w),
                                              child: Text(
                                                'Specifications',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12.0.h,
                                                  horizontal: 12.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: screenSize.width *
                                                              0.9 +
                                                          10.w,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          ..._buildSpicalProperties()
                                                        ],
                                                      )),
                                                  const Spacer()
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color:
                                                  myHexColor3.withOpacity(0.4),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12.0.h,
                                                    horizontal: 12.w),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                        child: Text(
                                                          'Color name',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        width:
                                                            screenSize.width *
                                                                    .5 -
                                                                30.w),
                                                    SizedBox(
                                                        width:
                                                            screenSize.width *
                                                                0.5.w,
                                                        child: Text(
                                                          productController
                                                                  .productDetails
                                                                  .colorsData![
                                                              0]['color'],
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[800],
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                    const Spacer()
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12.0.h,
                                                  horizontal: 12.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: screenSize.width *
                                                              .5 -
                                                          30.w,
                                                      child: Text(
                                                        'Department',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[900],
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                  Text(
                                                    productController
                                                        .productDetails
                                                        .categoryNameEN!,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey[800],
                                                      fontSize: 11.sp,
                                                    ),
                                                  ),
                                                  const Spacer()
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color:
                                                  myHexColor3.withOpacity(0.4),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12.0.h,
                                                    horizontal: 12.w),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                        width:
                                                            screenSize.width *
                                                                    .5 -
                                                                30.w,
                                                        child: Text(
                                                          'Offer',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )),
                                                    Text(
                                                      '${productController.productDetails.offer.toString()} %',
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[800],
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Spacer()
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12.0.h,
                                                  horizontal: 12.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: screenSize.width *
                                                              .5 -
                                                          30.w,
                                                      child: Text(
                                                        'Material',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[900],
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                  Text(
                                                    'any',
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey[800],
                                                      fontSize: 11.sp,
                                                    ),
                                                  ),
                                                  const Spacer()
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color:
                                                  myHexColor3.withOpacity(0.4),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12.0.h,
                                                    horizontal: 12.w),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                        width:
                                                            screenSize.width *
                                                                    .5 -
                                                                30.w,
                                                        child: Text(
                                                          'Material Composition',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )),
                                                    Text(
                                                      '100% any',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[800],
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Spacer()
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12.0.h,
                                                  horizontal: 12.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      width: screenSize.width *
                                                              .5 -
                                                          30.w,
                                                      child: Text(
                                                        'Model Number',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[900],
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                  Text(
                                                    productController
                                                        .productDetails
                                                        .modelName!,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey[800],
                                                      fontSize: 11.sp,
                                                    ),
                                                  ),
                                                  const Spacer()
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color:
                                                  myHexColor3.withOpacity(0.4),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12.0.h,
                                                    horizontal: 12.w),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width:
                                                            screenSize.width *
                                                                    .5 -
                                                                30.w,
                                                        child: Text(
                                                          'Merchant',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[900],
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )),
                                                    Text(
                                                      productController
                                                          .productDetails
                                                          .providerName!,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[800],
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Spacer()
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 12.0.w,
                                                      left: 12.0.w,
                                                      top: 22.0.h,
                                                      bottom: 10.h),
                                                  child: Text(
                                                    'Highlights',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1.0.h,
                                                      horizontal: 12.w),
                                                  child: productController
                                                      .productDetails.desc_EN !=null ?Html(
                                                    data: productController
                                                        .productDetails.desc_EN,
                                                  ):Container(),
                                                ),
                                                SizedBox(
                                                  height: 150.h,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 12.0.w,
                                          left: 12.0.w,
                                          top: 22.0.h,
                                          bottom: 10.h),
                                      child: Text(
                                        'More from ${productController.product.value.brand}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                                  buildHorizontalListOfProducts(true),
                                  SizedBox(
                                    height: 60.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          bottomSheet:
                              productController.getDetailsDone.value == true
                                  ? buildAddCartPrice(
                                      productController.productDetails.price!,
                                      productController.productDetails.offer,
                                      indexListImages)
                                  : Container(),
                        ),
                      ),
                    ))
                : _buildShimmerLoadingData(),
            Container(
              margin: EdgeInsets.only(top: screenSize.height * 0.1 - 54.h),
              width: MediaQuery.of(context).size.width.w,
              height: MediaQuery.of(context).size.height - 50.h,
              child: flyingcart == null ? Container() : flyingcart,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoadingData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: screenSize.height * 0.1 / 7.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 12.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.4 - 10.h,
              width: screenSize.width.w,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 12.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.1 - 60.h,
              width: screenSize.width * 0.4.w,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 22.0.h, right: 12.w, left: 12.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.1 - 62.h,
              width: screenSize.width.w,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 12.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.1 - 62.h,
              width: screenSize.width.w,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.1 - 62.h,
              width: screenSize.width.w,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        SizedBox(
          height: 60.h,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 12.w),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: screenSize.height * 0.1 - 30.h,
                  width: screenSize.width * 0.2.w,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0.h, horizontal: 12.w),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: screenSize.height * 0.1 - 30.h,
                  width: screenSize.width * 0.2.w,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.w),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: screenSize.height * 0.1 - 30.h,
                  width: screenSize.width * 0.2.w,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: screenSize.height * 0.1 - 70.h,
              width: screenSize.width.w,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(2)),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.w),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: screenSize.height * 0.1 - 70.h,
              width: screenSize.width.w,
              decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSizesOptions(size) {
    return SizedBox(
      width: size.width,
      height: 36.h,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                _colorSize.add(Colors.grey[800]!);
                _colorSizeBorder.add(Colors.grey[400]!);

                return InkWell(
                  onTap: () {
                    currentSizeIndex = index;
                    productController.currentSizeSelected.value =
                        productController.sizes[index]['size'];
                    productController.currentSizeIdSelected.value =
                        productController.sizes[index]['sizeID'];
                    _sizeId = productController.sizes[index]['sizeID'];

                    print(
                        "size is = ${productController.sizes[index]['sizeID']}");
                    setState(() {
                      for (var i = 0; i < _colorSize.length; i++) {
                        if (i == index) {
                          _colorSize[i] = myHexColor3;
                          _colorSizeBorder[i] = myHexColor3;
                        } else {
                          _colorSize[i] = Colors.grey[800]!;
                          _colorSizeBorder[i] = Colors.grey[400]!;
                        }
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0.w),
                    child: Container(
                      height: 24.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.2, color: _colorSizeBorder[index])),
                      child: Center(
                        child: Text(
                          productController.sizes[index]['size'],
                          style: TextStyle(
                              color: _colorSize[index],
                              fontWeight: FontWeight.bold,
                              decoration: productController.qytsWithSizes[index].qyt==0 ?TextDecoration.lineThrough:TextDecoration.none,
                              fontSize: 13.sp),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: productController.sizes.length,
              semanticIndexOffset: 0,
            ),
          )
        ],
      ),
    );
  }

//build colors options
  Widget _buildColorsOptions(size) {
    return SizedBox(
      width: size.width,
      height: 36.h,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {

                print('color id for $index is:: ${productController.imagesData[index].colorId}');
                print('qyt :: ${productController.sizes[index]['color'][index]['qyt']}');
                _colorColor.add(Colors.grey[800]!);
                _colorColorBorder.add(Colors.grey[400]!);

                return InkWell(
                  onTap: () {
                    productController.currentColorSelected.value =
                        productController.imagesData[index].color;
                    productController.currentColorIdSelected.value =
                        productController.imagesData[index].colorId;
                    _colorId =productController.imagesData[index].colorId;
                    print(
                        'current color id = ${productController.imagesData[index].colorId}');
                    print(index);
                    indexListImages = index;
                    setState(() {
                      for (var i = 0; i < _colorColor.length; i++) {
                        if (i == index) {
                          _colorColor[i] = myHexColor3;
                          _colorColorBorder[i] = myHexColor3;
                        } else {
                          _colorColor[i] = Colors.grey[800]!;
                          _colorColorBorder[i] = Colors.grey[400]!;
                        }
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0.w),
                    child: Container(
                      height: 24.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.2, color: _colorColorBorder[index])),
                      child: Center(
                        child: Text(
                          productController.sizes[currentSizeIndex]['color'][index]['color'],
                          style: TextStyle(
                              color: _colorColor[index],
                              fontWeight: FontWeight.bold,
                              decoration: productController.qytsWithSizes[index].qyt == 0  ?TextDecoration.lineThrough:TextDecoration.none,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: productController.sizes[currentSizeIndex]['color'].length,
              semanticIndexOffset: 0,
            ),
          )
        ],
      ),
    );
  }

  List _buildSpicalProperties() {
    var sList = [];
    for (int i = 0; productController.productDetails.special!.length > i; i++) {
      sList.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width * .5 - 30.w,
                    child: Text(
                      '${productController.productDetails.special![i]['prorerty']}',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * .6 - 46.w,
                    child: Text(
                      '${productController.productDetails.special![i]['value']}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Divider(
                thickness: .5,
                height: 10.0.h,
              ),
            ],
          ),
        ),
      );
    }

    return sList;
  }

  Widget buildAddCartPrice(double price, int? offer, int indexImage) {
    return Card(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
                onTap: () {

                  //when this button is pressed, a flying cart display
                  setState(() {
                    duration = 800;
                    scaleOfCart = 1.5;
                    scaleOfItem = 1.2;
                    flyingcart = const Flyingcart();
                    //wait 2 second
                  });

                  Future.delayed(const Duration(milliseconds: 800), () {
                    setState(() {
                      scaleOfItem = 0;
                      duration = 500;
                      scaleOfCart = 1.0;
                    });
                  });

                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      flyingcart = null;
                      //hide flycart and add number
                    });
                  });

                  bool available = false;
                  productController.colorsSizesItems.value.forEach((element) {
                    print(element['color']);
                    if(_sizeId == element['sizeID'] && element['qyt'] >0){
                      print('true ...=============..');
                    }
                  });
                 // cartController.addToCart(productController.productData['id'],
                 //     productController.currentColorIdSelected,
                 //     productController.currentSizeIdSelected,
                 //     langController.appLocal).then(
                 //       (value) => showGeneralDialog(
                 //       context: context,
                 //       barrierDismissible: true,
                 //       transitionDuration: 500.milliseconds,
                 //       barrierLabel:
                 //       MaterialLocalizations.of(context).dialogLabel,
                 //       barrierColor: Colors.black.withOpacity(0.5),
                 //       pageBuilder: (context, _, __) {
                 //         return Column(
                 //           mainAxisAlignment: MainAxisAlignment.start,
                 //           crossAxisAlignment: CrossAxisAlignment.start,
                 //           children: [
                 //             Container(
                 //               width: screenSize.width,
                 //               color: Colors.white,
                 //               child: Card(
                 //                 child: Column(
                 //                   children: [
                 //                     SizedBox(
                 //                       height: 55.h,
                 //                     ),
                 //                     Container(
                 //                       margin: EdgeInsets.only(
                 //                           left: 10.w, right: 10.w),
                 //                       child: Row(
                 //                         children: [
                 //                           SvgPicture.asset(
                 //                             'assets/icons/done.svg',
                 //                             width: 34.w,
                 //                             height: 34.h,
                 //                             color: myHexColor,
                 //                           ),
                 //                           Row(
                 //                             mainAxisAlignment:
                 //                             MainAxisAlignment
                 //                                 .spaceBetween,
                 //                             crossAxisAlignment:
                 //                             CrossAxisAlignment.center,
                 //                             children: [
                 //                               Row(
                 //                                 mainAxisAlignment:
                 //                                 MainAxisAlignment
                 //                                     .spaceBetween,
                 //                                 crossAxisAlignment:
                 //                                 CrossAxisAlignment
                 //                                     .center,
                 //                                 children: [
                 //                                   Padding(
                 //                                     padding:
                 //                                     EdgeInsets.only(
                 //                                         left: 4.0.w),
                 //                                     child: Column(
                 //                                       crossAxisAlignment:
                 //                                       CrossAxisAlignment
                 //                                           .start,
                 //                                       children: [
                 //                                         SizedBox(
                 //                                           width: screenSize
                 //                                               .width *
                 //                                               0.4.w,
                 //                                           child: Text(
                 //                                             'iphone 12 232323 32323 32323 2323 23233 32',
                 //                                             maxLines: 1,
                 //                                             overflow:
                 //                                             TextOverflow
                 //                                                 .ellipsis,
                 //                                             style: TextStyle(
                 //                                                 fontSize:
                 //                                                 14.sp,
                 //                                                 fontWeight:
                 //                                                 FontWeight
                 //                                                     .w700,
                 //                                                 color: Colors
                 //                                                     .black87),
                 //                                           ),
                 //                                         ),
                 //                                         Text(
                 //                                           'Added to cart ',
                 //                                           style: TextStyle(
                 //                                               fontSize:
                 //                                               14.sp,
                 //                                               fontWeight:
                 //                                               FontWeight
                 //                                                   .w700,
                 //                                               color: Colors
                 //                                                   .black87),
                 //                                         ),
                 //                                       ],
                 //                                     ),
                 //                                   ),
                 //                                   Padding(
                 //                                     padding:
                 //                                     EdgeInsets.only(
                 //                                         left: 80.0.w),
                 //                                     child: Column(
                 //                                       crossAxisAlignment:
                 //                                       CrossAxisAlignment
                 //                                           .start,
                 //                                       children: [
                 //                                         Text(
                 //                                           'Cart Total',
                 //                                           style: TextStyle(
                 //                                               fontSize:
                 //                                               14.sp,
                 //                                               fontWeight:
                 //                                               FontWeight
                 //                                                   .w700,
                 //                                               color: Colors
                 //                                                   .black87),
                 //                                         ),
                 //                                         Obx(
                 //                                               () => Text(
                 //                                             cartController
                 //                                                 .fullPrice
                 //                                                 .value
                 //                                                 .toStringAsFixed(
                 //                                                 2),
                 //                                             style: TextStyle(
                 //                                                 fontSize:
                 //                                                 14.sp,
                 //                                                 fontWeight:
                 //                                                 FontWeight
                 //                                                     .w700,
                 //                                                 color: Colors
                 //                                                     .black87),
                 //                                           ),
                 //                                         ),
                 //                                       ],
                 //                                     ),
                 //                                   ),
                 //                                 ],
                 //                               ),
                 //                             ],
                 //                           ),
                 //                         ],
                 //                       ),
                 //                     ),
                 //                     SizedBox(
                 //                       height: 12.h,
                 //                     ),
                 //                     Row(
                 //                       mainAxisAlignment:
                 //                       MainAxisAlignment.spaceBetween,
                 //                       children: [
                 //                         ElevatedButton(
                 //                           onPressed: () {
                 //                             Navigator.of(context).pop();
                 //                           },
                 //                           style: ElevatedButton.styleFrom(
                 //                               maximumSize: Size(200, 220),
                 //                               minimumSize: Size(18, 34),
                 //                               primary: Colors.green[800],
                 //                               onPrimary:
                 //                               Colors.green[900],
                 //                               alignment:
                 //                               Alignment.center),
                 //                           child: Text(
                 //                             'CONTINUE SHOPPING',
                 //                             maxLines: 1,
                 //                             style: const TextStyle(
                 //                                 fontWeight:
                 //                                 FontWeight.w700,
                 //                                 color: Colors.white),
                 //                           ),
                 //                         ),
                 //                         ElevatedButton(
                 //                           onPressed: () {
                 //                             Navigator.of(context)
                 //                                 .pushReplacement(
                 //                                 MaterialPageRoute(
                 //                                     builder: (context) =>
                 //                                     const Cart()));
                 //                           },
                 //                           style: ElevatedButton.styleFrom(
                 //                               maximumSize: Size(200, 220),
                 //                               minimumSize: Size(180, 34),
                 //                               primary: myHexColor,
                 //                               onPrimary: Colors.white,
                 //                               alignment:
                 //                               Alignment.center),
                 //                           child: const Text(
                 //                             'CHECKOUT',
                 //                             style: TextStyle(
                 //                                 fontWeight:
                 //                                 FontWeight.w700,
                 //                                 color: Colors.white),
                 //                           ),
                 //                         ),
                 //                       ],
                 //                     )
                 //                   ],
                 //                 ),
                 //               ),
                 //             )
                 //           ],
                 //         );
                 //       },
                 //       transitionBuilder: (context, animation,
                 //           secondaryAnimation, child) {
                 //         return SlideTransition(
                 //           position: CurvedAnimation(
                 //             parent: animation,
                 //             curve: Curves.easeInOutCubic,
                 //           ).drive(
                 //             Tween<Offset>(
                 //                 begin: const Offset(0, -1.0),
                 //                 end: Offset.zero),
                 //           ),
                 //           child: child,
                 //         );
                 //       }),
                 // );

               },
                child: Container(
                  height: 54.h,
                  color: myHexColor1,
                  child: const Center(
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
          ),
          Container(
            height: 44.h,
            width: 130.w,
            color: Colors.white,
            child: Center(
              child: Text(
                '${price - price * offer! / 100}',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  void gallery(int i) => Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => GalleryWidget(
          index: i,
          urlImages:
              productController.imagesData[indexListImages].imagesUrls)));

  buildIndicator(int count) =>AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
    effect:WormEffect(
      dotHeight: 10,
      dotWidth: 10,
      activeDotColor: myHexColor
    ),

  );
}

class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final List<String> urlImages;
  final int index;

  GalleryWidget({Key? key, required this.urlImages, this.index = 0})
      : pageController = PageController(initialPage: index);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late int index = widget.index;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.black.withOpacity(1.0),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Container(
            color: Colors.white,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                PhotoViewGallery.builder(
                  backgroundDecoration: BoxDecoration(color: Colors.white),
                  pageController: widget.pageController,
                  itemCount: widget.urlImages.length,
                  builder: (context, index) {
                    final urlImage = widget.urlImages[index];
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(
                        "$baseURL/$urlImage",
                      ),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained * 4,
                    );
                  },
                  onPageChanged: (index) => setState(() => this.index = index),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 33.h, bottom: 20.h, right: 20.w, left: 20.w),
                  child: Text(
                    'image ${index + 1}/${widget.urlImages.length}',
                    style: TextStyle(fontSize: 22.sp, color: myHexColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Flyingcart extends StatefulWidget {
  const Flyingcart({
    Key? key,
  }) : super(key: key);

  @override
  _FlyingcartState createState() => _FlyingcartState();
}

class _FlyingcartState extends State<Flyingcart> with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  final ProductsController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      //code here
      final Size biggest = constraints.biggest;
      return Stack(
        children: [
          PositionedTransition(
              rect: RelativeRectTween(
                begin:
                    //flying cart fly from bottom to top
                    RelativeRect.fromSize(
                        Rect.fromLTRB(
                            biggest.width / 2 - 60,
                            biggest.height - 60,
                            biggest.width / 2,
                            biggest.height),
                        biggest),
                end: RelativeRect.fromSize(
                    Rect.fromLTRB(
                        biggest.width - 48, 10, biggest.width + 10, 70),
                    biggest),
              ).animate(
                  CurvedAnimation(parent: _controller!, curve: Curves.ease)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: productController.imagesWidget.value[indexListImages][0],
              ))
        ],
      );
    });
  }
}
