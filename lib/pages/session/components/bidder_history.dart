import 'dart:async';

import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/helper.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/SessionDetail.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/pages/session/services/SessionDetailService.dart';
import 'package:bid_online_app_v2/services/payment_service.dart';
import 'package:flutter/material.dart';

class HistoryBidder extends StatefulWidget {
  static String routeName = "/bid_history";
  final Session? session;
  const HistoryBidder({super.key, this.session});

  @override
  State<HistoryBidder> createState() => _HistoryBidderState();
}

class _HistoryBidderState extends State<HistoryBidder> {
  late Timer _timer;
  List<SessionDetail> _sessionDetail = [];
  bool isHistoryLoad = false;

  fetchSessionDetail() async {
    setState(() {
      isHistoryLoad = true;
    });
    try {
      await SessionDetailService()
          .getSessionDetailHistory(widget.session!.sessionId)
          .then((value) {
        setState(() {
          _sessionDetail = value!;
          isHistoryLoad = false;
        });
      });
    } catch (e) {
      setState(() {
        isHistoryLoad = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  _refreshData() async {
    await SessionDetailService()
        .getSessionDetailHistory(widget.session!.sessionId)
        .then((value) {
      setState(() {
        _sessionDetail = value!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      _refreshData();
    });
    fetchSessionDetail();
  }

  @override
  Widget build(BuildContext context) {
    // final List<SessionDetail> sessionDetail =
    //     ModalRoute.of(context)!.settings.arguments as List<SessionDetail>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đặt giá'),
      ),
      body: isHistoryLoad
          ? const Center(child: CircularProgressIndicator(color: kPrimaryColor))
          : _sessionDetail.isEmpty
              ? const Center(child: Text('Không có ai đặt giá'))
              : ListView.builder(
                  itemCount: _sessionDetail.length,
                  itemBuilder: (context, i) {
                    return Container(
                        child: Card(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.album,
                              color: _sessionDetail[i].userId ==
                                      UserProfile.user!.userId!
                                  ? Colors.green
                                  : kPrimaryColor,
                            ),
                            title: Text('Tên: ${_sessionDetail[i].userName}'),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${_sessionDetail[i].createDate}'),
                                Text(
                                  '${Helper().formatCurrency(_sessionDetail[i].price!)} VNĐ',
                                  style: TextStyle(
                                      color: Colors.amber[700],
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ])));
                  },
                ),
    );
  }
}
