import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';

class InputCccd extends StatefulWidget {
  const InputCccd({super.key});
  static TextEditingController cccdEditingController = TextEditingController();
  @override
  State<InputCccd> createState() => _InputCccdState();
}

class _InputCccdState extends State<InputCccd> {
  List<String> errors = [];

  @override
  void initState() {
    super.initState();
    InputCccd.cccdEditingController = TextEditingController();
  }

  @override
  void dispose() {
    InputCccd.cccdEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: InputCccd.cccdEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(cccdNullError)
                ? errors.add(cccdNullError)
                : errors.remove(cccdNullError);
          });
          return cccdNullError;
        } else if (!cccdRegExp.hasMatch(value) && value.isNotEmpty) {
          setState(() {
            !errors.contains(invalidcccdError)
                ? errors.add(invalidcccdError)
                : errors.remove(invalidcccdError);
          });
          return invalidcccdError;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Căn cước công dân",
          hintText: "Nhập số cccd của bạn",
          suffixIcon: Icon(Icons.credit_card_outlined)),
    );
  }
}
