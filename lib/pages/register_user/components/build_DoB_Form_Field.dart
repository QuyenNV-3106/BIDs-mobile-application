import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDob extends StatefulWidget {
  const InputDob({super.key});

  static TextEditingController dateController = TextEditingController();

  @override
  State<InputDob> createState() => _InputDobState();
}

class _InputDobState extends State<InputDob> {
  @override
  void initState() {
    super.initState();
    InputDob.dateController = TextEditingController();
  }

  @override
  void dispose() {
    InputDob.dateController.dispose();
    super.dispose();
  }

  List<String> errors = [];
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        InputDob.dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: InputDob.dateController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(doblNullError)
                ? errors.add(doblNullError)
                : errors.remove(doblNullError);
          });
          return doblNullError;
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Ngày sinh",
          hintText: "dd-mm-yyyy",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: IconButton(
              onPressed: () {
                _selectDate(context);
              },
              icon: const Icon(Icons.edit_calendar_rounded))),
      readOnly: true,
    );
  }
}
