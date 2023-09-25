import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputMinuteItem extends StatefulWidget {
  const InputMinuteItem({super.key});
  static TextEditingController minuteEditingController =
      TextEditingController();

  @override
  State<InputMinuteItem> createState() => _InputNameState();
}

class _InputNameState extends State<InputMinuteItem> {
  @override
  void initState() {
    super.initState();
    InputMinuteItem.minuteEditingController = TextEditingController();
    setState(() {
      // String name = UserProfile.user!.userName!;
      // InputMinuteItem.minuteEditingController.text = name;
    });
  }

  @override
  void dispose() {
    InputMinuteItem.minuteEditingController.dispose();
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
      controller: InputMinuteItem.minuteEditingController,
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
          labelText: "Thời gian đấu giá (phút)",
          hintText: "Nhập thời gian đấu giá (phút)",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_clock_outlined)),
    );
  }
}
