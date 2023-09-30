import 'dart:async';

import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/helper.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/SessionDetail.dart';
import 'package:bid_online_app_v2/pages/session/components/bidder_history.dart';
import 'package:bid_online_app_v2/pages/session/services/SessionDetailService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    this.session,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Session? session;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  late double? joinFee, validFee;
  late Timer _timer;
  late bool isExpire = false;
  late bool isHistoryLoad = false;
  late List<SessionDetail>? sessionDetail = [];
  late DateTime _remainingDateTime = Helper().calculateRemainDayTime(
      widget.session!.beginTime, widget.session!.endTime);

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (!(Helper().calculateRemainDayTime(
                widget.session!.beginTime, widget.session!.endTime) ==
            _remainingDateTime)) {
          _remainingDateTime = Helper().calculateRemainDayTime(
              widget.session!.beginTime, widget.session!.endTime);
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
    print((widget.session!.status == 1 && !isExpire));
    _startCountdown();
    fetchSessionDetail();
    super.initState();
    setState(() {
      validFee = widget.session!.participationFee * widget.session!.firstPrice;
      if (validFee! > 200000) {
        validFee = 200000;
      }
      if (validFee! < 10000) {
        validFee = 10000;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  fetchSessionDetail() async {
    try {
      await SessionDetailService()
          .getSessionDetailHistory(widget.session!.sessionId)
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
            itemCount: widget.session!.descriptions.length,
            itemBuilder: (context, i) {
              return Text(
                  "${widget.session!.descriptions[i].description}: ${widget.session!.descriptions[i].detail}");
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
                  widget.session!.sessionName,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Giá khởi điểm: ${Helper().formatCurrency(widget.session!.firstPrice)} VNĐ',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              Text(
                'Bước giá: ${Helper().formatCurrency(widget.session!.stepPrice)} VNĐ',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              Text(
                // session.title,
                'Phân khúc: ${widget.session!.feeName}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              Text(
                'Phí tham gia: ${Helper().formatCurrency(validFee!)} VNĐ',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              Text(
                'Phí đặt cọc: ${Helper().formatCurrency(widget.session!.depositFee * widget.session!.firstPrice)} VNĐ',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              Text(
                'Thời gian bắt đầu: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(widget.session!.beginTime)}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              Text(
                'Thời gian trì hoãn tăng giá: ${widget.session!.delayTime}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              Text(
                'Thay đổi thời gian trì hoãn tăng giá: ${widget.session!.freeTime} (cuối)',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              Text(
                'Thời gian trì hoãn tăng giá đã thay đổi: ${widget.session!.delayFreeTime}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Trạng thái: ',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  (widget.session!.status == 1 && widget.session!.status != 3)
                      ? const Text(
                          'Sắp bắt đầu',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w400),
                        )
                      : const SizedBox(height: 0),
                  (widget.session!.status == 2 && widget.session!.status != 3)
                      ? const Text(
                          'Đang diễn ra',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w400),
                        )
                      : const SizedBox(height: 0),
                  (widget.session!.status != 1 && widget.session!.status != 2)
                      ? const Text(
                          'Đã kết thúc',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w400),
                        )
                      : const SizedBox(height: 0),
                ],
              ),
              const SizedBox(height: 15),
              widget.session!.status == 2
                  ? Row(
                      children: [
                        Text(
                          'Kết thúc trong: ',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        _timeWidget()
                      ],
                    )
                  : const SizedBox(height: 0),
              const SizedBox(height: 15),
              widget.session!.status == 2
                  ? Row(
                      children: [
                        Text(
                          'Giá hiện tại: ',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '${Helper().formatCurrency(widget.session!.finalPrice)} VNĐ',
                          style: TextStyle(
                              color: Colors.amber[700],
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )
                  : const SizedBox(height: 0),
              widget.session!.status == 2
                  ? const SizedBox(height: 15)
                  : const SizedBox(height: 0),
              widget.session!.descriptions.isEmpty
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
              widget.session!.status == 1
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => HistoryBidder(
                                  session: widget.session,
                                ),
                              ),
                            );
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
            widget.session!.description,
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
