import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/address_location_controller.dart';

Widget addressHomeScreen(MediaQueryData screenSize) {
  final box = GetStorage();
  final AddressController addressController = Get.find();

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SvgPicture.asset('assets/icons/shipping.svg',
          color: Colors.grey[600],
          height: 22.00,
          width: 22.0,
          semanticsLabel: 'A red up arrow'),
      SizedBox(
        width: screenSize.size.width * 0.1 - 30,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Get.size.width - 70,
            height: 16,
            child: RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: 'Delivery Address ',
                  style: TextStyle(fontSize: 13, color: Colors.black)),
              TextSpan(
                  text: box.read('address') ?? 'Add New Address',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis)),
            ])),
          ),

          Obx(
            () => AnimatedSize(
              duration: 300.milliseconds,
              child: Padding(
                padding: EdgeInsets.zero,
                child: Icon(
                  FontAwesomeIcons.angleRight,
                  color: Colors.blue[900],
                  size: addressController.addressWidgetIconSize.value,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
