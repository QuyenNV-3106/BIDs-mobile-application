import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';

class InputEmail extends StatefulWidget {
  const InputEmail({super.key});
  static TextEditingController emailEditingController = TextEditingController();
  @override
  State<InputEmail> createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  List<String> errors = [];

  @override
  void initState() {
    super.initState();
    InputEmail.emailEditingController = TextEditingController();
  }

  @override
  void dispose() {
    InputEmail.emailEditingController.dispose();
    super.dispose();
  }

  // String? email;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: InputEmail.emailEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) {
        setState(() {
          // EmailInput.textEditingController.text = newValue!;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(emailNullError)
                ? errors.add(emailNullError)
                : errors.remove(emailNullError);
          });
          return emailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value) && value.isNotEmpty) {
          setState(() {
            !errors.contains(invalidEmailError)
                ? errors.add(invalidEmailError)
                : errors.remove(invalidEmailError);
          });
          return invalidEmailError;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Email",
          hintText: "Nhập email của bạn",
          suffixIcon: Icon(Icons.mail_outline_outlined)),
    );
  }
}
