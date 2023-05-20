import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/model/NOTIFICATION/notifmodel.dart';
import 'package:dio/dio.dart';

fetchNotifications(int userId, int radius) async {
  try {
    Response response = await Dio().get(
      '$api/showallnotifications2?user_id=$userId&radius=$radius',
    );
    if (response.statusCode == 200) {
      notifitems!.clear();
      if (loggedInUser!.role == "user") {
        for (var item in response.data['locationBased']) {
          ItemLists newItem = ItemLists(
            type: item["type"],
            status: item["status"],
            //user_id: item["user_id"],
            //sec_id: item["sec_id"],
            // percnt: item["percnt"],
            date: item['date'].toString().split('T')[0],
          );
          notifitems!.add(newItem);
        }
      }
      for (var item in response.data['sectorBased']) {
        ItemLists newItem = ItemLists(
          type: item["type"],
          status: item["status"],
          user_id: item["user_id"],
          sec_id: item["sec_id"],
          sec_name: item["sec_name"],
          percnt: item["percnt"],
          date: item['date'].toString().split('T')[0],
        );
        notifitems!.add(newItem);
      }
      locationBasedCount = response.data['locationBasedCount'];
      sectorBasedCount = response.data['sectorBasedCount'];
      if (loggedInUser!.role == "user") {
        totalnotif = locationBasedCount! + sectorBasedCount!;
      }
    } else {
      // Handle API error
      throw Exception('Failed to fetch notifications');
    }
  } catch (e) {
    // Handle Dio errors
    throw Exception('An error occurred: $e');
  }
}
