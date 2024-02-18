import 'dart:convert';

import 'package:videotron_rental/models/category_model.dart';
import 'package:videotron_rental/models/videotron_model.dart';
import 'package:http/http.dart' as http;

class VideotronService {
  String baseUrl = 'https://karindo.jasproweb.com/api';
  Future<List<VideotronModel>> getVideotron() async {
    var url = '$baseUrl/videotron';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      List<VideotronModel> videotron = [];

      for (var item in data) {
        videotron.add(VideotronModel.fromJson(item));
      }
      print(videotron);
      return videotron;
    } else {
      throw Exception('Gagal Get Videotron!');
    }
  }

  Future<List<CategoryModel>> getCategory() async {
    var url = '$baseUrl/category';
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      List<CategoryModel> category = [];

      for (var item in data) {
        category.add(CategoryModel.fromJson(item));
      }
      return category;
    } else {
      throw Exception('Gagal Get Category!');
    }
  }
}
