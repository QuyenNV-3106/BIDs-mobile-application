import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/main/MainState.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/pages/history/components/error_by_user_tab.dart';
import 'package:bid_online_app_v2/pages/history/components/not_payment_tab.dart';
import 'package:bid_online_app_v2/pages/history/components/received_by_user_tab.dart';
import 'package:bid_online_app_v2/pages/history/components/session_complete_by_user_tab.dart';
import 'package:bid_online_app_v2/pages/history/components/session_fail_tab.dart';
import 'package:bid_online_app_v2/pages/history/components/session_instage_tab.dart';
import 'package:bid_online_app_v2/pages/history/components/success_by_user_tab.dart';
import 'package:bid_online_app_v2/services/payment_service.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  static String routeName = "/history-page";
  final Session? session;
  const HistoryPage({super.key, this.session});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String paymentUrl = "";
  late bool loading = false;
  String titleTab1 = "";
  int selectedIndex = 0;

  final List<String> _titles = [
    'Phiên đấu giá chưa thanh toán',
    'Phiên đấu giá thành công',
    'Phiên đấu giá thành công đã thanh toán',
    'Phiên đấu giá thất bại',
    'Phiên đấu giá đang diễn ra',
    'Phiên đấu giá đã nhận tài sản',
    'Phiên đấu giá hoàn trả tài sản',
    'Quay về trang cài đặt'
  ];

  _paymentComplete() async {
    await PaymentService()
        .paymentComplete(
            widget.session!.sessionId,
            UserProfile.user!.userId!,
            "https://capstone-bid-fe.vercel.app/payment-join-success",
            "https://capstone-bid-fe.vercel.app/payment-fail")
        .then((value) {
      setState(() {
        paymentUrl = value.body;
      });
      return value;
    });
    setState(() {
      loading = false;
    });
  }

  final List<Widget> _screens = const [
    NotPaymentTab(),
    SuccessByUserTab(),
    CompleteByUserTab(),
    FailByUserTab(),
    InstageByUserTab(),
    ReceivedByUserTab(),
    ErrorByUserTab(),
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
                selectedIndex = 4;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(_titles[5]),
            onTap: () {
              setState(() {
                selectedIndex = 5;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(_titles[6]),
            onTap: () {
              setState(() {
                selectedIndex = 6;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(_titles[7]),
            onTap: () {
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
      appBar: AppBar(title: Text(_titles[selectedIndex])),
      drawer: myDrawer(),
      body: Center(
        child: _screens[selectedIndex],
      ),
    );
  }
}
