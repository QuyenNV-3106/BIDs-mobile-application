import 'package:bid_online_app_v2/main/MainState.dart';
import 'package:bid_online_app_v2/pages/forgot_password/forgot_password.dart';
import 'package:bid_online_app_v2/pages/form_item/create_item_page.dart';
import 'package:bid_online_app_v2/pages/history/history_page.dart';
import 'package:bid_online_app_v2/pages/home/home_page.dart';
import 'package:bid_online_app_v2/pages/login/login_page.dart';
import 'package:bid_online_app_v2/pages/personal_item/personal_item_page.dart';
import 'package:bid_online_app_v2/pages/register_user/register_account_page.dart';
import 'package:bid_online_app_v2/pages/session/components/bidder_history.dart';
import 'package:bid_online_app_v2/pages/session/session_detail.dart';
import 'package:bid_online_app_v2/pages/setting/Components/user_profile_page.dart';
import 'package:bid_online_app_v2/pages/splash/splash_screen.dart';
import 'package:bid_online_app_v2/pages/setting/setting_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (context) => const HomePage(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  LoginPage.routeName: (context) => const LoginPage(),
  RegisterAccountPage.routeName: (context) => const RegisterAccountPage(),
  ForgotPasswordPage.routeName: (context) => const ForgotPasswordPage(),
  MainStateScreen.routeName: (context) => const MainStateScreen(),
  SettingPage.routeName: (context) => const SettingPage(),
  SessionDetailPage.routeName: (context) => const SessionDetailPage(),
  HistoryBidder.routeName: (context) => const HistoryBidder(),
  UserProfilePage.routeName: (context) => const UserProfilePage(),
  HistoryPage.routeName: (context) => const HistoryPage(),
  CreateItemPage.routeName: (context) => const CreateItemPage(),
  PersonalItemPage.routeName: (context) => const PersonalItemPage()
};
