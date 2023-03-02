// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Counter with ChangeNotifier {
//   int _count = 0;

//   int get count => _count;

//   void increment() {
//     _count++;
//     notifyListeners();
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final counter = Provider.of<Counter>(context);
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '${counter.count}',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: counter.increment,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => Counter()),
//       ],
//       child: MaterialApp(
//         home: MyHomePage(),
//       ),
//     );
//   }
// }
