import 'package:flutter/foundation.dart';
import 'package:videotron_rental/models/category_model.dart';
import 'package:videotron_rental/models/videotron_model.dart';
import 'package:videotron_rental/services/videotron_service.dart';

class VideotronProvider with ChangeNotifier {
  List<VideotronModel> _videotron = [];
  List<CategoryModel> _category = [];

  List<VideotronModel> get videotron => _videotron;
  List<CategoryModel> get category => _category;

  set videotron(List<VideotronModel> videotron) {
    _videotron = videotron;
    notifyListeners();
  }

  set category(List<CategoryModel> category) {
    _category = category;
    notifyListeners();
  }

  Future<void> getVideotron() async {
    try {
      List<VideotronModel> videotron = await VideotronService().getVideotron();
      _videotron = videotron;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCategory() async {
    try {
      List<CategoryModel> category = await VideotronService().getCategory();
      _category = category;
    } catch (e) {
      print(e);
    }
  }
}
