import 'dart:async';

import 'package:bid_online_app_v2/components/default_button.dart';
import 'package:bid_online_app_v2/components/loading_process.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/helper.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/SessionDetail.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
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
  // Duration now = DateTime.now().difference(DateTime.parse(widget.session!.delayTime));

  _loadingSession() async {
    await SessionService().getAllSessions().then((value) {
      setState(() {
        loading = false;
        session = value
            .where((element) => element.sessionId == widget.session!.sessionId)
            .toList()
            .first;
        session!.joinFee = HomePage.listFees
            ?.where((element) => element.feeId == widget.session!.feeId)
            .first
            .participationFee;
        print(session!.finalPrice);
      });
      return value;
    }).timeout(
      const Duration(minutes: 1),
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

  _loadningJoinNotStart() async {
    AlertDialogMessage alert = AlertDialogMessage();
    await BidderService()
        .getJoinning(session!.sessionId, UserProfile.user!.userId!)
        .then((value) {
      setState(() {
        loading = false;
      });
      if (value.statusCode != 200) {
        if (value.body == messageRegister) {
          setState(() {
            checkRegister = true;
          });
          return alert.showAlertDialog(context, "Thông báo", value.body);
        } else {
          checkRegister = false;
        }
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
          return alert.showAlertDialog(context, "Thông báo", value.body);
        } else {
          setState(() {
            checkRegister = true;
          });
        }
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
      print(result);
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
      session = widget.session!;
    });
    setState(() {
      loading = true;
    });
    _loadingSession();
    setState(() {
      loading = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      _refreshData();
    });
    if (widget.session!.status == 1) {}
    if (widget.session!.status == 2) {}
    super.initState();
  }

  _bidTheSession() async {
    AlertDialogMessage alert = AlertDialogMessage();
    if (session!.status == 1) {
      return alert.showAlertDialog(
          context, "Thất bại", 'Chưa đến thời gian đấu giá');
    } else {
      await BidderService()
          .increasePrice(widget.session!.sessionId, UserProfile.user!.userId!)
          .then((value) {
        if (value.statusCode != 200) {
          return alert.showAlertDialog(context, "Có lỗi xảy ra", value.body);
        } else {
          _loadingSession();
          return alert.showAlertDialog(context, "Thành công",
              'Bạn vừa tăng giá là: ${Helper().formatCurrency(session!.stepPrice)} VNĐ');
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
  }

  _refreshData() async {
    await SessionService().getAllSessions().then((value) {
      setState(() {
        session = value
            .where((element) => element.sessionId == widget.session!.sessionId)
            .toList()
            .first;
        session!.joinFee = HomePage.listFees
            ?.where((element) => element.feeId == widget.session!.feeId)
            .first
            .participationFee;
      });
      return value;
    }).timeout(
      const Duration(minutes: 4),
      onTimeout: () {
        AlertDialogMessage alert = AlertDialogMessage();
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
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
      const Duration(minutes: 1),
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
                                child: session!.status == 1
                                    ? DefaultButton(
                                        text: "Đăng ký tham gia",
                                        press: () async {
                                          setState(() {
                                            loading = true;
                                          });
                                          await _loadningJoinNotStart();
                                          if (!checkRegister) {
                                            await _registerToSession();
                                            setState(() {
                                              loading = false;
                                            });
                                            await launchUrl(
                                                    Uri.parse(paymentUrl),
                                                    mode:
                                                        LaunchMode.inAppWebView)
                                                .whenComplete(() =>
                                                    Navigator.pop(context));
                                          }
                                        },
                                      )
                                    : checkEnableButton
                                        ? running
                                            ? ElevatedButton(
                                                style: const ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.blue)),
                                                onPressed: () {},
                                                child: Text(
                                                    '00:$minutes:$seconds'),
                                              )
                                            : ElevatedButton(
                                                style: const ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            kPrimaryColor)),
                                                onPressed: () async {
                                                  setState(() {
                                                    running = true;
                                                  });
                                                  _handleTimeButton();
                                                  setState(() {
                                                    loading = true;
                                                  });
                                                  await _bidTheSession();
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                },
                                                child: const Text('Tăng giá'),
                                              )
                                        : ElevatedButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        kPrimaryColor)),
                                            onPressed: () async {
                                              setState(() {
                                                loading = true;
                                              });
                                              await _loadningJoinInStage();
                                              setState(() {
                                                loading = false;
                                              });
                                              if (checkRegister) {
                                                setState(() {
                                                  checkEnableButton = true;
                                                });
                                              } else {
                                                await _registerToSession();
                                                await launchUrl(
                                                        Uri.parse(paymentUrl),
                                                        mode: LaunchMode
                                                            .inAppWebView)
                                                    .whenComplete(() =>
                                                        Navigator.pop(context));
                                                setState(() {
                                                  checkEnableButton = true;
                                                });
                                              }
                                            },
                                            child: const Text('Đấu giá'),
                                          ),
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
