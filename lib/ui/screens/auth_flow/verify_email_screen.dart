import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practice/ui/screens/auth_flow/verify_pin_screen.dart';
import 'package:practice/ui/widgets/screen_background.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  decoration: InputDecoration(hintText: 'Enter your email'),
                ), // Already set in materialApp
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _onTapVerifyEmailButton,
                  child: Icon(Icons.arrow_forward_ios),
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VerifyPinScreen()),
    );
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
