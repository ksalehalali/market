import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../Assistants/globals.dart';
import '../Assistants/request-assistant.dart';
import '../models/placePredictions.dart';
import '../models/product_model.dart';

import '../Data/current_data.dart';
import '../models/product_colors_data.dart';
import '../views/address/config-maps.dart';
import 'address_location_controller.dart';
import 'base_controller.dart';

class ProductsController extends GetxController with BaseController{
  var latestProducts = <ProductModel>[].obs;
  var recommendedProducts = <ProductModel>[].obs;
  var offersProducts = <ProductModel>[].obs;
  List productPredictionList = [].obs;

  var cartProducts = <ProductModel>[].obs;
  var favProducts = [].obs;

  var gotProductsByCat = false.obs;
  var gotProductDetails = false.obs;

  var product = ProductModel().obs;
  var opacity = 0.0.obs;

  ProductModel productDetails = ProductModel();
  var colorsData = [].obs;
  var imagesData = [].obs;
  var getDetailsDone = false.obs;
  var imagesWidget = [[], [], [], [], []].obs;
  dynamic imagesWidget2 = [[], [], [], [], []];

  var productData = {};
  var sizes = [];
  var colors = [];
  var currentSizeSelected = ''.obs;
  var currentColorSelected = ''.obs;
  var currentSizeIdSelected = ''.obs;
  var currentColorIdSelected = ''.obs;

  var offerFromPrice = 0.0.obs;

  Future getLatestProducts() async {
    var headers = {
      'Authorization': 'bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$baseURL/api/ListProduct'));
    request.body = json.encode({"PageNumber": 0, "PageSize": 50});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      latestProducts.value = [];
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];

      for (int i = 0; i < data.length; i++) {
        latestProducts.add(ProductModel(
          id: data[i]['id'],
          en_name: data[i]['name_EN'],
          ar_name: data[i]['name_AR'],
          price: double.parse(data[i]['price'].toString()),
          offer: data[i]['offer'],
          imageUrl: data[i]['image'],
          catId: data[i]['catID'],
          categoryNameEN: data[i]['categoryName_EN'],
          categoryNameAR: data[i]['categoryName_AR'],
          modelName: data[i]['modelName'],
          modelId: data[i]['modelID'],
          userId: data[i]['userID'],
          userName: data[i]['userName'],
          providerName: data[i]['userName'],
          providerId: data[i]['userID'],
          brand: data[i]['brandName'],
        ));
      }
      print('latest products count :: ${latestProducts.length}');
      update();
    } else {
      print(response.reasonPhrase);
    }
    update();
  }


