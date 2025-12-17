import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _codeController = TextEditingController();
  String _phoneNumber = '';
  String _role = 'grocery';
  String _verificationId = '';
  bool _codeSent = false;
  final AuthService _authService = AuthService();

  void _sendCode() async {
    if (_formKey.currentState!.validate()) {
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
          _register();
        },
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message!)));
        },
      );
    }
  }

  void _verifyCode() async {
    try {
      await _authService.signInWithSmsCode(_verificationId, _codeController.text);
      _register();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid code')));
    }
  }

  void _register() async {
    User user = User(
      id: _authService.auth.currentUser!.uid,
      name: _nameController.text,
      phone: _phoneNumber,
      role: _role,
      address: _addressController.text,
    );
    await _authService.registerUser(user);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
              ),
              IntlPhoneField(
                decoration: const InputDecoration(labelText: 'Phone'),
                initialCountryCode: 'YE',
                onChanged: (phone) {
                  _phoneNumber = phone.number;
                },
                validator: (value) {
                  if (value == null || value.number.length != 9) return 'Enter valid 9 digit Yemeni number';
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _role,
                items: ['grocery', 'merchant', 'admin'].map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
                onChanged: (value) => setState(() => _role = value!),
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) => value!.isEmpty ? 'Enter address' : null,
              ),
              if (!_codeSent)
                ElevatedButton(onPressed: _sendCode, child: const Text('Send Code'))
              else
                Column(
                  children: [
                    TextFormField(
                      controller: _codeController,
                      decoration: const InputDecoration(labelText: 'Verification Code'),
                      validator: (value) => value!.isEmpty ? 'Enter code' : null,
                    ),
                    ElevatedButton(onPressed: _verifyCode, child: const Text('Verify')),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}