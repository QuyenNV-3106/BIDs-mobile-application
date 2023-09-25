import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';

class InputDescriptionItem extends StatefulWidget {
  const InputDescriptionItem({super.key});
  static TextEditingController descriptionEditingController =
      TextEditingController();

  @override
  State<InputDescriptionItem> createState() => _InputNameState();
}

class _InputNameState extends State<InputDescriptionItem> {
  @override
  void initState() {
    super.initState();
    InputDescriptionItem.descriptionEditingController = TextEditingController();
    setState(() {
      // String name = UserProfile.user!.userName!;
      // InputDescriptionItem.descriptionEditingController.text = name;
    });
  }

  @override
  void dispose() {
    InputDescriptionItem.descriptionEditingController.dispose();
    super.dispose();
  }

  List<String> errors = [];
  // final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: InputDescriptionItem.descriptionEditingController,
      maxLines: null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(descriptionlNullError)
                ? errors.add(descriptionlNullError)
                : errors.remove(descriptionlNullError);
          });
          return descriptionlNullError;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Chi tiết",
          hintText: "Nhập chi tiết",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.note_add_outlined)),
    );
  }
}
