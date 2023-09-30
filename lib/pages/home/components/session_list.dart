import 'package:bid_online_app_v2/components/loading_process.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/pages/home/components/card_list.dart';
import 'package:bid_online_app_v2/pages/home/home_page.dart';
import 'package:bid_online_app_v2/pages/home/services/session_service.dart';
import 'package:bid_online_app_v2/pages/login/components/alert_dialog.dart';
import 'package:flutter/material.dart';

class SessionList extends StatefulWidget {
  const SessionList({super.key, required this.session});
  final List<Session> session;

  // final List<Item> items;
  @override
  State<SessionList> createState() => _SessionListState();
}

class _SessionListState extends State<SessionList> {
  // final Item item;
  bool loading = true;
  double? offset;
  bool _loading = false;
  bool _loadingSmall = false;
  String stateLoading = loadingHomeState;
  List<Session> sessionCurrentList = [];
  AlertDialogMessage alert = AlertDialogMessage();

  @override
  void initState() {
    sessionCurrentList = widget.session;
    super.initState();
  }

  loadingResources() async {
    await SessionService().getAllSessions().then((value) {
      setState(() {
        _loading = false;
        sessionCurrentList = value;
        // sessionCurrentList = value.where((element) {
        //   if ((element.status == 1 || element.status == 2) &&
        //       element.endTime.isAfter(DateTime.now())) {
        //     DateTime now = DateTime.now();
        //     if (now.isAfter(element.endTime)) {
        //       element.status = 3;
        //       return true;
        //     } else if (now.isBefore(element.beginTime)) {
        //       element.status = 1;
        //       return true;
        //     } else {
        //       element.status = 2;
        //       return true;
        //     }
        //   }
        //   return false;
        // }).toList();
        _loadingSmall = false;
      });
      return value;
    }).timeout(
      const Duration(minutes: 1),
      onTimeout: () {
        setState(() {
          _loading = false;
          _loadingSmall = false;
          sessionCurrentList = [];
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      itemCount: widget.session.length,
      itemBuilder: (ctx, i) {
        loading = false;
        // widget.session.first.status = 2;
        // widget.session[i].joinFee = HomePage.listFees
        //     ?.where((element) => element.feeId == widget.session[i].feeId)
        //     .first
        //     .participationFee;
        return CardProduct(
          session: widget.session[i],
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0,
        mainAxisExtent: 264,
      ),
    );
  }
}
