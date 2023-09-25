import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/pages/form_item/components/build_price_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputStepPriceItem extends StatefulWidget {
  const InputStepPriceItem({super.key});
  static TextEditingController stepPriceEditingController =
      TextEditingController();

  @override
  State<InputStepPriceItem> createState() => _InputNameState();
}

class _InputNameState extends State<InputStepPriceItem> {
  @override
  void initState() {
    super.initState();
    InputStepPriceItem.stepPriceEditingController = TextEditingController();
    setState(() {
      // String name = UserProfile.user!.userName!;
      // InputStepPriceItem.stepPriceEditingController.text = name;
    });
  }

  @override
  void dispose() {
    InputStepPriceItem.stepPriceEditingController.dispose();
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
            RegExp(r'^\d*\.?\d*$')), // Chỉ cho phép số từ 0-9
      ],
      controller: InputStepPriceItem.stepPriceEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(stepPriceNullError)
                ? errors.add(stepPriceNullError)
                : errors.remove(stepPriceNullError);
          });
          return stepPriceNullError;
        }
        double min = 0.05, max = 0.1;
        if (InputPriceItem.priceEditingController.text.isNotEmpty) {
          setState(() {
            min =
                0.05 * double.parse(InputPriceItem.priceEditingController.text);
            max =
                0.1 * double.parse(InputPriceItem.priceEditingController.text);
          });
          print("$min--$max--$value");
          if (double.parse(value) < min || double.parse(value) > max) {
            setState(() {
              !errors.contains(stepPriceError)
                  ? errors.add(stepPriceError)
                  : errors.remove(stepPriceError);
            });
            return stepPriceError;
          }
          return null;
        }
      },
      decoration: const InputDecoration(
          labelText: "Bước giá (5-10% giá ban đầu)",
          hintText: "Nhập bước giá",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.price_check)),
    );
  }
}
