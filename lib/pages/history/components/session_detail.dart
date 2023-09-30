import 'dart:async';

import 'package:bid_online_app_v2/components/default_button.dart';
import 'package:bid_online_app_v2/components/loading_process.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/helper.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/SessionHaveNotPay.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/pages/history/components/session_detail_componets/product_description.dart';
import 'package:bid_online_app_v2/pages/history/components/session_detail_componets/product_images.dart';
import 'package:bid_online_app_v2/pages/history/components/session_detail_componets/top_rounded_container.dart';
import 'package:bid_online_app_v2/pages/login/components/alert_dialog.dart';
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
  late bool loading = false, enable = true;
  String paymentUrl = '';
  late Timer _timer;
  bool paymentButton = false;
  AlertDialogMessage aleart = AlertDialogMessage();

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
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      _refreshData();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  void _showInputPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận trả hàng'),
          content: const Column(
            children: [
              Text(
                  'Bạn có đồng ý trả lại tài sản\nLưu ý: bạn sẽ mất số tiền tham gia và tiền cọc của tài sản'),
              TextField(
                // controller: _textController,
                decoration: InputDecoration(labelText: 'Lý do trả hàng'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy bỏ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Đồng ý'),
              onPressed: () {
                // Ở đây, bạn có thể xử lý dữ liệu từ ô nhập, ví dụ:
                // final userInput = _textController.text;
                // print('Dữ liệu nhập: $userInput');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showError() {
    print("errors");
  }

  _showInputPopup2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Từ chối thanh toán'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Bạn có đồng ý từ chối thanh toán?\nLưu ý: bạn sẽ mất số tiền tham gia và tiền cọc của tài sản'),
              // TextField(
              //   // controller: _textController,
              //   decoration: InputDecoration(labelText: 'Lý do trả hàng'),
              // ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy bỏ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Đồng ý'),
              onPressed: () async {
                setState(() {
                  Navigator.of(context).pop();
                  loading = true;
                });
                await PaymentService()
                    .rejectPayment(
                        widget.session!.sessionResponseCompletes.sessionId)
                    .then((value) {
                  setState(() {
                    loading = false;
                  });
                  print("status:${value.body}");
                  setState(() {
                    enable = false;
                    aleart.showAlertDialog(
                        context, "Thành công", "Bạn đã từ chối thanh toán");
                  });
                  // if (value.statusCode == 200) {
                  //   setState(() {
                  //     aleart.showAlertDialog(
                  //         context, "Thành công", "Bạn đã từ chối thanh toán");
                  //   });
                  // } else {
                  //   setState(() {
                  //     aleart.showAlertDialog(context, "Thất bại", value.body);
                  //   });
                  // }
                  // Navigator.of(context).pop();
                }).timeout(
                  const Duration(seconds: 50),
                  onTimeout: () {
                    setState(() {
                      loading = false;
                    });
                    // Navigator.of(context).pop();
                  },
                );
                setState(() {
                  loading = false;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chi tiết đơn hàng'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Tên vật phẩm: ${widget.session!.sessionResponseCompletes.itemName}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Giá tiền: ${Helper().formatCurrency(widget.session!.sessionResponseCompletes.finalPrice)} VNĐ',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Tổng số tiền phải trả: ${Helper().formatCurrency(widget.session!.sessionResponseCompletes.finalPrice)} VNĐ',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Thoát'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Thanh toán bằng PayPal'),
              onPressed: () async {
                setState(() {
                  Navigator.of(context).pop();
                  loading = true;
                });
                await _paymentComplete();
                setState(() {
                  enable = false;
                  loading = false;
                });

                await launchUrl(Uri.parse(paymentUrl),
                    mode: LaunchMode.externalApplication);
              },
            ),
          ],
        );
      },
    );
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
                              child: paymentButton && enable
                                  ? Column(
                                      children: [
                                        widget.session!.winner ==
                                                UserProfile.user!.email
                                            ? DefaultButton(
                                                text: "Thanh toán",
                                                press: () async {
                                                  // Navigator.of(context).pop();
                                                  _showPaymentDialog(context);
                                                },
                                              )
                                            : const SizedBox(height: 0),
                                        widget.session!.winner ==
                                                UserProfile.user!.email
                                            ? const SizedBox(height: 20)
                                            : const SizedBox(height: 0),
                                        widget.session!.winner ==
                                                UserProfile.user!.email
                                            ? TextButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  _showInputPopup2(context);
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                },
                                                child: const Text(
                                                    "Từ chối thanh toán",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red)))
                                            : const SizedBox(height: 0),
                                      ],
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
          loading
              ? Center(
                  child:
                      loadingProcess(context, 'Đang xử lí...', kLoading, false),
                )
              : const SizedBox(height: 0),
        ],
      ),
    );
  }
}
