import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/pages/login/login_page.dart';
import 'package:bid_online_app_v2/pages/register_user/register_account_page.dart';
import 'package:flutter/material.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Bạn không có tài khoản? ",
          style: TextStyle(fontSize: (16 / 375.0) * sizeInit(context).width),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, RegisterAccountPage.routeName),
          child: Text(
            "Đăng ký",
            style: TextStyle(
                fontSize: (16 / 375.0) * sizeInit(context).width,
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
