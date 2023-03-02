import 'dart:async';

import 'package:app_feedback/app_feedback.dart';
import 'package:flutter/material.dart';

class FeedBack_Screen extends StatefulWidget {
  const FeedBack_Screen({super.key});

  @override
  State<FeedBack_Screen> createState() => _FeedBack_ScreenState();
}

class _FeedBack_ScreenState extends State<FeedBack_Screen> {
  AppFeedback feedbackForm = AppFeedback.instance;

  UserFeedback? feedback;
  @override
  void initState() {
    feedbackForm.init(
      FeedbackConfig(
        duration: const Duration(seconds: 10),
        displayLogs: true,
      ),
    );
    super.initState();
  }

  Widget get rating {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: !feedbackAvailable
          ? [const SizedBox()]
          : [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      "Rating:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${feedback!.rating}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              if (feedback!.review!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Review:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          "${feedback!.review}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                )
            ],
    );
  }

  void launchAppFeedback() {
    feedbackForm.display(context,
        option: Option(
          maxRating: 10,
          ratingButtonTheme: RatingButtonThemeData.outlinedBorder(),
        ), onSubmit: (feedback) {
      this.feedback = feedback;
      setState(() {});
    });
  }

  void tryDisplay() {
    feedbackForm.tryDisplay(context, onSubmit: (UserFeedback feedback) {
      this.feedback = feedback;
      setState(() {});
    });
  }

  /// Clear saved user's feedback from cache
  void clearConfig() async {
    await feedbackForm.clearConfig();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form reset successfully!!")));
    feedback = null;

    /// Initilise the feedback form form after reseting
    feedbackForm.init(FeedbackConfig(
        duration: const Duration(seconds: 10), displayLogs: true));

    setState(() {});
  }

  void getAppSavedFeedback() async {
    final feed = await (feedbackForm.savedFeedback as FutureOr<UserFeedback>);
    if (feed.rating != null) {
      feedback = feed;
    }
  }

  bool get feedbackAvailable => feedback != null && feedback!.rating != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback Form Demo"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              rating,
              const SizedBox(height: 20),
              MaterialButton(
                colorBrightness: Brightness.light,
                onPressed: launchAppFeedback,
                textColor: Colors.white,
                color: Colors.blue[400],
                elevation: 0,
                child: const Text("Display Form"),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                colorBrightness: Brightness.light,
                onPressed: tryDisplay,
                textColor: Colors.white,
                color: Colors.blue[400],
                elevation: 0,
                child: const Text("Try Display Form"),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                colorBrightness: Brightness.light,
                onPressed: clearConfig,
                textColor: Colors.white,
                color: Colors.blue[400],
                elevation: 0,
                child: const Text("Reset Form"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
