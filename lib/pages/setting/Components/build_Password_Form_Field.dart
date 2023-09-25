import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({super.key});
  static TextEditingController passwordEditingController =
      TextEditingController();

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  @override
  void initState() {
    super.initState();
    InputPassword.passwordEditingController = TextEditingController();
    InputPassword.passwordEditingController.text = UserProfile.user!.password!;
  }

  @override
  void dispose() {
    InputPassword.passwordEditingController.dispose();
    super.dispose();
  }

  List<String> errors = [];
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: InputPassword.passwordEditingController,
      obscureText: _isPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(passNullError)
                ? errors.add(passNullError)
                : errors.remove(passNullError);
          });
          return passNullError;
        } else if (value.length < 8 && value.isNotEmpty) {
          setState(() {
            !errors.contains(shortPassError)
                ? errors.add(shortPassError)
                : errors.remove(shortPassError);
          });
          return shortPassError;
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Mật khẩu",
          hintText: "Nhập mật khẩu của bạn",
          suffixIcon: IconButton(
            icon: Icon(_isPasswordVisible
                ? Icons.lock_outline
                : Icons.remove_red_eye_outlined),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always),
    );
  }
}
