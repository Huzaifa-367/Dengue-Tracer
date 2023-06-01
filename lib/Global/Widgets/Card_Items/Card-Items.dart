import 'package:dengue_tracing_application/Global/Widgets/Card_Items/Custom_Clipper.dart';
import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:flutter/material.dart';

class CardItems extends StatelessWidget {
  final Image? image;
  final String? title;
  final String? value;
  final String? unit;
  final Color? color;
  final int? progress;

  const CardItems({
    Key? key,
    @required this.image,
    @required this.title,
    @required this.value,
    @required this.unit,
    @required this.color,
    @required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: ClipPath(
              clipper: MyCustomClipper(clipType: ClipType.halfCircle),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  color: color!.withOpacity(0.1),
                ),
                height: 100,
                width: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Icon and Hearbeat
                image!,
                const SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            title!,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Constants.textPrimary),
                          ),
                          Text(
                            '$value $unit',
                            style: TextStyle(
                                fontSize: 15, color: Constants.textPrimary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      (progress == 0)
                          ? Text('Not started',
                              style: TextStyle(
                                  fontSize: 15, color: Constants.textPrimary))
                          : Container(
                              height: 6,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                shape: BoxShape.rectangle,
                                color: Color(0xFFD9E2EC),
                              ),
                              child: LayoutBuilder(builder:
                                  (BuildContext context,
                                      BoxConstraints constraints) {
                                return Stack(
                                  children: <Widget>[
                                    Positioned(
                                      left: 0,
                                      child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            shape: BoxShape.rectangle,
                                            color: Color(0xFF50DE89),
                                          ),
                                          width: constraints.maxWidth *
                                              (progress! / 100),
                                          height: 6),
                                    )
                                  ],
                                );
                              }),
                            ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
