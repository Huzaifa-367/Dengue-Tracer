import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String email;

  OTPScreen({required this.email});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  void _submitOTP() {
    // validate OTP
    if (_otpController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid OTP.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // call API to verify OTP and reset password
    setState(() {
      _isLoading = true;
    });
    verifyOTP(_otpController.text)
        .then((response) {
      setState(() {
        _isLoading = false;
      });
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password reset successful.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('OTP verification failed.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    })
        .catchError((error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Please enter the OTP sent to ${widget.email}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  selectedColor: Theme.of(context).accentColor,
                  inactiveColor: Colors.grey,
                  activeColor: Theme.of(context).accentColor,
                  disabledColor: Colors.grey,
                  borderWidth: 2,
                ),
                animationDuration: Duration(milliseconds: 300),
                controller: _otpController,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onCompleted: (value) {
                  // submit OTP when all fields are filled
                  _submitOTP();
                },
                onChanged: (value) {
                  // clear error message when OTP is changed
                  setState(() {
                    var _error = null;
                  });
                },
                beforeTextPaste: (text) {
                  // prevent user from pasting text into OTP field
                  return false;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitOTP,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  verifyOTP(String text) {}
}

