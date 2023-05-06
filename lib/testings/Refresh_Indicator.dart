import 'dart:math';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';

class Refresh extends StatefulWidget {
  const Refresh({super.key});

  @override
  _RefreshState createState() => _RefreshState();
}

class _RefreshState extends State<Refresh> {
  int _randomNumber = 0;

  Future<void> _refreshScreen() async {
    await Future.delayed(
        const Duration(seconds: 1)); // Simulating network delay
    setState(() {
      _randomNumber = Random().nextInt(100); // Generate a new random number
    });
  }

  @override
  void initState() {
    super.initState();
    _randomNumber = Random().nextInt(100); // Initialize with a random number
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Screen'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshScreen,
        child: Center(
          child: GestureDetector(
            onVerticalDragDown:
                (_) {}, // Consume the gesture to prevent scrolling
            child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: btnColor,
              ),
              child: Text(
                'Random Number: $_randomNumber',
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
