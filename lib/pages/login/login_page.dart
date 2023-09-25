import 'package:bid_online_app_v2/components/default_button.dart';
import 'package:bid_online_app_v2/components/loading_process.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/keyboard.dart';
import 'package:bid_online_app_v2/main/MainState.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:bid_online_app_v2/pages/login/components/alert_dialog.dart';
import 'package:bid_online_app_v2/pages/login/components/no_account.dart';
import 'package:bid_online_app_v2/pages/login/components/remember_me.dart';
import 'package:bid_online_app_v2/pages/login/services/auth_service.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:signalr_netcore/signalr_client.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String routeName = "/login";
  static bool isLogin = false;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  late String email;
  late String password;
  late bool _connectionStatus = false;
  late bool remember = false;
  bool _isPasswordVisible = true;
  final List<String> errors = [];
  AlertDialogMessage alert = AlertDialogMessage();
  HubConnection? _hubConnection;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    // Lắng nghe sự thay đổi kết nối internet
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = _getStatusString(result);
      });
    });
  }

  void _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectionStatus = _getStatusString(connectivityResult);
    });
  }

  bool _getStatusString(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.none:
        return false;
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.mobile:
        return true;
      default:
        return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = _getStatusString(result);
      });
    });
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        // ),
        body: !_connectionStatus
            ? const Center(
                child: alertConnecrion(),
              )
            : Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    (20 / 375.0) * sizeInit(context).width),
                            child: Column(
                              children: [
                                Text(
                                  "Đăng Nhập",
                                  style: GoogleFonts.sansita(
                                      color: Colors.black,
                                      fontSize: (28 / 375.0) *
                                          sizeInit(context).width,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Đăng nhập bằng email và password của bạn\n ở phía dưới.",
                                  style: GoogleFonts.sansita(
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: sizeInit(context).height / 20),
                                // const SignInForm(),
                                Form(
                                  key: _formkey,
                                  child: Column(
                                    children: <Widget>[
                                      buildEmailFormField(),
                                      SizedBox(
                                          height: (20 / 812.0) *
                                              sizeInit(context).height),
                                      buildPasswordFormField(),
                                      SizedBox(
                                          height: (15 / 812.0) *
                                              sizeInit(context).height),
                                      const RememberAccount(),
                                      DefaultButton(
                                          text: "Đăng Nhập", press: pressLogin),
                                    ],
                                  ),
                                ),
                                SizedBox(height: sizeInit(context).height / 20),
                                const NoAccountText(),
                                SizedBox(height: sizeInit(context).height / 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  LoginPage.isLogin
                      ? Center(
                          child: loadingProcess(
                              context, loadingLoginState, kLoading, false),
                        )
                      : const SizedBox(height: 0),
                ],
              ),
      ),
    );
  }

  void pressLogin() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);

      setState(() {
        LoginPage.isLogin = true;
      });
      await TokenProvider().getToken(email, password).whenComplete(() {
        setState(() {
          LoginPage.isLogin = false;
        });
      }).then((value) async {
        if (value.error != null) {
          setState(() {
            LoginPage.isLogin = false;
            alert.showAlertDialog(context, "Thất Bại", value.error!);
          });
          return value;
        }
        String role = JwtDecoder.decode(TokenManager.getToken()!)['role'];
        if (role == 'Admin') {}
        if (role == 'Admin' || role == 'Staff') {
          FocusScope.of(context).requestFocus(focusNode);
          setState(() {
            LoginPage.isLogin = false;
            alert.showAlertDialog(context, "Thất Bại",
                "Tài khoản này không được cấp quyền vào ứng dụng");
          });
        } else {
          TokenManager.setToken(value.token!);
          Navigator.of(context).pushReplacementNamed(MainStateScreen.routeName);
        }
        return value;
      }).timeout(
        const Duration(minutes: 1),
        onTimeout: () {
          setState(() {
            LoginPage.isLogin = false;
          });
          return alert.showAlertDialog(context, "Lỗi Kết Nối",
              "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
        },
      );
    }
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _isPasswordVisible,
      initialValue: "05072001",
      onSaved: (newValue) => password = newValue!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(passNullError)
                ? errors.add(passNullError)
                : errors.remove(passNullError);
          });
          return passNullError;
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Mật khẩu",
          hintText: "Nhập mật khẩu của bạn",
          suffixIcon: IconButton(
            icon: Icon(_isPasswordVisible
                ? Icons.lock_outline
                : Icons.remove_red_eye_outlined),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      // controller: emailTextController,
      initialValue: "vanquyen.bt2@gmail.com",
      focusNode: focusNode,
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            !errors.contains(emailNullError)
                ? errors.add(emailNullError)
                : errors.remove(emailNullError);
          });
          return emailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value) && value.isNotEmpty) {
          setState(() {
            !errors.contains(invalidEmailError)
                ? errors.add(invalidEmailError)
                : errors.remove(invalidEmailError);
          });
          return invalidEmailError;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Email",
          hintText: "Nhập email của bạn",
          suffixIcon: Icon(Icons.mail_outline_outlined)),
    );
  }
}

class alertConnecrion extends StatelessWidget {
  const alertConnecrion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Lỗi kết nối'),
      content: const Text(
          'Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.'),
      actions: [
        TextButton(
          child: Text("Đóng"),
          onPressed: () {
            SystemNavigator.pop();
          },
        )
      ],
    );
  }
}
