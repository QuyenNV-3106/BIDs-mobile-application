import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(errors.length,
          (index) => formErrorText(context, error: errors[index])),
    );
  }

  Row formErrorText(BuildContext context, {required String error}) {
    return Row(
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: (18 / 375.0) * sizeInit(context).width,
        ),
        SizedBox(
          width: (10 / 375.0) * sizeInit(context).width,
        ),
        Text(error),
      ],
    );
  }
}
