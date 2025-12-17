import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _codeController = TextEditingController();
  String _phoneNumber = '';
  String _verificationId = '';
  bool _codeSent = false;
  final AuthService _authService = AuthService();

  void _sendCode() async {
    String fullPhone = '+967${_phoneNumber}';
    await _authService.verifyPhoneNumber(
      fullPhone,
      (verificationId) {
        setState(() {
          _verificationId = verificationId;
          _codeSent = true;
        });
      },
      (message) {
        _login();
      },
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message!)));
      },
    );
  }

  void _verifyCode() async {
    try {
      await _authService.signInWithSmsCode(_verificationId, _codeController.text);
      _login();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid code')));
    }
  }

  void _login() async {
    var user = await _authService.getCurrentUser();
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not registered, please register first')));
      Navigator.pushReplacementNamed(context, '/register');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            IntlPhoneField(
              decoration: const InputDecoration(labelText: 'Phone'),
              initialCountryCode: 'YE',
              onChanged: (phone) {
                _phoneNumber = phone.number;
              },
            ),
            if (!_codeSent)
              ElevatedButton(onPressed: _sendCode, child: const Text('Send Code'))
            else
              Column(
                children: [
                  TextFormField(
                    controller: _codeController,
                    decoration: const InputDecoration(labelText: 'Verification Code'),
                  ),
                  ElevatedButton(onPressed: _verifyCode, child: const Text('Verify')),
                ],
              ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/register'),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}