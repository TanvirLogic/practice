import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practice/ui/widgets/centered_progress_indicator.dart';
import 'package:practice/ui/widgets/screen_background.dart';

import '../../../data/services/api_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/snack_bar_message.dart';
import 'login_screen.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({
    super.key,
    required this.recoverEmail,
    required this.recoveredOTP,
  });

  final String recoverEmail;
  final String recoveredOTP;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _firstPassController = TextEditingController();
  final TextEditingController _secondPassController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginInProgress = false;

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
                  'Set Your Password',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 6),
                Text(
                  'Password Length must be more than 6 digits',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _firstPassController,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (String? value) {
                    if ((value?.length ?? 0) <= 6) {
                      return 'Enter a password more than 6 letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _secondPassController,
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                  validator: (String? value) {
                    if ((value?.length ?? 0) <= 6) {
                      return 'Enter a password more than 6 letters';
                    }
                    return null;
                  },
                ), // Already set in materialApp
                const SizedBox(height: 8),
                Visibility(
                  visible: _loginInProgress == false,
                  replacement: CenteredProgressIndicator(),
                  child: FilledButton(
                    onPressed: _onTapSetPassButton,
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

  _onTapSetPassButton() {
    if (_formKey.currentState!.validate()) {
      // If valid form then
      _login();
    }
  }

  Future<void> _login() async {
    // API call means always future void type
    _loginInProgress = true;
    setState(() {});
    // Prepare body to request for login
    Map<String, dynamic> requestBody = {
      "email": widget.recoverEmail,
      "OTP": widget.recoveredOTP,
      "password": _firstPassController.text.trim(),
    };
    // Get the response after post request and check if the response give the isSuccess = true and  response.responseData['status'] == 'success'
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.resetPassUrl,
      body: requestBody,
    );
    if (response.isSuccess && response.responseData['status'] == 'success') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.name,
        (predicate) => false,
      );
    } else {
      _loginInProgress = false;
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
    // TODO: implement dispose
    super.dispose();
    _firstPassController.dispose();
    _secondPassController.dispose();
  }
}
