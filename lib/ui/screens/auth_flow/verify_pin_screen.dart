import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:practice/ui/screens/auth_flow/login_screen.dart';
import 'package:practice/ui/screens/auth_flow/set_password_screen.dart';
import 'package:practice/ui/widgets/centered_progress_indicator.dart';

import 'package:practice/ui/widgets/screen_background.dart';

import '../../../data/services/api_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/snack_bar_message.dart';

class VerifyPinScreen extends StatefulWidget {
  const VerifyPinScreen({super.key, required this.recoverEmail});

  final String recoverEmail;

  @override
  State<VerifyPinScreen> createState() => _VerifyPinScreenState();
}

class _VerifyPinScreenState extends State<VerifyPinScreen> {
  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Enter Your OTP',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 6),
                Text(
                  'A 6 digit pin has been sent to your email address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  controller: _pinController,
                  appContext: context,
                ),
                // Already set in materialApp
                const SizedBox(height: 8),
                Visibility(
                  visible: _inProgress == false,
                  replacement: CenteredProgressIndicator(),
                  child: FilledButton(
                    onPressed: _onTapPinScreenButton,
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ),
                // Text buttons
                const SizedBox(height: 36),
                Center(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Already have any account?  ",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Log In',
                              style: TextStyle(color: Colors.green),
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    _onTapLogInButton, // Useful property in TextSpan
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onTapPinScreenButton() {
    if (_formKey.currentState!.validate()) {
      _verifyPass();
    }
  }

  Future<void> _verifyPass() async {
    // API call means always future void type
    _inProgress = true;
    setState(() {});

    String otpReceived = _pinController.text.trim();
    // String url = Urls.verifyEmail + inputEmail; // <-- Old incorrect line

    // **New Corrected Line:** Append email as a query parameter
    String otpSendUrl =
        Urls.verifyPass + widget.recoverEmail + '/' + otpReceived;

    final ApiResponse response = await ApiCaller.getRequest(url: otpSendUrl);

    if (response.isSuccess && response.responseData['status'] == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetPasswordScreen(
            recoverEmail: widget.recoverEmail,
            recoveredOTP: otpReceived,
          ),
        ),
      );
    } else {
      _inProgress = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  void _onTapLogInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (predicate) => false,
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }
}
