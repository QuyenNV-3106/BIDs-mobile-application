import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/pages/forgot_password/components/forgot_password_form.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  static String routeName = "/reset";
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Ẩn bàn phím khi người dùng chạm vào ngoài
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Lấy Lại Mật Khẩu")),
        body: Center(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: (20 / 375.0) * sizeInit(context).width),
                child: Column(
                  children: [
                    SizedBox(height: sizeInit(context).height * 0.04),
                    Text(
                      "Nhập Email",
                      style: TextStyle(
                        fontSize: (28 / 375.0) * sizeInit(context).width,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Nhập email đã đăng ký của bạn ở đây",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: sizeInit(context).height / 15),
                    ForgotPasswordForm()
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
