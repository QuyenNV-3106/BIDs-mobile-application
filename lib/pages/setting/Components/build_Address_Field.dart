import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:flutter/material.dart';

class InputAddress extends StatefulWidget {
  const InputAddress({super.key});
  static TextEditingController addressEditingController =
      TextEditingController();
  @override
  State<InputAddress> createState() => _InputAddressState();
}

class _InputAddressState extends State<InputAddress> {
  @override
  void initState() {
    super.initState();
    InputAddress.addressEditingController = TextEditingController();
    InputAddress.addressEditingController.text = UserProfile.user!.address!;
  }

  @override
  void dispose() {
    InputAddress.addressEditingController.dispose();
    super.dispose();
  }

  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: InputAddress.addressEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(addressNullError)
                ? errors.add(addressNullError)
                : errors.remove(addressNullError);
          });
          return addressNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Địa chỉ",
          hintText: "Nhập địa chỉ của bạn",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.home_outlined)),
    );
  }
}
