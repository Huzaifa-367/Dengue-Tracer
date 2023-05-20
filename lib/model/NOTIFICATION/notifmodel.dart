class LocItemLists {
  int? status;
  bool? type;

  String? date;
  LocItemLists({
    required this.status,
    required this.date,
    this.type,
  });
}

class ItemLists {
  int? status;
  int? user_id;
  int? sec_id;
  String? sec_name;
  int? percnt;
  bool? type;

  String? date;
  ItemLists({
    required this.status,
    this.user_id,
    this.sec_id,
    this.sec_name,
    required this.date,
    this.type,
    this.percnt,
  });
}
  
// List<ItemLists> notifitems = [
//   ItemLists(
//     title: 'Cases are at peek',
//     description: 'Davido',
//     alert: true,
//     datetime: DateTime(2017, 9, 7),
//   ),
//   ItemLists(
//     title: 'New case in your area',
//     description: 'Brighter Press',
//     alert: false,
//     datetime: DateTime(2017, 8, 7, 17, 30),
//   ),
//   ItemLists(
//     title: 'New case in your area',
//     description: 'Simi-Sola',
//     alert: false,
//     datetime: DateTime(2017, 8, 7, 17, 30),
//   ),
//   ItemLists(
//     title: 'New case in your area',
//     description: 'Black Camaru',
//     alert: false,
//     datetime: DateTime(2017, 8, 8, 17, 30),
//   ),
//   ItemLists(
//     title: 'New case in your area',
//     description: 'ShofeniWere',
//     alert: false,
//     datetime: DateTime(2017, 7, 7, 17, 30),
//   ),
//   ItemLists(
//     title: 'Cases are at peek',
//     description: 'Davido',
//     alert: true,
//     datetime: DateTime(2017, 7, 6, 17, 30),
//   ),
//   ItemLists(
//     title: 'New case in your area',
//     description: 'Brighter Press',
//     alert: false,
//     datetime: DateTime(2017, 9, 7, 17, 30),
//   ),
//   ItemLists(
//     title: 'New case in your area',
//     description: 'Simi-Sola',
//     alert: false,
//     datetime: DateTime(2017, 9, 7, 17, 30),
//   ),
//   ItemLists(
//     title: 'New case in your area',
//     description: 'Black Camaru',
//     alert: false,
//     datetime: DateTime(2017, 9, 7, 17, 30),
//   ),
//   ItemLists(
//     title: 'New case in your area',
//     description: 'ShofeniWere',
//     alert: false,
//     datetime: DateTime(2017, 9, 7, 17, 30),
//   ),
//   ItemLists(
//     title: 'New case in your area',
//     description: 'Davido',
//     alert: false,
//     datetime: DateTime(2017, 9, 7, 17, 30),
//   ),
//   ItemLists(
//     title: 'Cases are at peek',
//     description: 'Brighter Press',
//     alert: true,
//     datetime: DateTime(2017, 9, 7, 17, 30),
//   ),
//   ItemLists(
//     title: 'New case in your area',
//     description: 'Simi-Sola',
//     alert: false,
//     datetime: DateTime(2017, 9, 7, 17, 30),
//   ),
//   ItemLists(
//     title: 'Cases are at peek',
//     description: 'Time to take action',
//     alert: true,
//     datetime: DateTime(2017, 9, 7, 17, 30),
//   ),
//   ItemLists(
//     title: 'New case in your area',
//     description: 'ShofeniWere',
//     alert: false,
//     datetime: DateTime(2017, 9, 7, 17, 30),
//   ),
// ];
