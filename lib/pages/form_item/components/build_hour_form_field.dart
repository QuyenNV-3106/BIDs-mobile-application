import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputHourItem extends StatefulWidget {
  const InputHourItem({super.key});
  static TextEditingController hourEditingController = TextEditingController();

  @override
  State<InputHourItem> createState() => _InputNameState();
}

class _InputNameState extends State<InputHourItem> {
  @override
  void initState() {
    super.initState();
    InputHourItem.hourEditingController = TextEditingController();
    setState(() {
      // String name = UserProfile.user!.userName!;
      // InputHourItem.hourEditingController.text = name;
    });
  }

  @override
  void dispose() {
    InputHourItem.hourEditingController.dispose();
    super.dispose();
  }

  List<String> errors = [];
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
            RegExp(r'[0-9]')), // Chỉ cho phép số từ 0-9
      ],
      controller: InputHourItem.hourEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(timeNullError)
                ? errors.add(timeNullError)
                : errors.remove(timeNullError);
          });
          return timeNullError;
        }
        if (int.parse(value) == 0) {
          setState(() {
            !errors.contains(timeError)
                ? errors.add(timeError)
                : errors.remove(timeError);
          });
          return timeError;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Thời gian đấu giá (giờ)",
          hintText: "Nhập thời gian đấu giá (giờ)",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_clock_outlined)),
    );
  }
}
