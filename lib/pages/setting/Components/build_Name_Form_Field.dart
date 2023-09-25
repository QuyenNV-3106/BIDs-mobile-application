import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:flutter/material.dart';

class InputName extends StatefulWidget {
  const InputName({super.key});
  static TextEditingController nameEditingController = TextEditingController();

  @override
  State<InputName> createState() => _InputNameState();
}

class _InputNameState extends State<InputName> {
  @override
  void initState() {
    super.initState();
    InputName.nameEditingController = TextEditingController();
    setState(() {
      String name = UserProfile.user!.userName!;
      InputName.nameEditingController.text = name;
    });
  }

  @override
  void dispose() {
    InputName.nameEditingController.dispose();
    super.dispose();
  }

  List<String> errors = [];
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      autofocus: true,
      controller: InputName.nameEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(namelNullError)
                ? errors.add(namelNullError)
                : errors.remove(namelNullError);
          });
          return namelNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Họ và tên",
          hintText: "Nhập họ và tên của bạn",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.person_outline)),
    );
  }
}
