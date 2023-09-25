import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/pages/forgot_password/forgot_password.dart';
import 'package:flutter/material.dart';

class RememberAccount extends StatefulWidget {
  const RememberAccount({super.key});

  @override
  State<RememberAccount> createState() => _RememberAccountState();
}

class _RememberAccountState extends State<RememberAccount> {
  bool remember = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: remember,
          activeColor: kPrimaryColor,
          onChanged: (value) {
            setState(() {
              remember = value!;
            });
          },
        ),
        const Text("Nhớ tài khoản"),
        const Spacer(),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, ForgotPasswordPage.routeName),
          child: const Text(
            "Quên Mật khẩu?",
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
