import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/product_model.dart';
import '../../widgets/horizontal_listOfProducts.dart';
import '../auth/register.dart';
import '../categories/categories_screen.dart';
import '../order/Cart.dart';
import '../home/account.dart';
import '../home/home.dart';
import '../home/search_area_des.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel? product;

  const ProductDetails({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

int indexListImages = 0;
double scaleOfCart=1.0;
double scaleOfItem=1.0;

int duration = 800;
class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ProductsController productController = Get.find();
  final CartController cartController = Get.find();

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
  final Color? _colorColorC = myHexColor3;
  final Color? _color2C = Colors.grey[700];
  bool showOver = false;
  bool showSpec = false;
  List sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  var urlImages = [];

  Widget? flyingcart = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.getMyCartProds(false);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    final bool success =
    await productController.addProductToFav(widget.product!.id!);

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
      child: Obx(()=>Stack(
          key: const Key('s2'),
          children: [

                  productController.getDetailsDone.value == true?  Obx(() =>Container(
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

                            child: Column(key: const Key('l'),
                             // padding: EdgeInsets.zero,
                             // shrinkWrap: true,
                              children: [
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();

                                        print(
                                            productController.latestProducts.length);
                                      },
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(right: 12.0, left: 10),
                                        child: SvgPicture.asset(
                                            'assets/icons/left arrow.svg',
                                            alignment: Alignment.center,
                                            //color:,
                                            height: 22,
                                            width: 22,
                                            semanticsLabel: 'A red up arrow'),
                                      ),
                                    ),
                                    const Expanded(child: SearchAreaDesign()),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => const Cart()));
                                      },
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 5),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              AnimatedScale(
                                                scale: scaleOfCart,
                                                duration: duration.milliseconds,
                                                alignment: Alignment.center,
                                                curve: Curves.easeInOutBack,
                                                child: SvgPicture.asset(
                                                    'assets/icons/cart-fill.svg',
                                                    alignment: Alignment.center,
                                                    //color:,
                                                    height: 29,
                                                    width: 29,
                                                    semanticsLabel: 'A red up arrow'),
                                              ),
                                              Positioned(
                                                  right: 0.0,
                                                  top: 0.0,
                                                  child: Container(
                                                      height: 14,
                                                      width: 14,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(20),
                                                          color: const Color.fromARGB(
                                                              255, 246, 138, 24)),
                                                      child: Center(
                                                        child: Obx(
                                                              () =>
                                                              Text(
                                                                cartController
                                                                    .myPrCartProducts
                                                                    .length
                                                                    .toString(),
                                                                textAlign: TextAlign
                                                                    .center,
                                                                style: const TextStyle(
                                                                    fontSize: 10,
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
                                Obx(()=>Stack(
                                    key:const Key('s') ,
                                    children: [
                                      productController.getDetailsDone.value == true
                                          ? Column(
                                        children: [
                                          SizedBox(
                                            height: screenSize.height * 0.4,
                                            width: double.infinity,
                                            child:
                                            // InkWell(
                                            //     onTap: (){
                                            //       gallery();
                                            //     },
                                            //     child: Ink.image(image: NetworkImage("$baseURL/${productController.imagesData[0].imagesUrls[0]}",),height: 300,))

                                            Obx(
                                                  () =>
                                                  Carousel(
                                                    onImageTap: (i) {
                                                      print(i);
                                                      gallery(i);
                                                    },
                                                    dotSize: 4.0,
                                                    dotSpacing: 15.0,
                                                    dotVerticalPadding: 00,
                                                    indicatorBgPadding: 14,
                                                    autoplay: false,
                                                    autoplayDuration: 7.seconds,
                                                    animationDuration: 900.milliseconds,
                                                    dotBgColor: Colors.transparent
                                                        .withOpacity(0.1),
                                                    dotColor: Colors.white,
                                                    dotIncreasedColor: Colors.red,
                                                    dotPosition: DotPosition.bottomLeft,
                                                    images: productController
                                                        .imagesWidget
                                                        .value[indexListImages],
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ) : Container(),

                                      productController.getDetailsDone.value == true
                                          ? Positioned(
                                          top: 8.0,
                                          left: 10.0,
                                          width: screenSize.width * .1 - 0,
                                          height: screenSize.width * .1 - 0,
                                          child: LikeButton(
                                            size: buttonSize,
                                            onTap: onLikeButtonTapped,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            // padding: EdgeInsets.only(
                                            //     left: screenSize.width * .1 - 37,
                                            //     top: 2),
                                            circleColor: const CircleColor(
                                                start: Color(0xff00ddff),
                                                end: Color(0xff0099cc)),
                                            bubblesColor: const BubblesColor(
                                              dotPrimaryColor: Color(0xff33b5e5),
                                              dotSecondaryColor: Color(0xff0099cc),
                                            ),
                                            likeBuilder: (bool isLiked) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: SvgPicture.asset('assets/icons/heart.svg',
                                                      alignment: Alignment.center,
                                                      color: isLiked ? myHexColor3 : Colors.grey[600],
                                                      height: buttonSize,
                                                      width: buttonSize,
                                                      semanticsLabel: 'A red up arrow'),
                                                ),
                                              );
                                            },
                                          ))
                                          : Container(),
                                      productController.getDetailsDone.value == true
                                          ? Positioned(
                                        top: screenSize.height * .1 - 28,
                                        left: 10.0,
                                        child: Container(
                                          padding: EdgeInsets.zero,
                                          margin: EdgeInsets.zero,
                                          width: screenSize.width * .1 - 5,
                                          height: screenSize.width * .1 - 5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(100),
                                              color: Colors.white.withOpacity(.9)),
                                          child: LikeButton(
                                            size: buttonSize -10,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            onTap: (isLiked) async {
                                              print('share');
                                              return isLiked;
                                            },

                                            circleColor: const CircleColor(
                                                start: Colors.grey, end: Colors.grey),
                                            bubblesColor: const BubblesColor(
                                              dotPrimaryColor: Color(0xff33b5e5),
                                              dotSecondaryColor: Color(0xff0099cc),
                                            ),
                                            likeBuilder: (bool isLiked) {
                                              return SvgPicture.asset(
                                                  'assets/icons/share3.svg',
                                                  alignment: Alignment.center,
                                                  color: isLiked
                                                      ? myHexColor3
                                                      : Colors.grey,
                                                  height: buttonSize,
                                                  width: buttonSize,
                                                  semanticsLabel: 'A red up arrow');
                                            },
                                          ),
                                        ),
                                      )
                                          : Container()
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Obx(()=>Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        Text(
                                          '${productController.productDetails.providerName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: myHexColor1),
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.1 - 76,
                                        ),
                                        Text(
                                          productController.productDetails.en_name!.toUpperCase(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.1 - 76,
                                        ),
                                        Text(
                                          '${productController.productDetails.price! -
                                              productController.offerFromPrice
                                                  .value} QAR',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.1 - 60,
                                        ),
                                        const Text(
                                          'Size',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(height: 2,),

                                        _buildSizesOptions(screenSize),
                                        const SizedBox(
                                          height: 22.0,
                                        ),
                                        const Text(
                                          'Color',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(height: 2,),
                                        _buildColorsOptions(screenSize),
                                        const SizedBox(
                                          height: 22.0,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey[500]!,
                                              )),
                                          width: screenSize.width,
                                          height: screenSize.height * 0.1 - 30,
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              SvgPicture.asset(
                                                  'assets/icons/shipping.svg',
                                                  color: Colors.grey[600],
                                                  height: 18.00,
                                                  width: 18.0,
                                                  semanticsLabel: 'A red up arrow'),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              const Text('Delivery time :'),
                                              const Spacer(),
                                              const Text(' Jan 28 - Jan 30'),
                                              SizedBox(
                                                width: screenSize.width * 0.1 - 12,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 18.0, horizontal: 12),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/images/svg/9593997931634472866.svg',
                                                      // color: Colors.black,
                                                      height: 21.00,
                                                      width: 21.0,
                                                      semanticsLabel: 'A red up arrow'),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  const Text(
                                                    'Seller',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 15),
                                                  ),
                                                  const SizedBox(
                                                    width: 8.0,
                                                  ),
                                                  Text(
                                                    'QR Market',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                        color: myHexColor3),
                                                  ),
                                                  const Spacer(),
                                                  const Icon(
                                                      Icons.keyboard_arrow_right)
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          AnimatedContainer(
                                              duration: 11.seconds,
                                              curve: Curves.easeIn,
                                              child: Text('Overview',
                                                  style: TextStyle(
                                                      color: _color,
                                                      fontWeight: FontWeight.w500))),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeInOut,
                                            width: screenSize.width / 2,
                                            height: 2.5,
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
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          AnimatedContainer(
                                              curve: Curves.easeIn,
                                              duration: 14.seconds,
                                              child: Text(
                                                'Specifications',
                                                style: TextStyle(
                                                    color: _color2,
                                                    fontWeight: FontWeight.w500),
                                              )),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          AnimatedContainer(
                                            curve: Curves.easeInOut,
                                            width: screenSize.width / 2,
                                            height: 2.5,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14.0, horizontal: 12),
                                      child: Text(
                                        'Specifications',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 12),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              child: Text(
                                                'Specifications',
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              width: screenSize.width * .5 - 30),
                                          SizedBox(
                                              width: screenSize.width * 0.5,
                                              child: Text(
                                                'Specifications Specifications Specifications Specifications Specifications',
                                                maxLines: 3,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[800],
                                                  fontSize: 11,
                                                ),
                                              )),
                                          const Spacer()
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: myHexColor3.withOpacity(0.4),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 12),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                child: Text(
                                                  'Color name',
                                                  style: TextStyle(
                                                      color: Colors.grey[900],
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                width: screenSize.width * .5 - 30),
                                            SizedBox(
                                                width: screenSize.width * 0.5,
                                                child: Text(
                                                  productController.productDetails
                                                      .colorsData![0]['color'],
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w500),
                                                )),
                                            const Spacer()
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 12),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: screenSize.width * .5 - 30,
                                              child: Text(
                                                'Department',
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600),
                                              )),
                                          Text(
                                            productController
                                                .productDetails.categoryNameEN!,
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[800],
                                              fontSize: 11,
                                            ),
                                          ),
                                          const Spacer()
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: myHexColor3.withOpacity(0.4),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 12),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: screenSize.width * .5 - 30,
                                                child: Text(
                                                  'Offer',
                                                  style: TextStyle(
                                                      color: Colors.grey[900],
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600),
                                                )),
                                            Text(
                                              '${productController.productDetails.offer.toString()} %',
                                              maxLines: 3,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const Spacer()
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 12),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: screenSize.width * .5 - 30,
                                              child: Text(
                                                'Material',
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600),
                                              )),
                                          Text(
                                            'any',
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[800],
                                              fontSize: 11,
                                            ),
                                          ),
                                          const Spacer()
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: myHexColor3.withOpacity(0.4),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 12),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: screenSize.width * .5 - 30,
                                                child: Text(
                                                  'Material Composition',
                                                  style: TextStyle(
                                                      color: Colors.grey[900],
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600),
                                                )),
                                            Text(
                                              '100% any',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const Spacer()
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 12),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: screenSize.width * .5 - 30,
                                              child: Text(
                                                'Model Number',
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w600),
                                              )),
                                          Text(
                                            productController
                                                .productDetails.modelName!,
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[800],
                                              fontSize: 11,
                                            ),
                                          ),
                                          const Spacer()
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: myHexColor3.withOpacity(0.4),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 12),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: screenSize.width * .5 - 30,
                                                child: Text(
                                                  'Merchant',
                                                  style: TextStyle(
                                                      color: Colors.grey[900],
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600),
                                                )),
                                            Text(
                                              productController
                                                  .productDetails.providerName!,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:  [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              right: 12.0,
                                              left: 12.0,
                                              top: 22.0,
                                              bottom: 10),
                                          child: Text(
                                            'Highlights',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1.0, horizontal: 12),
                                          child: Text(
                                            productController.productDetails.desc_EN.toString(),
                                            maxLines: 6,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 150,
                                        )
                                      ],
                                  ),
                                ),
                                    ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12.0, left: 12.0, top: 22.0, bottom: 10),
                                    child: Text(
                                      'More from ${productController.product.value
                                          .brand}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                                buildHorizontalListOfProducts(true),
                                const SizedBox(
                                  height: 60,
                                ),
                              ],
                            ),
                          ),
                        ),
                        bottomSheet: productController.getDetailsDone.value == true
                            ? buildAddCartPrice(
                            productController.productDetails.price!,
                            productController.productDetails.offer,indexListImages)
                            : Container(),
                      ),
                    ),
                  )
            ):_buildShimmerLoadingData(),

            Container(
              margin: EdgeInsets.only(top: screenSize.height *0.1 -54),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height -50,
              child: flyingcart == null ? Container() : flyingcart,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoadingData(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenSize.height *0.1/7,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0,horizontal: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.4-10,
              width: screenSize.width,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.1-60,
              width: screenSize.width *0.4,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 22.0,right: 12,left: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.1-62,
              width: screenSize.width,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.1-62,
              width: screenSize.width,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              height: screenSize.height * 0.1-62,
              width: screenSize.width,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        SizedBox(height: 60,),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 12),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: screenSize.height * 0.1-30,
                  width: screenSize.width *0.2,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 12),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: screenSize.height * 0.1-30,
                  width: screenSize.width *0.2,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 12),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[300]!,
                child: Container(
                  height: screenSize.height * 0.1-30,
                  width: screenSize.width *0.2,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 60,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: screenSize.height * 0.1-70,
              width: screenSize.width,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: screenSize.height * 0.1-70,
              width: screenSize.width,
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
      height: 36,
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
                    productController.currentSizeSelected.value = productController.sizes[index]['size'];
                    productController.currentSizeIdSelected.value = productController.sizes[index]['sizeID'];
                    print("size is = ${productController.sizes[index]['sizeID']}");
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
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 24,
                      width: 78,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.2, color: _colorSizeBorder[index])),
                      child: Center(
                        child: Text(
                          productController.sizes[index]['size'],
                          style: TextStyle(
                              color: _colorSize[index],
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
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
      height: 36,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                _colorColor.add(Colors.grey[800]!);
                _colorColorBorder.add(Colors.grey[400]!);

                return InkWell(
                  onTap: () {
                    productController.currentColorSelected.value  = productController.imagesData[index].color;
                    productController.currentColorIdSelected.value =productController.imagesData[index].colorId;
                    print('current color id = ${productController.imagesData[index].colorId}');
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
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      height: 24,
                      width: 78,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.2, color: _colorColorBorder[index])),
                      child: Center(
                        child: Text(
                          productController.imagesData[index].color,
                          style: TextStyle(
                              color: _colorColor[index],
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: productController.imagesData.length,
              semanticIndexOffset: 0,
            ),
          )
        ],
      ),
    );
  }

  Widget buildAddCartPrice(double price, int? offer,int indexImage) {
    return Card(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
                onTap: () {
                  //when this button is pressed, a flying cart display
                  setState(() {
                    duration =800;
                    scaleOfCart=1.5;
                    scaleOfItem =1.2;
                    flyingcart = const Flyingcart();
                    //wait 2 second
                  });

                  Future.delayed(const Duration(milliseconds: 800), () {
                    setState(() {
                      scaleOfItem=0;
                      duration = 500;
                      scaleOfCart=1.0;
                    });
                  });

                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      flyingcart = null;
                      //hide flycart and add number
                    });
                  });


                  cartController.addToCart(
                      productController.productData['id'],
                      productController.productData['image'][0]['colorID'],
                      productController.productData['size'][0]['sizeID'],).then((value) =>
                      showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          transitionDuration: 500.milliseconds,
                          barrierLabel: MaterialLocalizations.of(context).dialogLabel,
                          barrierColor: Colors.black.withOpacity(0.5),
                          pageBuilder: (context,_,__){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: screenSize.width,
                                  color: Colors.white,
                                  child: Card(
                                    child:Column(
                                      children: [
                                        const SizedBox(height: 55,),
                                        Container(
                                          margin: const EdgeInsets.only(left: 10,right: 10),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset('assets/icons/done.svg',width: 34,height: 34,color: myHexColor,),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 4.0),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,

                                                          children:  [
                                                            SizedBox(
                                                              width: screenSize.width *0.4,
                                                              child: const Text('iphone 12 232323 32323 32323 2323 23233 32',maxLines: 1,overflow:TextOverflow.ellipsis,style:  TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w700,
                                                                color: Colors.black87
                                                              ),),
                                                            ),
                                                            Text('Added to cart ',style:  TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w700,
                                                                color: Colors.black87
                                                            ),),
                                                          ],
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 80.0),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children:  [
                                                            const Text('Cart Total',style:  TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w700,
                                                                color: Colors.black87
                                                            ),),
                                                            Obx(()=> Text(cartController.fullPrice.value.toStringAsFixed(2),style:  const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: Colors.black87
                                                              ),),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 12,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();

                                              },
                                              style: ElevatedButton.styleFrom(
                                                  maximumSize: Size(200,220),
                                                  minimumSize: Size(18, 34),
                                                  primary: Colors.green[800],
                                                  onPrimary: Colors.green[900],
                                                  alignment: Alignment.center),
                                              child: Text('CONTINUE SHOPPING',maxLines:1,style: const TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Cart()));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  maximumSize: Size(200,220),
                                                  minimumSize: Size(180, 34),
                                                  primary: myHexColor,
                                                  onPrimary: Colors.white,
                                                  alignment: Alignment.center),
                                              child: const Text('CHECKOUT',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
                                            ),
                                          ],
                                        )
                                      ],
                                    ) ,
                                  ),
                                )
                              ],
                            );
                          },
                          transitionBuilder: (context,animation,secondaryAnimation,child){
                            return SlideTransition(position: CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOutCubic,
                            ).drive(Tween<Offset>(
                                begin: const Offset(0,-1.0),
                                end:Offset.zero
                            ),),
                              child: child,);
                          }

                      ),
                  );
                },
                child: Container(
                  height: 54,
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
            height: 44,
            width: 130,
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

  void gallery(int i) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) =>
              GalleryWidget(
                  index: i,
                  urlImages:
                  productController.imagesData[indexListImages].imagesUrls)));
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
                  padding: const EdgeInsets.only(
                      top: 33, bottom: 20, right: 20, left: 20),
                  child: Text(
                    'image ${index + 1}/${widget.urlImages.length}',
                    style: TextStyle(fontSize: 22, color: myHexColor),
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


  const Flyingcart({Key? key,}) : super(key: key);


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
                            biggest.width - 48, 10, biggest.width +10, 70),
                        biggest),
                  ).animate(
                      CurvedAnimation(
                          parent: _controller!, curve: Curves.ease)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                    child: productController
                        .imagesWidget
                        .value[indexListImages][0],
                  ))
            ],
          );
        });
  }
}
