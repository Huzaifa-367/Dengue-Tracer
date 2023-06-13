import 'package:flutter/material.dart';
import 'package:select2dot1/select2dot1.dart';

class DropDownController extends ChangeNotifier {
  List<SingleCategoryModel> item = [];
  bool isgetting = true;
  SingleItemCategoryModel? selectedStudentId;
  SingleItemCategoryModel? isReportedbyId;
  getItems() async {
    try {
      isgetting = true;
      notifyListeners();
    } catch (e) {}
    isgetting = false;
    notifyListeners();
  }
}
