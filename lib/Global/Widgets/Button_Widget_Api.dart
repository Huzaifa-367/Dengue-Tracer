import 'package:dengue_tracing_application/Global/Screen_Paths.dart';
import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';

class ButtonApiWidget extends StatefulWidget {
  final String btnText;
  final VoidCallback onPress;
  bool? isloading = false;

  ButtonApiWidget({
    Key? key,
    required this.btnText,
    required this.onPress,
    this.isloading,
  }) : super(key: key);

  @override
  _ButtonApiWidgetState createState() => _ButtonApiWidgetState();
}

class _ButtonApiWidgetState extends State<ButtonApiWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isloading == true ? null : widget.onPress,
      style: ElevatedButton.styleFrom(
        shadowColor: const Color.fromARGB(255, 237, 137, 144),
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: widget.isloading == true
          ? const SpinKitWave(
              size: 20,
              color: Colors.white,
              type: SpinKitWaveType.start,
            )
          : Text(
              widget.btnText.toUpperCase(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
    );
  }
}
