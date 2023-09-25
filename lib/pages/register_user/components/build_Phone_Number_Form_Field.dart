import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';

class InputPhoneNumber extends StatefulWidget {
  const InputPhoneNumber({super.key});
  static TextEditingController phoneEditingController = TextEditingController();

  @override
  State<InputPhoneNumber> createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber> {
  @override
  void initState() {
    super.initState();
    InputPhoneNumber.phoneEditingController = TextEditingController();
  }

  @override
  void dispose() {
    InputPhoneNumber.phoneEditingController.dispose();
    super.dispose();
  }

  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: InputPhoneNumber.phoneEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(phoneNumberNullError)
                ? errors.add(phoneNumberNullError)
                : errors.remove(phoneNumberNullError);
          });
          return phoneNumberNullError;
        } else if (!phoneValidationRegExp.hasMatch(value) && value.isNotEmpty) {
          setState(() {
            !errors.contains(invalidPhoneError)
                ? errors.add(invalidPhoneError)
                : errors.remove(invalidPhoneError);
          });
          return invalidPhoneError;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Số điện thoại",
          hintText: "Nhập số điện thoại của bạn",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.phone_android_outlined)),
    );
  }
}
