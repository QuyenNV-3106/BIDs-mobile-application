import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputQualityItem extends StatefulWidget {
  const InputQualityItem({super.key});
  static TextEditingController qualityEditingController =
      TextEditingController();

  @override
  State<InputQualityItem> createState() => _InputNameState();
}

class _InputNameState extends State<InputQualityItem> {
  @override
  void initState() {
    super.initState();
    InputQualityItem.qualityEditingController = TextEditingController();
    setState(() {
      // String name = UserProfile.user!.userName!;
      // InputQualityItem.qualityEditingController.text = name;
    });
  }

  @override
  void dispose() {
    InputQualityItem.qualityEditingController.dispose();
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
      controller: InputQualityItem.qualityEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(qualitylNullError)
                ? errors.add(qualitylNullError)
                : errors.remove(qualitylNullError);
          });
          return qualitylNullError;
        }
        if (int.parse(value) == 0) {
          setState(() {
            !errors.contains(qualityError)
                ? errors.add(qualityError)
                : errors.remove(qualityError);
          });
          return qualityError;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Số lượng",
          hintText: "Nhập số lượng",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.production_quantity_limits)),
    );
  }
}
