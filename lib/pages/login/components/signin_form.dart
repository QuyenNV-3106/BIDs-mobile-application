import 'package:bid_online_app_v2/components/default_button.dart';
import 'package:bid_online_app_v2/components/loading_process.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/keyboard.dart';
import 'package:bid_online_app_v2/main/MainState.dart';
import 'package:bid_online_app_v2/models/TokenManager.dart';
import 'package:bid_online_app_v2/models/token.dart';
import 'package:bid_online_app_v2/pages/login/components/alert_dialog.dart';
import 'package:bid_online_app_v2/pages/login/components/remember_me.dart';
import 'package:bid_online_app_v2/pages/login/login_page.dart';
import 'package:bid_online_app_v2/pages/login/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formkey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  late String email;
  late String password;
  late bool remember = false;
  bool _isPasswordVisible = true;
  final List<String> errors = [];
  Future<Token>? _futureToken;
  AlertDialogMessage alert = AlertDialogMessage();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          buildEmailFormField(),
          SizedBox(height: (20 / 812.0) * sizeInit(context).height),
          buildPasswordFormField(),
          SizedBox(height: (15 / 812.0) * sizeInit(context).height),
          const RememberAccount(),
          DefaultButton(text: "Đăng Nhập", press: pressLogin),
        ],
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
        }
        // else if (role != 'Admin' && role != 'Staff') {
        //   // FocusScope.of(context).requestFocus(focusNode);
        //   String status = '';
        //   await UserService()
        //       .getUser(UserProfile.emailSt!)
        //       .then((value) => status = value.status!);
        //   if (status == 'Waitting') {
        //     setState(() {
        //       LoginPage.isLogin = false;
        //       alert.showAlertDialog(context, "Thất Bại",
        //           "Tài khoản của bạn đang đợi duyệt.\nChúng tôi sẽ thông báo kết quả cho bạn qua email đã đăng ký trong vòng 48 tiếng");
        //     });
        //   }
        // }
        else {
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
