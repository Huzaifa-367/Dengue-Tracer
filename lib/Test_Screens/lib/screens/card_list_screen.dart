import 'package:flutter/material.dart';

import '../../../Global/Widgets_Paths.dart';
import '../../../Global/Widgets/auto_refresh.dart';
import '../widgets/empty_card.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({Key? key}) : super(key: key);

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoRefresh(
      duration: const Duration(milliseconds: 2000),
      child: Scaffold(
        body: SafeArea(
          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 44.0,
                    child: FadeInAnimation(
                      child: EmptyCard(
                        width: MediaQuery.of(context).size.width,
                        height: 88.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
