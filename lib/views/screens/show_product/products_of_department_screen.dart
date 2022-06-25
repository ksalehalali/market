import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:market/views/screens/show_product/product_details.dart';
import '../../../Assistants/globals.dart';
import '../../../controllers/catgories_controller.dart';
import '../../../controllers/lang_controller.dart';
import '../../../controllers/product_controller.dart';
import '../home/search_area_des.dart';
import 'product_item.dart';

class ProductsOfDepartmentScreen extends StatefulWidget {
  final String depId;
  final bool haveChildren;

  const ProductsOfDepartmentScreen(
      {Key? key, required this.depId, required this.haveChildren})
      : super(key: key);

  @override
  State<ProductsOfDepartmentScreen> createState() =>
      _ProductsOfDepartmentScreenState();
}

class _ProductsOfDepartmentScreenState extends State<ProductsOfDepartmentScreen>
    with SingleTickerProviderStateMixin {
  bool showOneList = false;
  final CategoriesController categoriesController = Get.find();
  final ProductsController productController = Get.find();
  final screenSize = Get.size;

  List colors = [];
  Color color = Colors.grey;
  List<double> opacityColor = [];
  late final AnimationController _controller;
  bool show = false;
  final LangController langController = Get.find();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
    // _controller.addStatusListener((status) {
    //   if(status == AnimationStatus.completed){
    //     //
    //   }
    // });
    if (widget.haveChildren == true) {
      if (categoriesController.departments.length > 0) {
        productController
            .getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);
      } else {
        Timer(200.milliseconds, () {
          if (categoriesController.departments.length > 0) {
            productController
                .getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);
            return;
          } else {
            Timer(200.milliseconds, () {
              if (categoriesController.departments.length > 0) {
                productController.getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);

                return;
              } else {
                Timer(200.milliseconds, () {
                  if (categoriesController.departments.length > 0) {
                    productController.getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);

                    return;
                  } else {
                    Timer(200.milliseconds, () {
                      if (categoriesController.departments.length > 0) {
                        productController.getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);

                        return;
                      } else {
                        Timer(200.milliseconds, () {
                          if (categoriesController.departments.length > 0) {
                            productController.getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);

                            return;
                          } else {
                            Timer(200.milliseconds, () {
                              if (categoriesController.departments.length > 0) {
                                productController.getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);

                                return;
                              } else {
                                Timer(200.milliseconds, () {
                                  if (categoriesController.departments.length >
                                      0) {
                                    productController.getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);

                                    return;
                                  } else {
                                    Timer(200.milliseconds, () {
                                      if (categoriesController
                                              .departments.length >
                                          0) {
                                        productController.getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);

                                        return;
                                      } else {
                                        Timer(200.milliseconds, () {
                                          if (categoriesController
                                                  .departments.length >
                                              0) {
                                            productController.getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);

                                            return;
                                          } else {
                                            Timer(200.milliseconds, () {
                                              if (categoriesController
                                                      .departments.length >
                                                  0) {
                                                productController
                                                    .getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);

                                                return;
                                              } else {
                                                Timer(200.milliseconds, () {
                                                  if (categoriesController
                                                          .departments.length >
                                                      0) {
                                                    productController
                                                        .getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);
                                                    return;
                                                  } else {
                                                    Timer(2200.milliseconds,
                                                        () {
                                                      productController
                                                          .getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);
                                                      return;
                                                    });
                                                  }
                                                  return;
                                                });
                                              }
                                              return;
                                            });
                                          }
                                          return;
                                        });
                                      }
                                      return;
                                    });
                                  }
                                  return;
                                });
                              }
                              return;
                            });
                          }
                          return;
                        });
                      }
                      return;
                    });
                  }
                });
              }
            });
          }
        });
      }
    } else {
      productController.getProductsByCat(widget.depId,langController.appLocal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myHexColor5,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                            productController.cartProducts.value = [];
                            categoriesController.departments.value = [];
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 12, left: 12, bottom: 12),
                            child: SvgPicture.asset(
                                'assets/icons/left arrow.svg',
                                color: Colors.grey[800],
                                height: 27.00,
                                width: 27.0,
                                semanticsLabel: 'A red up arrow'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (showOneList) {
                                showOneList = false;
                              } else {
                                showOneList = true;
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, right: 12, left: 12, bottom: 12),
                            child: showOneList
                                ? SvgPicture.asset('assets/icons/menu.svg',
                                    color: Colors.grey[800],
                                    height: 26.00,
                                    width: 26.0,
                                    semanticsLabel: 'A red up arrow')
                                : SvgPicture.asset(
                                    'assets/icons/menu_category.svg',
                                    color: Colors.grey[800],
                                    height: 29.00,
                                    width: 29.0,
                                    semanticsLabel: 'A red up arrow'),
                          ),
                        ),
                      ],
                    ),
                    const SearchAreaDesign(),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: screenSize.width,
                      height: 2,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              widget.haveChildren == true
                  ? SizedBox(
                      width: screenSize.width,
                      height: screenSize.height * 0.1 - 50,
                      child: _buildDepartmentsOptions())
                  : Container(),
              Center(
                child: Obx(
                  () => productController.gotProductsByCat.value == false
                      ? Lottie.asset(
                          'assets/animations/30826-online-shopping.json',
                          height: 102,
                          width: 222,
                          fit: BoxFit.cover,
                          controller: _controller,
                          onLoaded: (composition) {
                            // Configure the AnimationController with the duration of the
                            // Lottie file and start the animation.
                            _controller
                              ..duration = composition.duration
                              ..forward();
                          },
                        )
                      : Container(),
                ),
              ),
              SizedBox(
                width: screenSize.width,
                height: screenSize.height * 0.6 - 10,
                child: Obx(
                  () => AnimatedOpacity(
                      duration: 600.milliseconds,
                      opacity: productController.opacity.value,
                      child: _buildDepartmentProductsList()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDepartmentsOptions() {
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        Obx(
          () => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                for (int i = 0;
                    i < categoriesController.departments.length;
                    i++) {
                  if (i == 0) {
                    colors.add(myHexColor);
                    opacityColor.add(1.0);
                  } else {
                    opacityColor.add(0.7);
                    colors.add(Colors.black);
                  }
                }
                return InkWell(
                  onTap: () {
                    setState(() {
                      for (int i = 0; i < colors.length; i++) {
                        if (index == i) {
                          colors[index] = myHexColor;
                          opacityColor[index] = 1.0;
                        } else {
                          opacityColor[i] = 0.7;
                          colors[i] = Colors.black;
                        }
                      }
                    });
                    productController.getProductsByCat(categoriesController.departments[0]['id'],langController.appLocal);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.4,
                        color: colors[index].withOpacity(opacityColor[index]),
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            categoriesController.departments[index]['name_EN'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: colors[index]
                                  .withOpacity(opacityColor[index]),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: categoriesController.departments.length,
              semanticIndexOffset: 1,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildDepartmentProductsList() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 0.0),
      child: Container(
        color: Colors.grey[50],
        child: Obx(
          () => GridView.builder(
            itemCount: productController.cartProducts.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            semanticChildCount: 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 6.1,
                childAspectRatio: 0.6),
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.zero,
                  child: ProductItemCard(
                    product: productController.cartProducts[index],
                    fromDetails: false,
                    from: 'dep',
                    press: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          reverseTransitionDuration:
                              const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  FadeTransition(
                            opacity: animation,
                            child: ProductDetails(
                              product:
                                  productController.recommendedProducts[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ));
            },
          ),
        ),
      ),
    );
  }
}
