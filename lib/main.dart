import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geolocator/geolocator.dart' as geo;
import 'package:lottie/lottie.dart';
import 'Assistants/globals.dart';
import 'controllers/address_location_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/catgories_controller.dart';
import 'controllers/lang_controller.dart';
import 'controllers/payment_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/start_up_controller.dart';
import 'services/localization/localization.dart';
import 'views/screens/categories/categories_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final addressController =
      Get.putAsync(() async => AddressController(), permanent: true);
  final productController =
      Get.putAsync(() async => ProductsController(), permanent: true);
  final categoriesController =
      Get.putAsync(() async => CategoriesController(), permanent: true);
  final cartController =
      Get.putAsync(() async => CartController(), permanent: true);
  final langController =Get.putAsync(() async => LangController(),permanent: true);
  final paymentController =Get.putAsync(() async => PaymentController(),permanent: true);

  runApp(DevicePreview(builder: (context)=> ScreenUtilInit(
      designSize: const Size(360, 740),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
    return GetMaterialApp(
      builder: DevicePreview.appBuilder,
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      translations: Localization(),
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    );}
  )));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AddressController addressController = Get.find();
  final startUpController = Get.put(StartUpController());
  late loc.PermissionStatus _permissionGranted;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    locatePosition();
    startUpController.fetchUserLoginPreference();
  }

  var geoLocator = geo.Geolocator();
  loc.Location location = loc.Location.instance;

  geo.Position? currentPos;
  void locatePosition() async {
    loc.PermissionStatus permissionStatus = await location.hasPermission();
    _permissionGranted = permissionStatus;
    if (_permissionGranted != loc.PermissionStatus.granted) {
      final loc.PermissionStatus permissionStatusReqResult =
          await location.requestPermission();

      _permissionGranted = permissionStatusReqResult;
    }

    geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
        forceAndroidLocationManager: true);
    addressController.areaLoc.value =
        LatLng(position.latitude, position.longitude);

    print(position);
  }
  final screenSize = Get.size;

  @override
  Widget build(BuildContext context) {
    print("screen size :: $screenSize");
    return Container(
      padding: EdgeInsets.all(140),
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: FittedBox(
        child: SizedBox(
          width: 80,
          height: 80,

          child: Lottie.asset(
            'assets/animations/loading_black_background_editor.json',
            width: 80,
            height: 80,

          ),
        )
      ),
    );
  }
}
