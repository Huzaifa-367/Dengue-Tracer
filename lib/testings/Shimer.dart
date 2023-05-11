import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimerWidget extends StatelessWidget {
  const ShimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var line = Container(
      width: double.infinity,
      height: 12.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    var answer = Container(
      width: double.infinity,
      height: 50.0,
      color: Theme.of(context).scaffoldBackgroundColor,
    );

    return Container(
      height: 30,
      width: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bkColor,
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.4),
        highlightColor: Colors.blueGrey.withOpacity(0.1),
        child: EasySeparatedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 20,
            );
          },
          children: [
            EasySeparatedColumn(
              children: [
                line,
              ],
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 2,
                );
              },
            ),
            answer,
          ],
        ),
      ),
    );
  }
}
