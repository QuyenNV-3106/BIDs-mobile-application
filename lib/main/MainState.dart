import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/pages/form_item/create_item_page.dart';
import 'package:bid_online_app_v2/pages/home/home_page.dart';
import 'package:bid_online_app_v2/pages/login/login_page.dart';
import 'package:bid_online_app_v2/pages/setting/setting_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainStateScreen extends StatefulWidget {
  static String routeName = "/main";
  static bool homeLoading = false;
  final int? indexPage;
  final bool? firstIn;
  const MainStateScreen({super.key, this.indexPage, this.firstIn});

  @override
  State<MainStateScreen> createState() => _MainStateScreenState();
}

class _MainStateScreenState extends State<MainStateScreen> {
  int _currentIndex = 0;
  bool reloadHome = false;
  ScrollController homeController = ScrollController();
  PageController _pageController = PageController();
  late bool _connectionStatus = false;

  void _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectionStatus = _getStatusString(connectivityResult);
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

  @override
  void initState() {
    super.initState();
    if (widget.indexPage != null) {
      setState(() {
        // if (widget.firstIn == null) {
        //   reloadHome = false;
        // } else {
        //   reloadHome = widget.firstIn!;
        // }
        _currentIndex = widget.indexPage!;
      });
    }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _checkInternetConnection();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = _getStatusString(result);
      });
    });
  }

  final List<Widget> _screens = [
    const HomePage(),
    // const LoginPage(),
    const CreateItemPage(registerItem: true),
    const SettingPage(),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    _currentIndex = index;
    switch (index) {
      case 0:
        setState(() {
          MainStateScreen.homeLoading = true;
        });
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      default:
        break;
    }
  }

  Widget _screen() {
    return PageView(
      controller: _pageController,
      children: _screens,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = _getStatusString(result);
      });
    });
    return Scaffold(
        body: !_connectionStatus
            ? const Center(
                child: alertConnecrion(),
              )
            : _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              // _pageController.jumpToPage(index);
              _onItemTapped(index);
            });
          },
          selectedLabelStyle: const TextStyle(color: kPrimaryColor),
          selectedItemColor: kPrimaryColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'Thêm tài sản',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Cài đặt',
            ),
          ],
        ));
  }
}
