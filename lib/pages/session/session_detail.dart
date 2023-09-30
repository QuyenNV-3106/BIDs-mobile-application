import 'dart:async';

import 'package:bid_online_app_v2/components/default_button.dart';
import 'package:bid_online_app_v2/components/loading_process.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/helper.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/SessionDetail.dart';
import 'package:bid_online_app_v2/models/SessionHaveNotPay.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/pages/history/components/session_detail.dart';
import 'package:bid_online_app_v2/pages/history/services/history_services.dart';
import 'package:bid_online_app_v2/pages/home/home_page.dart';
import 'package:bid_online_app_v2/pages/home/services/session_service.dart';
import 'package:bid_online_app_v2/pages/login/components/alert_dialog.dart';
import 'package:bid_online_app_v2/pages/session/components/product_description.dart';
import 'package:bid_online_app_v2/pages/session/components/product_images.dart';
import 'package:bid_online_app_v2/pages/session/components/top_rounded_container.dart';
import 'package:bid_online_app_v2/pages/session/services/bidder_service.dart';
import 'package:bid_online_app_v2/services/payment_service.dart';
import 'package:bid_online_app_v2/services/signalR_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionDetailPage extends StatefulWidget {
  static String routeName = "/session_detail";
  final Session? session;
  const SessionDetailPage({super.key, this.session});
  static double? fee;

  @override
  State<SessionDetailPage> createState() => _SessionDetailPageState();
}

class _SessionDetailPageState extends State<SessionDetailPage> {
  late bool loading = false,
      running = false,
      checkEnableButton = false,
      checkRegister = false;
  Session? session;
  late bool check = true;
  late Timer _timer, _timerToBidder;
  String paymentUrl = "";
  static int seconds = 0, minutes = 0;
  late DateTime result;
  double? validFee;
  String winner = "";
  List<SessionHaveNotPay> sessionsNotpay = [];

