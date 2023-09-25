import 'dart:async';

import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/helper.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/SessionDetail.dart';
import 'package:bid_online_app_v2/models/SessionHaveNotPay.dart';
import 'package:bid_online_app_v2/pages/session/components/bidder_history.dart';
import 'package:bid_online_app_v2/pages/session/services/SessionDetailService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    this.session,
    this.pressOnSeeMore,
  }) : super(key: key);

  final SessionHaveNotPay? session;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  late double? joinFee;
  late Timer _timer;
  late bool isExpire = false;
  late bool isHistoryLoad = false;
  late List<SessionDetail>? sessionDetail = [];
  late DateTime _remainingDateTime = Helper().calculateRemainDayTime(
      widget.session!.sessionResponseCompletes!.beginTime!,
      widget.session!.sessionResponseCompletes!.endTime!);

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (!(Helper().calculateRemainDayTime(
                widget.session!.sessionResponseCompletes!.beginTime!,
                widget.session!.sessionResponseCompletes!.endTime!) ==
            _remainingDateTime)) {
          _remainingDateTime = Helper().calculateRemainDayTime(
              widget.session!.sessionResponseCompletes!.beginTime!,
              widget.session!.sessionResponseCompletes!.endTime!);
        }
        if (_remainingDateTime.difference(DateTime.now()).isNegative) {
          isExpire = true;
          _timer.cancel();
        }
      });
    });
  }

  Widget _timeWidget() {
    return CountdownTimer(
      endTime: _remainingDateTime.millisecondsSinceEpoch,
      widgetBuilder: (_, CurrentRemainingTime? time) {
        if (time == null) {
          isExpire = true;
          return const Text(
            'Hết thời gian',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          );
        }
        String day = time.days == null ? "" : "${time.days} ngày";
        String hours = time.hours == null ? "" : "${time.hours} :";
        String mins = time.min == null ? "" : "${time.min} :";
        String secs = time.sec == null ? "" : "${time.sec} ";

        return Text(
          '$day $hours $mins $secs',
          // style: Theme.of(context).textTheme.titleSmall,
          style: const TextStyle(color: Colors.red),
        );
      },
    );
  }

  @override
  void initState() {
    _startCountdown();
    fetchSessionDetail();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  fetchSessionDetail() async {
    try {
      await SessionDetailService()
          .getSessionDetailHistory(
              widget.session!.sessionResponseCompletes!.sessionId!)
          .then((value) {
        setState(() {
          sessionDetail = value;
        });
      });
    } catch (e) {
      setState(() {
        isHistoryLoad = false;
      });
    }
  }

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Thông Số"),
          content: ListView.builder(
            shrinkWrap: true,
            itemCount:
                widget.session!.sessionResponseCompletes!.descriptions!.length,
            itemBuilder: (context, i) {
              return Text(
                  "${widget.session!.sessionResponseCompletes!.descriptions![i].description}: ${widget.session!.sessionResponseCompletes!.descriptions![i].detail}");
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: const Text("Đóng"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: (20 / 375.0) * sizeInit(context).width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.session!.sessionResponseCompletes!.sessionName!,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Giá khởi điểm: ${Helper().formatCurrency(widget.session!.sessionResponseCompletes!.finalPrice!)} VNĐ',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              Text(
                // session.title,
                'Phân khúc: ${widget.session!.sessionResponseCompletes!.feeName}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Trạng thái: ',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Text(
                    'Đã kết thúc',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Thời gian kết thúc: ',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    '${widget.session!.sessionResponseCompletes!.endTime!}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Tổng giá tiền: ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${Helper().formatCurrency(widget.session!.sessionResponseCompletes!.finalPrice!)} VNĐ',
                    style: TextStyle(
                        color: Colors.amber[700], fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              widget.session!.sessionResponseCompletes!.descriptions!.isEmpty
                  ? const SizedBox(height: 0)
                  : ElevatedButton.icon(
                      icon: const Icon(Icons.library_books),
                      label: const Text('Thông số'),
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green)),
                      onPressed: () async {
                        _showDetails(context);
                      },
                    ),
              const SizedBox(height: 15),
              widget.session!.sessionResponseCompletes!.status == 1
                  ? const SizedBox(height: 0)
                  : isHistoryLoad
                      ? const CircularProgressIndicator(color: kPrimaryColor)
                      : ElevatedButton.icon(
                          icon: const Icon(Icons.history),
                          label: const Text('Lịch sử đặt giá'),
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red)),
                          onPressed: () async {
                            setState(() {
                              isHistoryLoad = true;
                            });
                            await fetchSessionDetail();
                            setState(() {
                              isHistoryLoad = false;
                            });
                            setState(() {
                              Navigator.pushNamed(
                                  context, HistoryBidder.routeName,
                                  arguments: sessionDetail);
                            });
                          },
                        ),
              const SizedBox(height: 15),
              Text(
                'Chi tiết',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all((10 / 375.0) * sizeInit(context).width),
            width: (64 / 375.0) * sizeInit(context).width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: (20 / 375.0) * sizeInit(context).width,
            right: (64 / 375.0) * sizeInit(context).width,
          ),
          child: ReadMoreText(
            widget.session!.sessionResponseCompletes!.description!,
            trimLines: 3,
            trimMode: TrimMode.Line,
            trimCollapsedText: '\t\t\tXem thêm',
            trimExpandedText: '\t\t\tThu gọn',
            moreStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor),
            lessStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
            style: GoogleFonts.workSans(
                fontSize: (15 / 375.0) * sizeInit(context).width),
          ),
        ),
      ],
    );
  }
}

class Dialog extends StatelessWidget {
  const Dialog({super.key, required this.session});
  final Session session;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Thông Số"),
      content: ListView.builder(
        itemCount: session.descriptions.length,
        itemBuilder: (context, i) {
          return Text(
              "${session.descriptions[i].description}: ${session.descriptions[i].detail}");
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Đóng hộp thoại
          },
          child: Text("Đóng"),
        ),
      ],
    );
  }
}
