import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:flutter/material.dart';

class InputPayPal extends StatefulWidget {
  const InputPayPal({super.key});
  static TextEditingController payPalEditingController =
      TextEditingController();
  @override
  State<InputPayPal> createState() => _InputPayPalState();
}

class _InputPayPalState extends State<InputPayPal> {
  @override
  void initState() {
    super.initState();

    InputPayPal.payPalEditingController = TextEditingController();
    InputPayPal.payPalEditingController.text =
        UserProfile.user!.payPalAccount!.first.payPalAccount!;
  }

  @override
  void dispose() {
    InputPayPal.payPalEditingController.dispose();
    super.dispose();
  }

  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: InputPayPal.payPalEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains("Bạn chưa nhập tài khoản PayPal")
                ? errors.add("Bạn chưa nhập tài khoản PayPal")
                : errors.remove("Bạn chưa nhập tài khoản PayPal");
          });
          return "Bạn chưa nhập tài khoản PayPal";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Tài khoản PayPal",
          hintText: "Nhập tài khoản PayPal của bạn",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.paypal_outlined)),
    );
  }
}
