import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/model/NOTIFICATION/notifmodel.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

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
            sec_id: item["sec_id"],
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

      // Schedule the notifications
      scheduleNotifications(notifitems!);
    } else {
      // Handle API error
      throw Exception('Failed to fetch notifications');
    }
  } catch (e) {
    // Handle Dio errors
    throw Exception('An error occurred: $e');
  }
}

void scheduleNotifications(List<ItemLists> notifitems) async {
  for (var item in notifitems) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: item.sec_id!,
        channelKey: 'basic_channel',
        summary: 'Alert!',
        title: "${item.sec_name}",
        criticalAlert: true,
        body: "Dengue reached ${item.percnt}",
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture:
            'https://www.nea.gov.sg/images/default-source/dengue-zika/denguecampaign-wpfb-v2.jpg',
      ),
    );

    // Schedule the notification
    // await AwesomeNotifications().createNotification(content: content);
  }
}

// Generate a unique id based on item properties
int generateNotificationId(ItemLists item) {
  // Concatenate the item properties to create a unique string
  String uniqueString = '${item.user_id}_${item.type}';

  // Generate the MD5 hash of the unique string
  var bytes = utf8.encode(uniqueString);
  var digest = md5.convert(bytes);

  // Convert the MD5 hash to an integer
  int notificationId = int.parse(digest.toString(), radix: 16);

  return notificationId;
}
