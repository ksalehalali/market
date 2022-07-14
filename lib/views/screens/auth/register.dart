
// ignore_for_file: sized_box_for_whitespace, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Assistants/globals.dart';
import '../../../controllers/lang_controller.dart';
import '../../../controllers/register_controller.dart';
import '../account/account.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final registerController = Get.put(RegisterController());

  final signUpUsernameController = TextEditingController();
  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpConfirmPasswordController = TextEditingController();


  RxBool showSignUp = false.obs;
  bool moveWidgets = false;
  RxBool instantlyTransitionedWidgets = false.obs;
  bool disabilitySwitch = false; // When false, login text fields are not disabled, sign up text fields are.
  double stackHeight = Get.size.height * 0.8;

  double opacity = 1.0;

  List<Widget> stackItems = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stackItems = [
//       TOGGLE SIGN UP
      Obx(() =>  AnimatedOpacity(
        opacity: showSignUp.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 0),
        child: Column(
          children: [
            const SizedBox(height: 32,),
            // WELCOME
            Container(
              alignment: Alignment.center,
              child: Text(
                "Create A New Account_txt".tr,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
            ),
            const SizedBox(height: 32,),
            // USERNAME TEXT FIELD
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username_txt".tr,
                  style: TextStyle(
                    color: myHexColor2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Theme(
                  data: ThemeData.from(
                    colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColorSwatch),
                  ),
                  child: TextField(
                    controller: registerController.signUpUsernameController,
                    enabled: showSignUp.value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            // EMAIL TEXT FIELD
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email_txt".tr,
                  style: TextStyle(
                    color: myHexColor2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Theme(
                  data: ThemeData.from(
                    colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColorSwatch),
                  ),
                  child: TextField(
                    controller: registerController.signUpEmailController,
                    enabled: showSignUp.value,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            // PASSWORD TEXT FIELD
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password_txt".tr,
                  style: TextStyle(
                    color: myHexColor2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Theme(
                  data: ThemeData.from(
                    colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColorSwatch),
                  ),
                  child: TextField(
                    controller: registerController.signUpPasswordController,
                    enabled: showSignUp.value,
                    obscureText: true,
                    decoration: InputDecoration(
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            // PASSWORD CONFIRM TEXT FIELD
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Confirm Password_txt".tr,
                  style: TextStyle(
                    color: myHexColor2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Theme(
                  data: ThemeData.from(
                    colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColorSwatch),
                  ),
                  child: TextField(
                    controller: registerController.signUpConfirmPasswordController,
                    enabled: showSignUp.value,
                    obscureText: true,
                    decoration: InputDecoration(
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32,),
          ],
        ),
      ),),

//       TOGGLE LOGIN
      Obx(() =>  AnimatedOpacity(
        opacity: !showSignUp.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32,),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Welcome again !_txt".tr,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
            ),
            const SizedBox(height: 42,),
            // EMAIL TEXT FIELD
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email_txt".tr,
                  style: TextStyle(
                    color: myHexColor2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Theme(
                  data: ThemeData.from(
                    colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColorSwatch),
                  ),
                  child: TextField(
                    controller: registerController.loginEmailController,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            // PASSWORD TEXT FIELD
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password_txt".tr,
                  style: TextStyle(
                    color: myHexColor2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Theme(
                  data: ThemeData.from(
                    colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColorSwatch),
                  ),
                  child: TextField(
                    controller: registerController.loginPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            // FORGOT PASSWORD?
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {

                },
                child: Container(
                  alignment: Alignment.topRight,
                  child:  Text(
                    "Forgot Password ?_txt".tr,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32,),
          ],
        ),
      ),),

    ];
    autoLang();
  }

  //lng
  final LangController langController = Get.find();
  void autoLang()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var lang = await prefs.getString('lang');
    print("lang ====== lang === $lang");
    if(lang !=null){
      langController.changeLang(lang);
      Get.updateLocale(Locale(lang));
      langController.changeDIR(lang);
      print(Get.deviceLocale);
      print(Get.locale);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          width: Get.size.width,
          height: Get.size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16,),
                // CLOSE
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      registerController.accountController.signOut();
                      Get.off(Account());
                    },
                  ),
                ),
                // LOGIN / SIGN UP SWITCH
                Container(
                  width: Get.size.width,
                  height: stackHeight,
                  child: Stack(
                    children: [
                      stackItems[0],
                      stackItems[1],
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 500),
                        top: moveWidgets ? 450 : 360,
                        child: Column(
                          children: [
                            // LOGIN / SIGN UP BUTTON
                            Container(
                              height: 60,
                              width: Get.size.width,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(myHexColor2),
                                ),
                                onPressed: () async{
                                  if(!instantlyTransitionedWidgets.value){
                                    registerController.isRegisterLoading.value = true;
                                    await registerController.makeLoginRequest();
                                    registerController.isRegisterLoading.value = false;
                                  } else {
                                    registerController.isRegisterLoading.value = true;
                                    await registerController.makeRegisterRequest();
                                    registerController.isRegisterLoading.value = false;
                                  }
                                },
                                child: Obx(() =>  !registerController.isRegisterLoading.value ? Text(
                                  !instantlyTransitionedWidgets.value ? "Login_txt".tr: "Create A New Account",
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ): Container(
                                  width: 36,
                                  height: 36,
                                  child:  Container()
                                ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32,),
                            // LOGIN OPTION TEXT
                             Text(
                              "Or login via social media account_txt".tr,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 32,),
                            // SOCIAL MEDIA OPTIONS
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // FACEBOOK
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: SvgPicture.asset("assets/images/svg/facebook2.svg", width: 25,height: 25,),
                                ),
                                const SizedBox(width: 32,),
                                // GOOGLE
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: SvgPicture.asset("assets/images/svg/google.svg", width: 25,height: 25,),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16,),
                            // NEW USER / ALREADY HAVE AN ACCOUNT
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  !instantlyTransitionedWidgets.value ? "New User ?  _txt".tr: "Already have an account ? _txt".tr,
                                  style: TextStyle(

                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      registerController.loginEmailController.text = "";
                                      registerController.loginPasswordController.text = "";
                                      registerController.signUpUsernameController.text = "";
                                      registerController.signUpEmailController.text = "";
                                      registerController.signUpPasswordController.text = "";
                                      registerController.signUpConfirmPasswordController.text = "";

                                      Widget temp = stackItems[0];
                                      stackItems[0] = stackItems[1];
                                      stackItems[1] = temp;

                                      instantlyTransitionedWidgets.value = !instantlyTransitionedWidgets.value;
                                      if(!moveWidgets){
                                        opacity = 1.0;
                                        stackHeight = Get.size.height * 1.0;
                                        moveWidgets = !moveWidgets;
                                        Future.delayed(const Duration(milliseconds: 500), () {
                                          setState(() {
                                            showSignUp.value = !showSignUp.value;
                                            print("moveWidgets: ${moveWidgets} showSignUp: ${showSignUp.value}");
                                          });
                                        });
                                      } else {
                                        opacity = 1.0;
                                        showSignUp.value = !showSignUp.value;
                                        print("moveWidgets: ${moveWidgets} showSignUp: ${showSignUp.value}");
                                        Future.delayed(const Duration(milliseconds: 500), () {
                                          setState(() {
                                            moveWidgets = !moveWidgets;
                                            Future.delayed(const Duration(milliseconds: 500), () {
                                              setState(() {
                                                stackHeight = Get.size.height * 0.80;
                                              });
                                            });
                                          });
                                        });
                                      }

                                    });
                                  },
                                  child: Text(
                                    !instantlyTransitionedWidgets.value ? "Create A New Account_txt".tr: "Login_txt".tr,
                                    style: TextStyle(
                                      color: myHexColor2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}