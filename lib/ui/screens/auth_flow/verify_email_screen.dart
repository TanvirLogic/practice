import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practice/ui/screens/auth_flow/verify_pin_screen.dart';
import 'package:practice/ui/widgets/centered_progress_indicator.dart';
import 'package:practice/ui/widgets/screen_background.dart';

import '../../../data/services/api_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/snack_bar_message.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();

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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Your Email Address',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 6),
                Text(
                  'A 6 digit pin will be sent to your email address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'Enter your email'),
                  validator: (String? value) {
                    String inputText = value ?? '';
                    if (EmailValidator.validate(inputText) == false) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ), // Already set in materialApp
                const SizedBox(height: 8),
                Visibility(
                  visible: _inProgress == false,
                  replacement: CenteredProgressIndicator(),
                  child: FilledButton(
                    onPressed: _onTapVerifyEmailButton,
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

  _onTapVerifyEmailButton() {
    if (_formKey.currentState!.validate()) {
      _verifyEmail();
    }
  }

  Future<void> _verifyEmail() async {
    // API call means always future void type
    _inProgress = true;
    setState(() {});

    String inputEmail = _emailTEController.text.trim();
    // String url = Urls.verifyEmail + inputEmail; // <-- Old incorrect line

    // **New Corrected Line:** Append email as a query parameter
    String url = Urls.verifyEmail + inputEmail;

    final ApiResponse response = await ApiCaller.getRequest(url: url);

    if (response.isSuccess && response.responseData['status'] == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VerifyPinScreen(recoverEmail: _emailTEController.text.trim()),
        ),
      );
    } else {
      //_inProgress = false;
      //setState(() {});
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  void _onTapLogInButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
  }
}
