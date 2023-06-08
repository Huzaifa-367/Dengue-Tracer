import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';

fetchActions(int secId, context) async {
  try {
    Response response = await Dio().get(
      '$api/ShowActionsTaken?sec_id=$secId',
    );
    if (response.statusCode == 200) {
      Actionitems!.clear();

      for (var item in response.data['sectorBased']) {
        ActionLists newItem = ActionLists(
          status: item["status"],
          sec_id: item["sec_id"],
          date: item['date'].toString().split('T')[0],
        );
        Actionitems!.add(newItem);
      }
      // Schedule the notifications
      //scheduleNotifications(notifitems!);
    } else {
      // Handle API error
      snackBar(context, 'Failed to fetch Actions');
     // throw Exception('Failed to fetch Actions');
    }
  } catch (e) {
    // Handle Dio errors
    //throw Exception('An error occurred: $e');
  }
}



class ActionLists {
  int? status;
  int? sec_id;
  String? date;

  ActionLists({
    required this.status,
    this.sec_id,
    required this.date,
  });
}