//get products by cat
  Future getProductsByCat(String catId) async {
    cartProducts.value = [];
    opacity.value = 0.0;
    gotProductsByCat.value = false;
    var headers = {
      'Authorization': 'bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('$baseURL/api/ListProductByCategory'));
    request.body = json.encode({"id": catId, "PageNumber": 0, "PageSize": 50});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      cartProducts.value = [];
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];

      for (int i = 0; i < data.length; i++) {
        cartProducts.add(ProductModel(
          id: data[i]['id'],
          en_name: data[i]['name_EN'],
          ar_name: data[i]['name_AR'],
          price: double.parse(data[i]['price'].toString()),
          offer: data[i]['offer'],
          imageUrl: data[i]['image'],
          catId: data[i]['catID'],
          categoryNameEN: data[i]['categoryName_EN'],
          categoryNameAR: data[i]['categoryName_AR'],
          modelName: data[i]['modelName'],
          modelId: data[i]['modelID'],
          userId: data[i]['userID'],
          userName: data[i]['userName'],
          providerName: data[i]['userName'],
          providerId: data[i]['userID'],
          brand: data[i]['brandName'],
        ));
      }
      gotProductsByCat.value = true;
      opacity.value = 1.0;
      print(' products count :: ${cartProducts.length}');
      update();
    } else {
      print(response.reasonPhrase);
    }
    update();
  }

  //get products by cat home
  Future getProductsByCatHome(String catId, String cat) async {
    print(cat);
    cartProducts.value = [];
    opacity.value = 0.0;
    gotProductsByCat.value = false;

    var headers = {
      'Authorization': 'bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('$baseURL/api/ListProductByCategory'));
    request.body = json.encode({"id": catId, "PageNumber": 0, "PageSize": 50});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];

      if (cat == 'latest') {
        latestProducts.value = [];
        for (int i = 0; i < data.length; i++) {
          latestProducts.add(ProductModel(
            id: data[i]['id'],
            en_name: data[i]['name_EN'],
            ar_name: data[i]['name_AR'],
            price: double.parse(data[i]['price'].toString()),
            offer: data[i]['offer'],
            imageUrl: data[i]['image'],
            catId: data[i]['catID'],
            categoryNameEN: data[i]['categoryName_EN'],
            categoryNameAR: data[i]['categoryName_AR'],
            modelName: data[i]['modelName'],
            modelId: data[i]['modelID'],
            userId: data[i]['userID'],
            userName: data[i]['userName'],
            providerName: data[i]['userName'],
            providerId: data[i]['userID'],
            brand: data[i]['brandName'],
            desc_AR:data[i]['desc_AR'],
            desc_EN:data[i]['desc_EN'],
          ));
        }
        print(' products count :: ${latestProducts.length}');
      } else if (cat == 'recommended') {
        recommendedProducts.value = [];
        for (int i = 0; i < data.length; i++) {
          recommendedProducts.add(ProductModel(
            id: data[i]['id'],
            en_name: data[i]['name_EN'],
            ar_name: data[i]['name_AR'],
            price: double.parse(data[i]['price'].toString()),
            offer: data[i]['offer'],
            imageUrl: data[i]['image'],
            catId: data[i]['catID'],
            categoryNameEN: data[i]['categoryName_EN'],
            categoryNameAR: data[i]['categoryName_AR'],
            modelName: data[i]['modelName'],
            modelId: data[i]['modelID'],
            userId: data[i]['userID'],
            userName: data[i]['userName'],
            providerName: data[i]['userName'],
            providerId: data[i]['userID'],
            brand: data[i]['brandName'],
            desc_AR:data[i]['desc_AR'],
            desc_EN:data[i]['desc_EN'],
          ));
        }
        update();
        print(' products count :: ${recommendedProducts.length}');
      } else if (cat == 'offers') {
        offersProducts.value = [];
        for (int i = 0; i < data.length; i++) {
          offersProducts.add(ProductModel(
            id: data[i]['id'],
            en_name: data[i]['name_EN'],
            ar_name: data[i]['name_AR'],
            price: double.parse(data[i]['price'].toString()),
            offer: data[i]['offer'],
            imageUrl: data[i]['image'],
            catId: data[i]['catID'],
            categoryNameEN: data[i]['categoryName_EN'],
            categoryNameAR: data[i]['categoryName_AR'],
            modelName: data[i]['modelName'],
            modelId: data[i]['modelID'],
            userId: data[i]['userID'],
            userName: data[i]['userName'],
            providerName: data[i]['userName'],
            providerId: data[i]['userID'],
            brand: data[i]['brandName'],
            desc_AR:data[i]['desc_AR'],
            desc_EN:data[i]['desc_EN'],
          ));
        }
        print(' products count :: ${offersProducts.length}');
      }
      gotProductsByCat.value =true;
      update();
    } else {
      print(response.reasonPhrase);
    }
    update();
  }

  //
  void findProduct(String productName) async {
    productPredictionList.clear();

    if (productName.length > 1) {

      var headers = {
        'Authorization': 'Bearer ${user.accessToken}',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('https://dashcommerce.click68.com/api/SearchProduct'));
      request.body = json.encode({
        "PageSize": 100,
        "PageNumber": 1,
        "KeyWord": productName
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var json = jsonDecode(await response.stream.bytesToString());
        var data = json['description'];
        print("search list length == ${data.length}");
        var predictions = data;
        var placesList = (predictions as List)
            .map((e) => ProductPredictions.fromJson(e))
            .toList();

        //placePredictionList = placesList;
        placesList.forEach((element) {
          productPredictionList.add(ProductModel(
              id: element.id,
              ar_name: element.ar_name,
              en_name: element.en_name,
              brand: element.brand,
              imageUrl: element.imageUrl,
              price: element.price));
        });
        update();

      }
      else {
        print(response.reasonPhrase);
      }



    }
  }

  Future getOneProductDetails(String id) async {
   gotProductDetails.value =false;
   getDetailsDone.value = false;

   print('get prod id :: $id');
    var headers = {
      'Authorization': 'bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$baseURL/api/GetProduct'));
    request.body = json.encode({'id': id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      imagesData.value = [];
      imagesWidget.value = [];

      update();
      sizes = [];
      var json = jsonDecode(await response.stream.bytesToString());
      print("product details :: \n $json");
      productData = json['description'];
      print('full product $productData');
      product.value = ProductModel(
        id: productData['id'],
        en_name: productData['name_EN'],
        ar_name: productData['name_AR'],
        price: double.parse(productData['price'].toString()),
        offer: productData['offer'],
        imageUrl: productData['primaryImage'],
        catId: productData['catID'],
        categoryNameEN: productData['categoryName_EN'],
        categoryNameAR: productData['categoryName_AR'],
        modelName: productData['modelName'],
        modelId: productData['modelID'],
        userId: productData['userID'],
        userName: productData['userName'],
        general: productData['general'],
        special: productData['spical'],
        providerName: productData['merchentName'],
        providerId: productData['merchentID'],
        colorsData: productData['image'],
        brand: productData['brandName'],
        desc_AR:productData['desc_AR'],
        desc_EN:productData['desc_EN'],
      );
      productDetails = ProductModel(
        id: productData['id'],
        en_name: productData['name_EN'],
        ar_name: productData['name_AR'],
        price: double.parse(productData['price'].toString()),
        offer: productData['offer'],
        imageUrl: productData['primaryImage'],
        catId: productData['catID'],
        categoryNameEN: productData['categoryName'],
        //categoryNameAR: productData['categoryName_AR'],
        modelName: productData['modelName'],
        modelId: productData['modelID'],
        userId: productData['userID'],
        userName: productData['userName'],
        general: productData['general'],
        special: productData['spical'],
        providerName: productData['merchentName'],
        providerId: productData['merchentID'],
        colorsData: productData['image'],
        brand: productData['brandName'],
        desc_AR:productData['desc_AR'],
        desc_EN:productData['desc_EN'],

      );

      sizes = productData['size'];
      currentSizeSelected.value = sizes[0]['size'];
      currentSizeIdSelected.value= sizes[0]['sizeID'];

      colors = productData['size'][0]['color'];


      print('colors productData ${productDetails.colorsData}');
      await addImagesData();
      createImages(2);
      print(product);

    }
    offerFromPrice.value = productDetails.price! * productDetails.offer! / 100;
  }

  createImages(int indexX) {
    imagesWidget.value = [[], [], [], []];
    final screenSize = Get.size;

    for (int index = 0; index < imagesData.length; index++) {
      for (int i = 0; i < imagesData[index].imagesUrls!.length; i++) {
        if (imagesData[index].imagesUrls![i] != null) {
          print('the index is $i');
          imagesWidget[index].add(
            ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Hero(
                  tag: "${productDetails.id!} details",
                  child: CachedNetworkImage(
                    //cacheManager: customCacheManager,
                    key: UniqueKey(),
                    imageUrl: '$baseURL/${imagesData[index].imagesUrls![i]}',
                    height: screenSize.height * 0.2 + 20,
                    width: screenSize.width * 0.4,
                    maxHeightDiskCache: 110,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                         Center(child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor: Colors.grey[300]!,
                            child: Container(
                              height: screenSize.height * 0.2 + 20,
                              width: screenSize.width * 0.4,
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(3)),
                              //child: Image.asset('assets/images/no-image.jpeg'),
                            ),
                          ),
                        )),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.black,
                      child: const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                )),
          );
        }
      }
      getDetailsDone.value = true;
    }
    imagesWidget2 = imagesWidget.value;
    gotProductDetails.value =true;
    getDetailsDone.value = true;
    print('got product == $gotProductDetails');
    update();
  }

  addColorsData() {
    for (int i = 0; i < productDetails.colorsData!.length; i++) {
      colorsData.add(ProductColorsData(
          imagesUrls: productDetails.colorsData![i]['image'],
          color: productDetails.colorsData![i]['property']));
    }
    update();
  }

  addImagesData() {
    for (int i = 0; i < productDetails.colorsData!.length; i++) {
      List<String> urls = [];
      if (productDetails.colorsData![i]['image1'] != null)
        urls.add(
          productDetails.colorsData![i]['image1'],
        );
      if (productDetails.colorsData![i]['image2'] != null)
        urls.add(
          productDetails.colorsData![i]['image2'],
        );
      if (productDetails.colorsData![i]['image3'] != null)
        urls.add(
          productDetails.colorsData![i]['image3'],
        );
      if (productDetails.colorsData![i]['image4'] != null)
        urls.add(
          productDetails.colorsData![i]['image4'],
        );

      imagesData.add(ProductImagesData(
          imagesUrls: urls,
          color: productDetails.colorsData![i]['color'],
          colorId: productDetails.colorsData![i]['colorID']));

      print("$i ${productDetails.colorsData![i]['image1']}");
      print("$i ${productDetails.colorsData![i]['image2']}");
      print("$i ${productDetails.colorsData![i]['image3']}");
      print("$i ${productDetails.colorsData![i]['image4']}");
      //print(imagesData[i].imagesUrls);
    }
    currentColorSelected.value =imagesData[0].color;
    currentColorIdSelected.value =imagesData[0].colorId;
    update();
  }

  Future<bool> addProductToFav(String prodId) async {
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://dashcommerce.click68.com/api/AddFavourite'));
    request.body = json.encode({"ProdID": prodId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future getMyFav() async {
    favProducts.value = [];
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('https://dashcommerce.click68.com/api/ListFavourite'));
    request.body = json.encode({"PageNumber": "0", "SizeNumber": "1"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var json = jsonDecode(await response.stream.bytesToString());
      print("my fav products $json");

      var data = json['description'];
      if (json['status'] == true) {
        favProducts.value = data;
        update();
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future deleteProdFromFav(String prodId) async {
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('https://dashcommerce.click68.com/api/DeleteFavourite'));
    request.body = json.encode({"id": prodId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      getMyFav();
    } else {
      print(response.reasonPhrase);
    }
  }

  resetAll() {
    productDetails = ProductModel();
    sizes = [];
    imagesData.value = [];
    product.value = ProductModel();
    imagesWidget.value = [];
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
