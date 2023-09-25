import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/main/MainState.dart';
import 'package:bid_online_app_v2/pages/personal_item/components/item_accepted.dart';
import 'package:bid_online_app_v2/pages/personal_item/components/item_denied.dart';
import 'package:bid_online_app_v2/pages/personal_item/components/item_waiting_create_session.dart';
import 'package:bid_online_app_v2/pages/personal_item/components/item_waitting.dart';
import 'package:bid_online_app_v2/pages/setting/setting_page.dart';
import 'package:flutter/material.dart';

class PersonalItemPage extends StatefulWidget {
  static String routeName = "/personal-item";

  const PersonalItemPage({super.key});
  @override
  State<PersonalItemPage> createState() => _PersonalItemPageState();
}

class _PersonalItemPageState extends State<PersonalItemPage> {
  int selectedIndex = 0;

  final List<String> _titles = [
    'Sản phẩm chờ duyệt',
    'Sản phẩm đã lên sàn',
    'Sản phẩm chưa lên sàn',
    'Sản phẩm đã bị hủy',
    'Quay lại trang cài đặt'
  ];

  final List<Widget> _screens = [
    const ItemWaitting(),
    const ItemAccepted(),
    const ItemWaitingCreateSession(),
    const ItemDenied(),
    const ItemDenied(),
  ];
  Widget myDrawer() {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: (70 / 812.0) * sizeInit(context).height),
          ListTile(
            title: Text(_titles[0]),
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(_titles[1]),
            onTap: () {
              setState(() {
                selectedIndex = 1;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(_titles[2]),
            onTap: () {
              setState(() {
                selectedIndex = 2;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(_titles[3]),
            onTap: () {
              setState(() {
                selectedIndex = 3;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(_titles[4]),
            onTap: () {
              setState(() {
                // selectedIndex = 4;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainStateScreen(indexPage: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[selectedIndex]),
      ),
      drawer: myDrawer(),
      body: Center(
        child: _screens[selectedIndex],
      ),
    );
  }
}
