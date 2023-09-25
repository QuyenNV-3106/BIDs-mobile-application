import 'dart:async';

import 'package:bid_online_app_v2/components/default_button.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/SessionHaveNotPay.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/pages/history/components/session_detail_componets/product_description.dart';
import 'package:bid_online_app_v2/pages/history/components/session_detail_componets/product_images.dart';
import 'package:bid_online_app_v2/pages/history/components/session_detail_componets/top_rounded_container.dart';
import 'package:bid_online_app_v2/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionDetailForPayment extends StatefulWidget {
  final SessionHaveNotPay? session;
  final bool? checkPayment;
  const SessionDetailForPayment({super.key, this.session, this.checkPayment});

  @override
  State<SessionDetailForPayment> createState() =>
      _SessionDetailForPaymentState();
}

class _SessionDetailForPaymentState extends State<SessionDetailForPayment> {
  late bool loading = false;
  String paymentUrl = '';
  late Timer _timer;
  bool paymentButton = false;

  _paymentComplete() async {
    await PaymentService()
        .paymentComplete(
            widget.session!.sessionResponseCompletes!.sessionId!,
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

  _refreshData() async {
    await PaymentService().paymentChecking(UserProfile.user!.userId!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.checkPayment != null) {
      paymentButton = widget.checkPayment!;
    }
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      _refreshData();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        title: const Text("Chi tiết"),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              ProductImages(session: widget.session!),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    ProductDescription(
                      session: widget.session!,
                      pressOnSeeMore: () {},
                    ),
                    TopRoundedContainer(
                      color: const Color(0xFFF6F7F9),
                      child: Column(
                        children: [
                          TopRoundedContainer(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: sizeInit(context).width * 0.15,
                                right: sizeInit(context).width * 0.15,
                                bottom: (40 / 375.0) * sizeInit(context).width,
                                top: (15 / 375.0) * sizeInit(context).width,
                              ),
                              child: paymentButton
                                  ? DefaultButton(
                                      text: "Thanh toán",
                                      press: () async {
                                        await _paymentComplete();

                                        await launchUrl(Uri.parse(paymentUrl),
                                                mode: LaunchMode.inAppWebView)
                                            .whenComplete(
                                                () => Navigator.pop(context));
                                      },
                                    )
                                  : const SizedBox(height: 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
