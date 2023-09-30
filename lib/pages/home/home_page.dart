import 'package:bid_online_app_v2/components/loading_process.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/Category.dart';
import 'package:bid_online_app_v2/models/Fee.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/pages/home/components/session_list.dart';
import 'package:bid_online_app_v2/pages/login/components/alert_dialog.dart';
import 'package:bid_online_app_v2/pages/login/login_page.dart';
import 'package:bid_online_app_v2/pages/home/services/category_service.dart';
import 'package:bid_online_app_v2/pages/home/services/session_service.dart';
import 'package:bid_online_app_v2/services/fee_service.dart';
import 'package:bid_online_app_v2/services/payment_service.dart';
import 'package:bid_online_app_v2/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/category_bar.dart';
import 'components/header.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home";
  static bool? loadingIslogin = !LoginPage.isLogin;
  static String? categoryString;
  static List<Fee>? listFees;
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserProfile userProfile = UserProfile();
  List<CategoryProduct>? listCategory = [];
  List<Session> listSessions = [];
  List<Session> listSessionsSearch = [];
  List<Session> listAllSessions = [];
  List<Session>? listSessionsShow;
  String? itemID;
  String stateLoading = loadingHomeState;
  bool _loading = false;
  bool _loadingSmall = false;
  AlertDialogMessage alert = AlertDialogMessage();
  double? offset;
  bool checkIncomming = true;
  bool checkIsgoing = false;
  int selectedIndex = 0;

  loadingResources() async {
    setState(() {
      _loading = true;
    });
    await UserService().getUser(UserProfile.emailSt!).then((value) {
      setState(() {
        // _loading = false;
        userProfile = value;
      });
      return value;
    }).timeout(
      const Duration(minutes: 3),
      onTimeout: () {
        setState(() {
          _loading = false;
          _loadingSmall = false;
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
    await PaymentService().paymentChecking(UserProfile.user!.userId!);

    await CategoryService().getAllCategories().then((value) {
      setState(() {
        // _loading = false;
        listCategory =
            value.where((element) => element.status == true).toList();
        listCategory!.insert(
            0,
            CategoryProduct(
                categoryId: "1", categoryName: "Tất cả", status: true));
      });
      return value;
    }).timeout(
      const Duration(minutes: 2),
      onTimeout: () {
        setState(() {
          _loading = false;
          _loadingSmall = false;
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
    await SessionService().getAllSessionsNotStart().then((value) {
      setState(() {
        _loading = false;
        _loadingSmall = false;
        listAllSessions = List.from(listAllSessions)..addAll(value);
      });
      return value;
    }).timeout(
      const Duration(minutes: 1),
      onTimeout: () {
        setState(() {
          _loading = false;
          _loadingSmall = false;
          listAllSessions = [];
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
    await SessionService().getAllSessionsInStage().then((value) {
      setState(() {
        _loading = false;
        _loadingSmall = false;
        listAllSessions = List.from(listAllSessions)..addAll(value);
      });
      return value;
    }).timeout(
      const Duration(minutes: 1),
      onTimeout: () {
        setState(() {
          _loading = false;
          _loadingSmall = false;
          listAllSessions = [];
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
    setState(() {
      _loading = false;
      listSessions = listAllSessions;
    });
    return;
  }

  @override
  void initState() {
    setState(() {
      HomePage.loadingIslogin = LoginPage.isLogin;
      _loading = true;
      if (HomePage.loadingIslogin != null) {
        if (HomePage.loadingIslogin!) {
          stateLoading = loadingLoginSuccessState;
          HomePage.loadingIslogin = null;
        } else {
          stateLoading = loadingHomeState;
          HomePage.loadingIslogin = null;
        }
      }
      LoginPage.isLogin = false;
    });
    loadingResources();
    super.initState();
  }

  @override
  void dispose() {
    HomePage.loadingIslogin = null;
    super.dispose();
  }

  loadingSession() async {
    setState(() {
      // _loading = false;
      listSessions = [];
      listAllSessions = [];
    });
    await CategoryService().getAllCategories().then((value) {
      setState(() {
        // _loading = false;
        listCategory =
            value.where((element) => element.status == true).toList();
        listCategory!.insert(
            0,
            CategoryProduct(
                categoryId: "1", categoryName: "Tất cả", status: true));
      });
      return value;
    }).timeout(
      const Duration(minutes: 2),
      onTimeout: () {
        setState(() {
          _loading = false;
          _loadingSmall = false;
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
    await SessionService().getAllSessionsNotStart().then((value) {
      setState(() {
        _loading = false;
        _loadingSmall = false;
        listAllSessions = List.from(listAllSessions)..addAll(value);
      });
      return value;
    }).timeout(
      const Duration(minutes: 4),
      onTimeout: () {
        setState(() {
          _loading = false;
          _loadingSmall = false;
          listAllSessions = [];
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
    await SessionService().getAllSessionsInStage().then((value) {
      setState(() {
        _loading = false;
        _loadingSmall = false;
        listAllSessions = List.from(listAllSessions)..addAll(value);
      });
      return value;
    }).timeout(
      const Duration(minutes: 4),
      onTimeout: () {
        setState(() {
          _loading = false;
          _loadingSmall = false;
          listAllSessions = [];
        });
        return alert.showAlertDialog(context, "Lỗi Kết Nối",
            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
      },
    );
    setState(() {
      _loading = false;
      listSessions = listAllSessions;
    });
  }

  Widget isLoadingSmall() {
    return Center(
      child: loadingProcess(context, stateLoading, kLoadingRes, false),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = sizeInit(context);
    List<CategoryProduct>? category = listCategory;
    return _loading && !_loadingSmall
        ? Scaffold(
            body: loadingProcess(context, stateLoading, kLoadingRes, true),
          )
        : Scaffold(
            backgroundColor: const Color.fromARGB(255, 238, 238, 238),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: RefreshIndicator(
                backgroundColor: Colors.white,
                // strokeWidth: 0,
                onRefresh: () async {
                  setState(() {
                    _loadingSmall = true;
                    stateLoading = loadingHomeState;
                    checkIncomming = false;
                    checkIsgoing = false;
                    loadingSession();
                  });
                  // await loadingResources();
                  return;
                },
                color: kPrimaryColor,
                child: Container(
                  height: sizeInit(context).height,
                  width: sizeInit(context).width,
                  child: SingleChildScrollView(
                    physics: _loadingSmall
                        ? const NeverScrollableScrollPhysics()
                        : const AlwaysScrollableScrollPhysics(),
                    child:
                        // Column(
                        //   children: [
                        Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //header
                              HomeHeader(
                                size: size,
                                userProfile: userProfile,
                              ),
                              SizedBox(
                                height: (20 / 812.0) * sizeInit(context).height,
                                child: Container(color: Colors.white),
                              ),
                              //search bar
                              // a.SearchBar(size: size),
                              SearchBar(),
                              SizedBox(
                                height: (20 / 812.0) * sizeInit(context).height,
                                child: Container(color: Colors.white),
                              ),
                              //category bar
                              // categoryBar(size: size, category: category!),
                              categoryBar(),
                              //select type session
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        checkIncomming = true;
                                        checkIsgoing = false;
                                        selectedIndex = 100;
                                        listSessions = listAllSessions
                                            .where((element) =>
                                                element.status == 1)
                                            .toList();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.album,
                                      color: checkIncomming
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          checkIncomming
                                              ? kPrimaryColor
                                              : Colors.white),
                                    ),
                                    label: Text(
                                      'Sắp diễn ra',
                                      style: GoogleFonts.workSans(
                                          color: checkIncomming
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        checkIncomming = false;
                                        checkIsgoing = true;
                                        selectedIndex = 100;
                                        listSessions = listAllSessions
                                            .where((element) =>
                                                element.status == 2)
                                            .toList();
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          checkIsgoing
                                              ? kPrimaryColor
                                              : Colors.white),
                                    ),
                                    icon: Icon(
                                      Icons.album,
                                      color: checkIsgoing
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                    label: Text(
                                      'Đang diễn ra',
                                      style: GoogleFonts.workSans(
                                          color: checkIsgoing
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                              //danh sách session
                              listAllSessions.isNotEmpty
                                  ? SessionList(session: listSessions!)
                                  : Container(
                                      height: sizeInit(context).height * 0.40,
                                      child: Center(
                                        child: Text(
                                          'Hiện tại không có phiên đấu giá',
                                          style: GoogleFonts.workSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        _loadingSmall
                            ? Center(
                                child: loadingProcess(
                                    context, loadingHomeState, kLoading, false),
                              )
                            : const SizedBox(height: 0),
                      ],
                    ),
                    // ],
                  ),
                ),
              ),
            ),
            // ),
            //   ),
            // ),
          );
  }

  Widget SearchBar() {
    final Size size = sizeInit(context);
    return Container(
      height: size.height / 15,
      // width: sizeInit(context).width,
      color: Colors.white,
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      checkIncomming = false;
                      checkIsgoing = false;
                      selectedIndex = 100;
                      listSessions = listAllSessions
                          .where((element) => element.sessionName
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Tìm kiếm sản phẩm',
                    hintStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search, color: kPrimaryColor),
                    contentPadding: const EdgeInsets.symmetric(vertical: 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 2.0),
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: IconButton(
                    onPressed: () {
                      // TODO: Handle icon button press
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ), // Biểu tượng "check"
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryBar() {
    final Size size = sizeInit(context);
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: size.height / 15,
          child: listCategory!.isEmpty
              ? const CircularProgressIndicator(
                  color: kPrimaryColor,
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listCategory!.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          HomePage.categoryString =
                              listCategory![index].categoryName;
                          listSessions = listAllSessions
                              .where((element) =>
                                  element.categoryName.toLowerCase() ==
                                  listCategory![index]
                                      .categoryName
                                      .toLowerCase())
                              .toList();
                          if (index == 0) {
                            listSessions = listAllSessions;
                            checkIncomming = false;
                            checkIsgoing = false;
                          }
                        });
                      },
                      child: Container(
                        width: size.width / 3,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 16),
                        decoration: selectedIndex == index
                            ? BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(12))
                            : BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.deepOrange)),
                        child: selectedIndex == index
                            ? Text(
                                listCategory![index].categoryName,
                                style: GoogleFonts.workSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                listCategory![index].categoryName,
                                style: GoogleFonts.workSans(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                      ),
                    );
                  }),
                ),
        ),
        SizedBox(
          height: (20 / 812.0) * sizeInit(context).height,
          child: Container(color: Colors.white),
        ),
        Container(
          color: Colors.white,
          height: (50 / 812.0) * sizeInit(context).height,
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
              Text(
                HomePage.categoryString == null || selectedIndex == 0
                    ? "Danh sách các phiên"
                    : "Danh sách ${HomePage.categoryString!.toLowerCase()}",
                style: GoogleFonts.workSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
