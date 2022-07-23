import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../Assistants/globals.dart';
import '../Data/current_data.dart';
import 'product_controller.dart';

class CategoriesController extends GetxController {
  var departments = [].obs;

  Future getListCategoryByCategory(String catId) async {
    var headers = {
      'Authorization': 'bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('$baseURL/api/ListCategoryByCategory'));
    request.body = json.encode({"id": catId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      departments.value = [];

      var json = jsonDecode(await response.stream.bytesToString());
      var data = json['description'];

      for (int i = 0; i < data.length; i++) {
        departments.add(data[i]);
      }
      update();
      print('cat length :: ${departments.length}');
    } else {
      print('error in category controller ::: ListCategoryByCategory');
      print(response.reasonPhrase);
    }

    update();
  }
}
