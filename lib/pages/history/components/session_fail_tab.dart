import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/helper.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/SessionHaveNotPay.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/pages/history/components/session_detail.dart';
import 'package:bid_online_app_v2/pages/history/services/history_services.dart';
import 'package:flutter/material.dart';

class FailByUserTab extends StatefulWidget {
  final Session? session;
  const FailByUserTab({super.key, this.session});

  @override
  State<FailByUserTab> createState() => _FailByUserTabState();
}

class _FailByUserTabState extends State<FailByUserTab> {
  List<SessionHaveNotPay> sessions = [];
  bool loading = false;

  _loadResources() async {
    setState(() {
      loading = false;
    });
    await HistoryService()
        .getSessionFailByUser(UserProfile.user!.userId!)
        .then((value) {
      sessions = value;
    });
    setState(() {
      loading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("call");
  }

  @override
  Widget build(BuildContext context) {
    return !loading
        ? const Center(
            child: spinkit,
          )
        : sessions.isEmpty
            ? const Center(child: Text('Danh sách trống'))
            : ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context, i) {
                  return Container(
                      child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SessionDetailForPayment(
                            session: sessions[i],
                            checkPayment: false,
                          ),
                        ),
                      );
                    },
                    child: Card(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                          ListTile(
                            title: Text(
                                'Tên: ${sessions[i].sessionResponseCompletes!.itemName}'),
                            subtitle: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Thời gian: ${sessions[i].sessionResponseCompletes!.endTime}'),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Giá tiền: ${Helper().formatCurrency(sessions[i].sessionResponseCompletes!.finalPrice!)} VNĐ',
                                      style: TextStyle(
                                          color: Colors.amber[700],
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ])),
                  ));
                },
              );
  }
}
