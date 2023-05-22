import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constant.dart';

Widget ShimmerListView(int length) {
  return SizedBox(
    height: 280,
    width: 550,
    child: Shimmer.fromColors(
      baseColor: bkColor,
      highlightColor: Colors.grey[100]!,
      period: const Duration(seconds: 2),
      child: ListView.builder(
        itemCount: length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 5.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: 19.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 19.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 19.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 19.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 19.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  height: 19.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                const SizedBox(
                  width: 5.0,
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

Widget ShimmerNotificationView(int length) {
  return ListView.builder(
    itemCount: length,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: bkColor,
        highlightColor: Colors.grey[100]!,
        period: const Duration(seconds: 3),
        child: Column(
          children: [
            ListTile(
              title: Container(
                  height: 20,
                  width: 10,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10))),
              subtitle: Container(
                  margin: const EdgeInsets.only(right: 50),
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10))),
              leading: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: 50,
                width: 50,
              ),
            ),
          ],
        ),
      );
    },
  );
}
