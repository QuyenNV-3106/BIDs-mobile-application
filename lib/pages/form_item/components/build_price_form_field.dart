import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputPriceItem extends StatefulWidget {
  const InputPriceItem({super.key});
  static TextEditingController priceEditingController = TextEditingController();

  @override
  State<InputPriceItem> createState() => _InputNameState();
}

class _InputNameState extends State<InputPriceItem> {
  @override
  void initState() {
    super.initState();
    InputPriceItem.priceEditingController = TextEditingController();
    setState(() {
      // String name = UserProfile.user!.userName!;
      // InputPriceItem.priceEditingController.text = name;
    });
  }

  @override
  void dispose() {
    InputPriceItem.priceEditingController.dispose();
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
      controller: InputPriceItem.priceEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(priceNullError)
                ? errors.add(priceNullError)
                : errors.remove(priceNullError);
          });
          return priceNullError;
        }
        // if (int.parse(value) < 1000000) {
        //   setState(() {
        //     !errors.contains(priceError)
        //         ? errors.add(priceError)
        //         : errors.remove(priceError);
        //   });
        //   return priceError;
        // }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Giá khởi điểm",
          hintText: "Nhập khởi điểm",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.price_change_outlined)),
    );
  }
}
