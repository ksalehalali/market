import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import '../../../Assistants/globals.dart';
import '../../../controllers/address_location_controller.dart';
import '../../../controllers/cart_controller.dart';
import '../../address/addresses_options_dialog.dart';
import '../../address/list_addresses.dart';
import '../../widgets/horizontal_listOfProducts.dart';
import '../main_screen.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

final cartController = Get.put(CartController());

class _CartState extends State<Cart> {
  @override
  void activate() {
    // TODO: implement activate
    super.activate();
    print('active');
  }
  var cartProductsCounts =[];
  final screenSize = Get.size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.getMyCartProds(false);
  }
  final AddressController addressController = Get.find();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final screenSize = Get.size;

    return Container(
      color: myHexColor5.withOpacity(0.6),

      child: SafeArea(
        child: Scaffold(
          body: Container(
            //margin: const EdgeInsets.symmetric(horizontal: 0.0),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Obx(()=>Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (cartController.isCartEmpty.value)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset("${assetsIconDir}sad cart.svg"),
                            const SizedBox(
                              height: 32,
                            ),
                            const Text(
                              "Shopping cart is empty!",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              "Shop now & add things you love to the cart",
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                      )
                    else
                      cartController.gotMyCart.value ==true? Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              // DELIVERY ADDRESS
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/shipping.svg',
                                        color: Colors.grey[600],
                                        height: 22.00,
                                        width: 22.0,
                                        semanticsLabel: 'A red up arrow'),
                                     SizedBox(
                                      width: 8.w,
                                    ),

                                    // TODO: REPLACE THE 'ADDRESS' WORD WITH THE ACTUAL VARIABLE NAME
                                     SizedBox(

                                       width:screenSize.width *.7+27.w,
                                       child: Text(
                                         'Address : ${box.read('address')} ?? Select address',overflow: TextOverflow.ellipsis,maxLines: 1,
                                        style: TextStyle(color: Colors.black54),
                                    ),
                                     ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen()));
                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 0.0.w),
                                        child: const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.black87,
                                          size: 20,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.1 - 70.h,
                              ),
                               Divider(
                                thickness: 1.0,
                                color: myHexColor5,
                              ),
                              SizedBox(
                                height: screenSize.height * 0.1 - 70.h,
                              ),
                              cartController.gotMyCart.value == true
                                  ?buildCartItem()
                                  : Container(),
                            ],
                          ),
                        ),
                      ):Container(),
                    SizedBox(
                      height: screenSize.height * 0.1 - 50.h,
                    ),
                    buildCartDetails(),
                    SizedBox(
                      height: screenSize.height * 0.1 - 50.h,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 12.w),
                      child: Container(
                        child:  Text(
                          "Things you might like",
                          style:
                              TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.1 - 50.h,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 12.w),
                      child: buildHorizontalListOfProducts(false),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.1 - 50.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: buildBuyButton(1),
        ),
      ),
    );

  }

  Widget buildCartDetails() {
    return Container(
      color: const Color.fromARGB(255, 235, 236, 239),
      child: Column(
        children: [
          Padding(
            padding:
                 EdgeInsets.only(top: 12.h, bottom: 18.h, right: 14.w, left: 14.w),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
                height: 44.h,
                width: screenSize.width - 30.w,
                child: Padding(
                  padding:  EdgeInsets.only(right: 10.w, left: 10.w),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefix: InkWell(
                          onTap: () {
                            if (!Get.isSnackbarOpen) {
                              Get.snackbar('Wrong code!',
                                  "Please check the code you entered",
                                  colorText: Colors.red,
                                  backgroundColor: Colors.white);
                            }
                          },
                          child: Text(
                            'APPLY  | ',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: myHexColor4),
                          )),
                      hintText: ' Enter the discount code',
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                 Text(
                  "Products price",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 60, 63, 73)),
                ),
                const Spacer(),
                Obx(
                  () => Text(
                    cartController.fullPrice.toStringAsFixed(2),
                    style:  TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 60, 63, 73)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children:  [
                Text(
                  "Shipping fee",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 60, 63, 73)),
                ),
                Spacer(),
                Text(
                  "0.0 QAR",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 60, 63, 73)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                 Text(
                  "Total",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 60, 63, 73)),
                ),
                const Spacer(),
                Obx(
                  () => Text(
                    cartController.fullPrice.toStringAsFixed(2),
                    style:  TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 60, 63, 73)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBuyButton(double price) {
    return Card(
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
                onTap: () {
                 if(cartController.myPrCartProducts.length >0){
                   addressController.addingAddressForOrder.value = true;
                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ListAddresses(fromCart: true,fromAccount: false,)));
                 }
                },
                child: Container(
                  height: 54.h,
                  color:myHexColor2,
                  child: Center(
                      child: Obx(
                    () =>cartController.myPrCartProducts.length >0? Text(
                      cartController.myPrCartProducts.length > 1
                          ? 'BUY ${cartController.myPrCartProducts.length} ITEMS FOR ${cartController.fullPrice.value.toStringAsFixed(2)}  QAR'
                          : 'BUY ${cartController.myPrCartProducts.length} ITEM FOR ${cartController.fullPrice.value.toStringAsFixed(2)}  QAR',
                      style: const TextStyle(color: Colors.white),
                    ): Text('Cart is empty',style:  TextStyle(color: Colors.white,fontSize: 14.sp,fontWeight: FontWeight.w600),),
                  )),
                )),
          ),
        ],
      ),
    );
  }

  Column buildCartItem() {
    cartController.cartItems.value = [];

    print("length ${cartController.myPrCartProducts.length}");
    // this list will be filled form the API
    for (int i = 0; i < cartController.myPrCartProducts.length; i++) {
      var price = num.parse(cartController.myPrCartProducts[i]["price"]) *
          num.parse(cartController.myPrCartProducts[i]["offer"]) /
          100;
      cartController.countFromItem.value =cartController.myPrCartProducts[i]['number'];
      cartProductsCounts.add(cartController.myPrCartProducts[i]['number']);

      cartController.cartItems.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2,
            ),
            SizedBox(
              width: screenSize.width -30,
              child: Text(
                "${cartController.myPrCartProducts[i]['product']}",overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${cartController.myPrCartProducts[i]["color"]}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${cartController.myPrCartProducts[i]["size"]}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: screenSize.width * 0.4 + 10,
                      child: Row(
                        children: [
                          Text(
                            "${cartController.myPrCartProducts[i]["price"]} QAR".toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontFamily: 'Montserrat-Arabic Regular',
                                color: Colors.grey,
                                fontSize: 13),
                          ),
                          const SizedBox(
                            width: 7.0,
                          ),
                          Text(
                            "Discount ${cartController.myPrCartProducts[i]["offer"]}%",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Montserrat-Arabic Regular',
                                color: myHexColor3,
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14,),
                    Text(
                      "${num.parse(cartController.myPrCartProducts[i]["price"]) - price} QAR",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "seller ${cartController.myPrCartProducts[i]['userName']}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 100,
                    child: Image.network(
                      "$baseURL/${cartController.myPrCartProducts[i]['image']}",
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding:  EdgeInsets.symmetric(vertical: 10.0.h,horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(245, 246, 248, 1),
                      border: Border.all(),
                      borderRadius:
                      const BorderRadius.all(const Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: (){
                           setState(() {
                             if(cartProductsCounts[i]>1){
                               cartProductsCounts[i]--;
                               cartController.editProdCountCart(
                                   cartController.myPrCartProducts[i]['id'],cartProductsCounts[i],num.parse(cartController.myPrCartProducts[i]["price"])-price,false);
                             }
                           });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(22)
                            ),
                            child:  Icon(Icons.remove,color: Colors.grey[600],),
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Text("${cartProductsCounts[i]}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                        const SizedBox(
                          width: 18,
                        ),
                        InkWell(
                          onTap: () {
                           setState(() {

                              cartProductsCounts[i]++;
                             // print(cartProductsCounts[i]);
                              cartController.editProdCountCart(
                                cartController.myPrCartProducts[i]['id'],cartProductsCounts[i],num.parse(cartController.myPrCartProducts[i]["price"])-price,true);
                           });

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(22)
                            ),
                            child:  Icon(Icons.add,color: Colors.grey[600],),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (() => cartController.deleteProdFromCart(cartController.myPrCartProducts[i]['id'])),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:  [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.red[700],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Remove",textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.red[700]),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Divider(
              thickness: 1.5,
              color: myHexColor5.withOpacity(0.7),
            )
          ],
        ),
      );
      cartController.itemsInserted.value = true;

    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...cartController.cartItems],
    );
  }
}
