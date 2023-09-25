import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/keyboard.dart';
import 'package:bid_online_app_v2/pages/register_user/components/register_form.dart';
import 'package:flutter/material.dart';

class RegisterAccountPage extends StatelessWidget {
  static String routeName = "/register_account";
  const RegisterAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Ẩn bàn phím khi người dùng chạm vào ngoài
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Đăng Ký Tài khoản"),
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: (20 / 375.0) * sizeInit(context).width),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: sizeInit(context).height * 0.04), // 4%
                    Text(
                      "Đăng Ký Tài khoản",
                      style: TextStyle(
                        fontSize: (28 / 375.0) * sizeInit(context).width,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: sizeInit(context).height * 0.08),
                    RegisterAccountForm(),
                    SizedBox(height: sizeInit(context).height * 0.08),
                    SizedBox(height: (20 / 812.0) * sizeInit(context).height),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
