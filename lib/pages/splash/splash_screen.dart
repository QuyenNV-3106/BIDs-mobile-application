import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/keyboard.dart';
import 'package:bid_online_app_v2/pages/home/home_page.dart';
import 'package:bid_online_app_v2/pages/login/login_page.dart';
import 'package:bid_online_app_v2/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = sizeInit(context);

    return GestureDetector(
      onTap: () {
        // Ẩn bàn phím khi người dùng chạm vào ngoài
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              child: const SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image(
                      image: AssetImage(logo),
                      fit: BoxFit.fitWidth,
                    ),
                    spinkit,
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
