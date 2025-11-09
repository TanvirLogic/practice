import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:practice/ui/widgets/screen_background.dart';

import 'login_screen.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _firstPassController = TextEditingController();
  final TextEditingController _secondPassController = TextEditingController();

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
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _secondPassController,
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                ), // Already set in materialApp
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _onTapSetPassButton,
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

  _onTapSetPassButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (predicate) => false,
    );
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
