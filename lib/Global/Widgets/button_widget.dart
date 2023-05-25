import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';

import 'Loading_Animation.dart';

class ButtonWidget extends StatelessWidget {
  final String btnText;
  final VoidCallback onPress;
  bool? isloading = false;

  ButtonWidget({
    Key? key,
    required this.btnText,
    required this.onPress,
    this.isloading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        shadowColor: const Color.fromARGB(255, 237, 137, 144),
        //primary: Theme.of(context).secondaryHeaderColor,
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: isloading == true
          ? const SpinKitWave(
              color: Colors.white,
              type: SpinKitWaveType.start,
            )
          : Text(
              btnText.toUpperCase(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
    );
  }
}
