import 'package:bid_online_app_v2/components/default_button.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/keyboard.dart';
import 'package:bid_online_app_v2/pages/login/components/alert_dialog.dart';
import 'package:bid_online_app_v2/pages/login/login_page.dart';
import 'package:bid_online_app_v2/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final focusNode = FocusNode();
  Future<Response>? resp;
  bool loading = false;
  AlertDialogMessage alert = AlertDialogMessage();
  String? email;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: (20 / 812.0) * sizeInit(context).height),
          loading
              ? spinkit
              : DefaultButton(text: "Lấy lại mật khẩu", press: pressReset),
        ],
      ),
    );
  }

  void pressReset() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);
      setState(() => loading = true);

      await UserService().resetPassword(email!).whenComplete(() {
        setState(() {
          loading = false;
        });
      }).then((value) {
        if (value.body == "Người dùng không tồn tại") {
          setState(() {
            loading = false;
            alert.showAlertDialog(context, "Thất Bại",
                "Email bạn đã nhập không tồn tại trong hệ thống");
            FocusScope.of(context).requestFocus(focusNode);
          });
        } else {
          alert.showAlertDialogWithReplaceRoute(
              context,
              "Thành công",
              "Mật khẩu mới của bạn đã được gửi tới email",
              LoginPage.routeName);
        }
        return value;
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
      setState(() => loading = false);
    }
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
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
