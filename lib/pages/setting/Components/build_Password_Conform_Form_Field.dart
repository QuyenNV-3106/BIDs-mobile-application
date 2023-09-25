import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/pages/setting/Components/build_Password_Form_Field.dart';
import 'package:flutter/material.dart';

class InpputConformPassword extends StatefulWidget {
  const InpputConformPassword({super.key});
  static TextEditingController conformPasswordEditingController =
      TextEditingController();

  @override
  State<InpputConformPassword> createState() => _InpputConformPasswordState();
}

class _InpputConformPasswordState extends State<InpputConformPassword> {
  @override
  void initState() {
    super.initState();
    InpputConformPassword.conformPasswordEditingController =
        TextEditingController();
    InpputConformPassword.conformPasswordEditingController.text =
        UserProfile.user!.password!;
  }

  @override
  void dispose() {
    InpputConformPassword.conformPasswordEditingController.dispose();
    super.dispose();
  }

  List<String> errors = [];
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(passNullError)
                ? errors.add(passNullError)
                : errors.remove(passNullError);
          });
          return passNullError;
        } else if ((InputPassword.passwordEditingController.text != value)) {
          setState(() {
            !errors.contains(matchPassError)
                ? errors.add(matchPassError)
                : errors.remove(matchPassError);
          });
          return matchPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Xác nhận mật khẩu",
        hintText: "Nhập lại mật khẩu phía trên",
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
      ),
    );
  }
}
