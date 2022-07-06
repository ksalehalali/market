import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../Assistants/globals.dart';
import '../../controllers/address_location_controller.dart';
import '../screens/main_screen.dart';
import 'address_on_map.dart';
import 'list_addresses.dart';

class AddAddressScreen extends StatefulWidget {
  final bool fromCart;
  const AddAddressScreen({Key? key,required this.fromCart}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  PhoneNumber number = PhoneNumber(isoCode: 'QA');
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'QA');

  final AddressController addressController = Get.find();
  TextEditingController _addresNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = Get.size;

    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.1 - 30,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.location_history,
                    size: 32,
                    color: Colors.green[800],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MainScreen(index: 0)));
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.1 - 60,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                'Location Information',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: myHexColor),
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.1 - 44,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text(
                          addressController.aAddress.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: screenSize.width * 0.7,
                        child: Text(
                          addressController.bAddress.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  AddressOnMap(fromCart: widget.fromCart,)));
                    },
                    child: Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              opacity: 0.7,
                              image: AssetImage(
                                'assets/images/isolate-golden-location-pin.jpg',
                              ),
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 18,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            Text(
                              'Edit',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
              height: 20,
            ),
            SizedBox(
              height: screenSize.height * 0.1,
            ),
            Text(
              'Personal Information',
              style: TextStyle(
                  fontSize: 16, color: myHexColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: screenSize.height * 0.1 - 70,
            ),
            Container(
              width: screenSize.width,
              color: Colors.grey[100],
              //margin: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 14),
                    child: SizedBox(
                      width: screenSize.width * 0.8,
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          print(number.phoneNumber);
                          phoneNumber = number;
                        },
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                          showFlags: false,
                          useEmoji: false,
                          setSelectorButtonAsPrefixIcon: true,
                          leadingPadding: 0.0,
                          trailingSpace: true
                        ),
                        maxLength: 8,
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle:
                            TextStyle(color: Colors.grey[600], fontSize: 22),
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        inputDecoration: InputDecoration(),
                        initialValue: number,
//                            textFieldController: controller,
                        formatInput: false,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputBorder: OutlineInputBorder(),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                          phoneNumber = number;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Theme(
                      data: ThemeData.from(
                        colorScheme: ColorScheme.fromSwatch(
                            primarySwatch: primaryColorSwatch),
                      ),
                      child: SizedBox(
                        width: screenSize.width * 0.8,
                        child: TextFormField(
                          controller: _addresNameController,
                          decoration: InputDecoration(
                              focusColor: myHexColor,
                              hoverColor: myHexColor,
                              label: Text('Name')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.1 - 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addressController.addNewAddress(
                          _addresNameController.text, phoneNumber);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ListAddresses(fromCart: true,fromAccount: false,)));
                    },
                    child: const Text(
                      'SAVE ADDRESS',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                        maximumSize: Size(220, 300),
                        minimumSize: Size(220, 40),
                        primary: myHexColor1,
                        onPrimary: Colors.white,
                        alignment: Alignment.center),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.1 - 60,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
