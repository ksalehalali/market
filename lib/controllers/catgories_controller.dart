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
      'Authorization':
          'bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOYW1lIjoiU3VwZXJBZG1pbiIsIlJvbGUiOiJzdXBlckFkbWluIiwiZXhwIjoxNjUyNzI0MjMyLCJpc3MiOiJJbnZlbnRvcnlBdXRoZW50aWNhdGlvblNlcnZlciIsImF1ZCI6IkludmVudG9yeVNlcnZpY2VQb3RtYW5DbGllbnQifQ.yMyY9DYPHcjiwcRBUt5HKDumstyC-6YjhvxTGMq-haE',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('GET', Uri.parse('$baseURL/api/ListCategoryByCategory'));
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
      print(response.reasonPhrase);
    }

    update();
  }
}
