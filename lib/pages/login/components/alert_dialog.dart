import 'package:bid_online_app_v2/pages/forgot_password/components/forgot_password_form.dart';
import 'package:bid_online_app_v2/pages/forgot_password/forgot_password.dart';
import 'package:bid_online_app_v2/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlertDialogMessage {
  dynamic showAlertDialog(BuildContext context, String title, String content) {
    // Create button
    Widget okButton = TextButton(
      child: Text("Đóng"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  dynamic showAlertConnection(
      BuildContext context, String title, String content) {
    // Create button
    Widget okButton = TextButton(
      child: Text("Đóng"),
      onPressed: () {
        SystemNavigator.pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  dynamic showAlertDialogWithReplaceRoute(
      BuildContext context, String title, String content, String route) {
    // Create button
    Widget okButton = TextButton(
      child: const Text("Đóng"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage()),
          (Route<dynamic> route) => false,
        );
        // Navigator.pushReplacementNamed(context, route);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
