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
  const MainStateScreen({super.key, this.indexPage});

  @override
  State<MainStateScreen> createState() => _MainStateScreenState();
}

class _MainStateScreenState extends State<MainStateScreen> {
  int _currentIndex = 0;
  bool reloadHome = false;
  ScrollController homeController = ScrollController();
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
    const CreateItemPage(),
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications),
          //   label: 'Thông báo',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Thêm sản phẩm',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.history),
          //   label: 'Lịch sử',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }
}