  _loadingSession() async {
    setState(() {
      loading = true;
    });
    await SessionService().getAllSessions().then((value) {
      setState(() {
        loading = false;
        session = value
            .where((element) => element.sessionId == widget.session!.sessionId)
            .toList()
            .first;
      });
      return value;
    }).timeout(
      const Duration(minutes: 1),
      onTimeout: () {
        AlertDialogMessage alert = AlertDialogMessage();
        setState(() {
          loading = false;
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
    setState(() {
      loading = false;
    });
  }

  _loadningJoinNotStart() async {
    AlertDialogMessage alert = AlertDialogMessage();
    await BidderService()
        .getJoinning(session!.sessionId, UserProfile.user!.userId!)
        .then((value) {
      setState(() {
        loading = false;
      });
      if (value.body == messageRegister) {
        alert.showAlertDialog(context, "Thông báo", value.body);
      } else if (value.body == messageInStage) {
        setState(() {});
        return _showRegisterNotStartDialog(context, value.body);
      }
    }).timeout(
      const Duration(seconds: 50),
      onTimeout: () {
        setState(() {
          loading = false;
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
    setState(() {
      loading = false;
    });
  }

  _loadningJoinInStage() async {
    AlertDialogMessage alert = AlertDialogMessage();
    await BidderService()
        .getJoinningInstage(session!.sessionId, UserProfile.user!.userId!)
        .then((value) {
      setState(() {
        loading = false;
      });
      if (value.statusCode != 200) {
        if (value.body == messageInStage) {
          setState(() {
            checkRegister = false;
          });
          return _showRegisterNotStartDialog(context, value.body);
        }
      } else {
        setState(() {
          checkRegister = true;
        });
      }
    }).timeout(
      const Duration(minutes: 1),
      onTimeout: () {
        setState(() {
          loading = false;
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
    setState(() {
      loading = false;
    });
  }

  _handleTimeButton() async {
    print(session!.delayTime);
    setState(() {
      int second = int.parse(session!.delayTime.split(":").last);
      int minute = int.parse(session!.delayTime.split(":")[1]);
      int hour = int.parse(session!.delayTime.split(":").first);
      Duration secondToAdd = Duration(seconds: second),
          minuteToAdd = Duration(minutes: minute),
          hoursToAdd = Duration(hours: hour);
      result = DateTime.now().add(hoursToAdd);
      result = DateTime.now().add(minuteToAdd);
      result = DateTime.now().add(secondToAdd);

      minutes = minute;
      seconds = second;
    });
    _timerToBidder = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minutes > 0) {
        setState(() {
          running = true;
        });
        if (seconds > 0) {
          setState(() {
            running = true;
          });
          setState(() {
            seconds--;
          });
        } else if (seconds == 0) {
          seconds = 59;
          minutes--;
        }
      } else if (seconds > 0) {
        setState(() {
          running = true;
        });
        setState(() {
          seconds--;
        });
      }
      if (minutes == 0 && seconds == 0) {
        setState(() {
          running = false;
        });
        _stopTimer(false);
      }
      setState(() {
        print('$minutes : $seconds');
      });
    });
  }

  _resetTimer() {
    setState(() {});
  }

  _stopTimer(bool reset) {
    if (reset) {
      _resetTimer();
    } else {
      _timerToBidder.cancel();
    }
  }

  @override
  void initState() {
    setState(() {
      validFee = widget.session!.participationFee * widget.session!.firstPrice;
      if (validFee! > 200000) {
        validFee = 200000;
      }
      if (validFee! < 10000) {
        validFee = 10000;
      }
    });
    setState(() {
      session = widget.session!;
    });
    _loadingSession();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      _refreshData();
    });
    if (widget.session!.status == 1) {}
    if (widget.session!.status == 2) {}
    print('innn: ${session!.status}');

    super.initState();
  }

  _bidTheSession() async {
    AlertDialogMessage alert = AlertDialogMessage();
    await BidderService()
        .increasePrice(widget.session!.sessionId, UserProfile.user!.userId!)
        .then((value) {
      if (value.statusCode != 200) {
        return alert.showAlertDialog(context, "Có lỗi xảy ra", value.body);
      } else {
        setState(() {
          running = true;
        });
        _handleTimeButton();
        _loadingSession();
        return alert.showAlertDialog(context, "Thành công",
            'Giá bạn vừa tăng thêm là: ${Helper().formatCurrency(session!.stepPrice)} VNĐ');
      }
    }).timeout(
      const Duration(minutes: 1),
      onTimeout: () {
        setState(() {
          loading = false;
          // session ;
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
  }

  _refreshData() async {
    await SessionService().getAllSessionsNotStart();
    await SessionService().getAllSessionsInStage();
    await SessionService().getAllSessions().then((value) {
      setState(() {
        session = value
            .where((element) => element.sessionId == widget.session!.sessionId)
            .toList()
            .first;
      });
      return value;
    });
    await PaymentService().paymentChecking(UserProfile.user!.userId!);
  }

  void _showRegisterNotStartDialog(BuildContext context, String detail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                detail,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đồng ý'),
              onPressed: () {
                Navigator.of(context).pop();
                _showPaymentRegisterDialog(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showInStageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bạn có muốn tăng giá'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Bạn sẽ tăng thêm ${Helper().formatCurrency(widget.session!.stepPrice)} VNĐ',
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Đồng ý'),
              onPressed: () {
                setState(() {
                  running = true;
                });
                Navigator.of(context).pop();
                _bidTheSession();
              },
            ),
          ],
        );
      },
    );
  }

  _registerToSession() async {
    await PaymentService()
        .paymentRegister(
            session!.sessionId,
            UserProfile.user!.userId!,
            "https://capstone-bid-fe.vercel.app/payment-join-success",
            "https://capstone-bid-fe.vercel.app/payment-fail")
        .then((value) {
      setState(() {
        paymentUrl = value.body;
      });
      return value;
    }).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        AlertDialogMessage alert = AlertDialogMessage();
        setState(() {
          loading = false;
          // session ;
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
    setState(() {
      loading = false;
    });
  }

  void _showPaymentRegisterDialog(BuildContext context) {
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
                'Phí tham gia: ${Helper().formatCurrency(validFee!)} VNĐ',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Phí đặt cọc: ${Helper().formatCurrency(widget.session!.depositFee * widget.session!.firstPrice)} VNĐ',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Tổng số tiền phải trả: ${Helper().formatCurrency((widget.session!.depositFee * widget.session!.firstPrice) + validFee!)} VNĐ',
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
                await _registerToSession();

                await launchUrl(Uri.parse(paymentUrl),
                    mode: LaunchMode.externalApplication);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget sessionInstageProcess() {
    return DefaultButton(
        text: 'Đấu giá ngay',
        press: () async {
          setState(() {
            loading = true;
          });
          await _loadningJoinInStage();
          setState(() {
            loading = false;
          });
        });
  }

  Widget sessionNotStartProcess() {
    return DefaultButton(
        text: 'Đăng kí tham gia',
        press: () async {
          setState(() {
            loading = true;
          });
          await _loadningJoinNotStart();
          setState(() {
            loading = false;
          });
        });
  }

  Widget biddingButton() {
    return running
        ? ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue)),
            onPressed: () {},
            child: Text('00:$minutes:$seconds'),
          )
        : ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(kPrimaryColor)),
            onPressed: () async {
              setState(() {
                // running = true;
              });
              setState(() {
                loading = true;
              });
              // await _bidTheSession();
              _showInStageDialog(context);
              setState(() {
                loading = false;
              });
            },
            child: const Text('Tăng giá'),
          );
  }

  Widget sessionEnding() {
    return DefaultButton(
        text: 'Kết quả trúng thầu',
        press: () async {
          setState(() {
            loading = true;
          });
          await HistoryService()
              .getAllSessionsHaveNotPay(UserProfile.user!.userId!)
              .then((value) {
            sessionsNotpay = value
                .where((element) =>
                    element.sessionResponseCompletes.sessionId ==
                    session!.sessionId)
                .toList();
            winner = sessionsNotpay.first.winner;
          });
          setState(() {
            loading = false;
            Navigator.of(context).pop();
            _showEndSessionDialog(context);
          });
        });
  }

  void _showEndSessionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                (winner == UserProfile.user!.email)
                    ? "Chúc mừng bạn đã trúng thầu với tổng số tiền là: ${Helper().formatCurrency(session!.finalPrice)} VNĐ"
                    : "Chúc mừng $winner đã trúng thầu với tổng số tiền là: ${Helper().formatCurrency(session!.finalPrice)} VNĐ",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          actions: (winner == UserProfile.user!.email)
              ? <Widget>[
                  TextButton(
                    child: const Text('Thanh toán ngay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SessionDetailForPayment(
                            session: sessionsNotpay.first,
                            checkPayment: true,
                          ),
                        ),
                      );
                    },
                  ),
                ]
              : <Widget>[
                  TextButton(
                    child: const Text('Đồng ý'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        title: const Text("Chi tiết"),
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        // strokeWidth: 0,
        onRefresh: () async {
          setState(() {
            loading = true;
            check = false;
          });
          // getSetSessionUpdate(context, true);
          await _loadingSession();
          return;
        },
        color: kPrimaryColor,
        child: Stack(
          children: [
            ListView(
              children: [
                ProductImages(session: session!),
                TopRoundedContainer(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ProductDescription(
                        session: session!,
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
                                  bottom:
                                      (40 / 375.0) * sizeInit(context).width,
                                  top: (15 / 375.0) * sizeInit(context).width,
                                ),
                                child: (session!.status != 1 &&
                                        session!.status != 2)
                                    ? sessionEnding()
                                    : (!checkRegister
                                        ? (session!.status == 2
                                            ? sessionInstageProcess()
                                            : sessionNotStartProcess())
                                        : biddingButton()),
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
                        loadingProcess(context, 'Đang tải...', kLoading, false),
                  )
                : const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
