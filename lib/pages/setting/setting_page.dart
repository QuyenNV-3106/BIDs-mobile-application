import 'package:bid_online_app_v2/components/loading_process.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/helper.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/pages/history/history_page.dart';
import 'package:bid_online_app_v2/pages/home/home_page.dart';
import 'package:bid_online_app_v2/pages/login/login_page.dart';
import 'package:bid_online_app_v2/pages/personal_item/personal_item_page.dart';
import 'package:bid_online_app_v2/pages/setting/Components/profile_pic.dart';
import 'package:bid_online_app_v2/pages/setting/Components/user_profile_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'Components/profile_menu.dart';

class SettingPage extends StatefulWidget {
  static String routeName = "/settings";
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool logout = false;
  late bool _connectionStatus = false;

  void _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectionStatus = _getStatusString(connectivityResult);
      print('object: $_connectionStatus');
    });
  }

  bool _getStatusString(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.none:
        return false;
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.mobile:
        return true;
      default:
        return false;
    }
  }

  void _logoutProcess() async {
    await Future.delayed(const Duration(seconds: 15));
  }

  @override
  void initState() {
    _checkInternetConnection();
    // Lắng nghe sự thay đổi kết nối internet
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = _getStatusString(result);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = _getStatusString(result);
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cài dặt"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  const ProfilePic(),
                  const SizedBox(height: 20),
                  Text(
                    Helper()
                        .capitalizeVietnamese(UserProfile.user!.userName ?? ''),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ProfileMenu(
                    text: "Tài khoản",
                    icon: const Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                    press: () => {
                      Navigator.pushNamed(context, UserProfilePage.routeName)
                    },
                  ),
                  ProfileMenu(
                    text: "Tài sản của tôi",
                    icon: const Icon(
                      Icons.attach_money,
                      color: Colors.green,
                    ),
                    press: () => {
                      Navigator.pushNamed(context, PersonalItemPage.routeName)
                    },
                  ),
                  ProfileMenu(
                    text: "Lịch sử",
                    icon: const Icon(
                      Icons.history,
                      color: Colors.green,
                    ),
                    press: () {
                      Navigator.pushNamed(context, HistoryPage.routeName);
                    },
                  ),
                  ProfileMenu(
                    text: "Help Center",
                    icon: const Icon(
                      Icons.help,
                      color: Colors.green,
                    ),
                    press: () {},
                  ),
                  ProfileMenu(
                    text: "Đăng xuất",
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.green,
                    ),
                    press: () {
                      setState(() {
                        logout = true;
                        HomePage.loadingIslogin = null;
                        LoginPage.isLogin = false;
                      });
                      _logoutProcess();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginPage.routeName, (route) => false);
                    },
                  ),
                ],
              ),
            ),
            logout == true
                ? Center(
                    child: loadingProcess(
                        context, "Hẹn gặp lại", Colors.white, false),
                  )
                : const SizedBox(
                    height: 0,
                  )
          ],
        ),
      ),
    );
  }
}
