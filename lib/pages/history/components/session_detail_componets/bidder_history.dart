import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/helper.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/SessionDetail.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:flutter/material.dart';

class HistoryBidder extends StatefulWidget {
  static String routeName = "/bid_history";
  const HistoryBidder({super.key});

  @override
  State<HistoryBidder> createState() => _HistoryBidderState();
}

class _HistoryBidderState extends State<HistoryBidder> {
  @override
  Widget build(BuildContext context) {
    final List<SessionDetail> sessionDetail =
        ModalRoute.of(context)!.settings.arguments as List<SessionDetail>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đặt giá'),
      ),
      body: sessionDetail.isEmpty
          ? const Center(child: Text('Không có ai đặt giá'))
          : ListView.builder(
              itemCount: sessionDetail.length,
              itemBuilder: (context, i) {
                return Container(
                    child: Card(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.album,
                          color: sessionDetail[i].userId ==
                                  UserProfile.user!.userId!
                              ? Colors.green
                              : kPrimaryColor,
                        ),
                        title: Text('Tên: ${sessionDetail[i].userName}'),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${sessionDetail[i].createDate}'),
                            Text(
                              '${Helper().formatCurrency(sessionDetail[i].price!)} VNĐ',
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
