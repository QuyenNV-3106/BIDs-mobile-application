import 'dart:async';

import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/helper.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/pages/login/components/alert_dialog.dart';
import 'package:bid_online_app_v2/pages/session/session_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CardProduct extends StatefulWidget {
  const CardProduct({super.key, required this.session});
  final Session session;

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  late double? fee, validFee;
  late Timer _timer;
  late bool isExpire = false;
  late bool isLoading = true;
  late DateTime _remainingDateTime =
      _calculateRemainDayTime(widget.session.beginTime, widget.session.endTime);

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (!(_calculateRemainDayTime(
                widget.session.beginTime, widget.session.endTime) ==
            _remainingDateTime)) {
          _remainingDateTime = _calculateRemainDayTime(
              widget.session.beginTime, widget.session.endTime);
        }
        if (_remainingDateTime.difference(DateTime.now()).isNegative) {
          isExpire = true;
          _timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    _startCountdown();
    setState(() {
      isLoading = false;
    });
    setState(() {
      validFee = widget.session.joinFee! * widget.session.firstPrice;
      if (validFee! > 120000) {
        validFee = 120000;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  DateTime _calculateRemainDayTime(DateTime startDay, DateTime endDay) {
    DateTime now = DateTime.now();
    if (now.isAfter(endDay)) {
      return endDay;
    } else if (now.isBefore(startDay)) {
      return endDay;
    } else {
      return endDay.isAfter(now) ? endDay : now;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // Navigator.pushNamed(context, SessionDetailPage.routeName);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SessionDetailPage(
                      session: widget.session,
                    )),
          );
        },
        child: Container(
          // height: 300,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // SizedBox(height: sizeInit(context).height / 80),
                  Expanded(
                    child: widget.session.images.isEmpty
                        ? Image.asset(noImage)
                        : Image.network(
                            widget.session.images.first.detail,
                            fit: BoxFit.fitWidth,
                            loadingBuilder: (context, child, loadingProgress) =>
                                loadingProgress == null
                                    ? child
                                    : Image.asset(noImage),
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(noImage),
                          ),
                  ),
                  Text(
                    widget.session.sessionName,
                    style: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: sizeInit(context).height / 80),
                  Text(
                    'Phí tham gia: ${Helper().formatCurrency(validFee!)} VNĐ',
                    style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w600,
                      fontSize: (11 / 375.0) * sizeInit(context).width,
                    ),
                  ),
                  widget.session.status == 1
                      ? Text(
                          'Chưa bắt đầu',
                          style: GoogleFonts.workSans(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        )
                      : const SizedBox(height: 0),
                  widget.session.status == 2
                      ? Text(
                          'Đang diễn ra',
                          style: GoogleFonts.workSans(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        )
                      : const SizedBox(height: 0)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
