import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../Global/constant.dart';
import '../model/NOTIFICATION/notifmodel.dart';

class authController extends ChangeNotifier {
  int count = 0;
  List<ItemLists> notifitems = [];
  notif() async {
    var response = await Dio().get('$ip/ShowallNotifications');
    if (response.statusCode == 200) {
      notifitems.clear();
      for (var item in response.data) {
        ItemLists newItem = ItemLists(
          title: item['title'],
          //description: item['description'],
          alert: item['type'],
          date: item['date'].toString().split('T')[0],
        );
        notifitems.add(newItem);
      }
    }
    notifyListeners();
  }
}
