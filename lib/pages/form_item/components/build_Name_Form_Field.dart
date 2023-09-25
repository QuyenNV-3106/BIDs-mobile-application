import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';

class InputNameItem extends StatefulWidget {
  const InputNameItem({super.key});
  static TextEditingController nameEditingController = TextEditingController();

  @override
  State<InputNameItem> createState() => _InputNameState();
}

class _InputNameState extends State<InputNameItem> {
  @override
  void initState() {
    super.initState();
    InputNameItem.nameEditingController = TextEditingController();
    setState(() {
      // String name = UserProfile.user!.userName!;
      // InputNameItem.nameEditingController.text = name;
    });
  }

  @override
  void dispose() {
    InputNameItem.nameEditingController.dispose();
    super.dispose();
  }

  List<String> errors = [];
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      autofocus: true,
      controller: InputNameItem.nameEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(nameItemlNullError)
                ? errors.add(nameItemlNullError)
                : errors.remove(nameItemlNullError);
          });
          return nameItemlNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Tên sản phẩm",
          hintText: "Nhập tên sản phẩm của bạn",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.person_outline)),
    );
  }
}
