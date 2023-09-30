import 'dart:convert';

import 'package:bid_online_app_v2/components/default_button.dart';
import 'package:bid_online_app_v2/components/loading_process.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/keyboard.dart';
import 'package:bid_online_app_v2/models/UserSignUp.dart';
import 'package:bid_online_app_v2/pages/login/components/alert_dialog.dart';
import 'package:bid_online_app_v2/pages/login/login_page.dart';
import 'package:bid_online_app_v2/pages/register_user/components/build_Address_Field.dart';
import 'package:bid_online_app_v2/pages/register_user/components/build_CCCD_Form_Field.dart';
import 'package:bid_online_app_v2/pages/register_user/components/build_DoB_Form_Field.dart';
import 'package:bid_online_app_v2/pages/register_user/components/build_Email_Form_Field.dart';
import 'package:bid_online_app_v2/pages/register_user/components/build_Name_Form_Field.dart';
import 'package:bid_online_app_v2/pages/register_user/components/build_Password_Conform_Form_Field.dart';
import 'package:bid_online_app_v2/pages/register_user/components/build_Password_Form_Field.dart';
import 'package:bid_online_app_v2/pages/register_user/components/build_Payment_Field.dart';
import 'package:bid_online_app_v2/pages/register_user/components/build_Phone_Number_Form_Field.dart';
import 'package:bid_online_app_v2/pages/register_user/components/build_images_upload.dart';
import 'package:bid_online_app_v2/pages/register_user/components/register_form.dart';
import 'package:bid_online_app_v2/services/firebase_service.dart';
import 'package:bid_online_app_v2/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterAccountPage extends StatefulWidget {
  static String routeName = "/register_account";
  static TextEditingController emailEditingController = TextEditingController();
  const RegisterAccountPage({super.key});

  @override
  State<RegisterAccountPage> createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {
  final _formkey = GlobalKey<FormState>();
  late bool loading = false;
  late bool isSuccess = true;
  late bool isVerify = false;
  late bool isVerifyFail = false;
  late bool isVerifyLoading = false;
  late bool getVerify = false, isClickVerify = false;
  List<String> errors = [];
  AlertDialogMessage alert = AlertDialogMessage();

  @override
  void dispose() {
    RegisterAccountForm.frontImage = null;
    RegisterAccountForm.backImage = null;
    RegisterAccountForm.avatarImage = null;
    RegisterAccountForm.loadingFrontImg = false;
    RegisterAccountForm.loadingBackImg = false;
    RegisterAccountForm.loadingAvatarImg = false;
    RegisterAccountPage.emailEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    RegisterAccountPage.emailEditingController = TextEditingController();
    setState(() {
      isVerify = false;
    });
    super.initState();
  }

  Future<void> _showInputDialog(BuildContext context) async {
    String enteredValue = ""; // Biến để lưu giá trị nhập vào TextField

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Mã xác thực (vui lòng kiểm tra email)',
                style: TextStyle(fontSize: 12)),
            content: TextField(
              onChanged: (value) {
                enteredValue = value;
              },
              decoration: const InputDecoration(
                hintText: 'OTP',
              ),
            ),
            actions: <Widget>[
              isVerifyLoading
                  ? const SizedBox(height: 0)
                  : TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Hủy'),
                    ),
              isVerifyLoading
                  ? const CircularProgressIndicator(color: kPrimaryColor)
                  : TextButton(
                      onPressed: () async {
                        setState(() {
                          isVerifyLoading = true;
                        });
                        await UserService()
                            .updateRoleUser(
                                InputEmail.emailEditingController.text,
                                enteredValue)
                            .then((value) {
                          if (value.body == 'true') {
                            setState(() {
                              getVerify = true;
                              isClickVerify = true;
                              isVerify = true;
                              isVerifyFail = false;
                            });
                          } else {
                            setState(() {
                              getVerify = true;
                              isClickVerify = true;
                              isVerifyFail = true;
                              isVerify = false;
                            });
                          }
                        });
                        setState(() {
                          isVerifyLoading = false;
                        });

                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
            ],
          );
        });
  }

  Widget verificationButton() {
    return isVerifyLoading
        ? const CircularProgressIndicator(color: kPrimaryColor)
        : ElevatedButton(
            onPressed: () async {
              if (InputEmail.emailEditingController.text.isEmpty) {
                alert.showAlertDialog(
                    context, "Thất bại", "Bạn chưa nhập email");
              } else {
                setState(() {
                  isVerifyLoading = true;
                });
                await UserService()
                    .confirmEmail(InputEmail.emailEditingController.text);
                setState(() {
                  isVerifyLoading = false;
                });
                _showInputDialog(context);
              }
            },
            child: const Text(
              'Xác thực email',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          );
  }

  Widget registerForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          const InputName(),
          SizedBox(height: (40 / 812.0) * sizeInit(context).height),
          emailInput(),
          isVerify
              ? const SizedBox(height: 0)
              : SizedBox(height: (30 / 812.0) * sizeInit(context).height),
          isVerify ? const SizedBox(height: 0) : verificationButton(),
          (getVerify && isClickVerify && isVerify)
              ? const Text("Xác thực thành công\nXin mời bạn tiếp tục đăng ký",
                  style: TextStyle(color: Colors.green),
                  textAlign: TextAlign.center)
              : const SizedBox(height: 0),
          (getVerify && isClickVerify && isVerifyFail)
              ? const Text("Xác thực thất bại\n Xin mời bạn thử lại",
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center)
              : const SizedBox(height: 0),
          !isVerify
              ? const SizedBox(height: 0)
              : SizedBox(height: (30 / 812.0) * sizeInit(context).height),
          !isVerify ? const SizedBox(height: 0) : const InputPassword(),
          !isVerify
              ? const SizedBox(height: 0)
              : SizedBox(height: (30 / 812.0) * sizeInit(context).height),
          !isVerify ? const SizedBox(height: 0) : const InpputConformPassword(),
          !isVerify
              ? const SizedBox(height: 0)
              : SizedBox(height: (40 / 812.0) * sizeInit(context).height),
          !isVerify ? const SizedBox(height: 0) : const InputAddress(),
          !isVerify
              ? const SizedBox(height: 0)
              : SizedBox(height: (40 / 812.0) * sizeInit(context).height),
          !isVerify ? const SizedBox(height: 0) : const InputCccd(),
          !isVerify
              ? const SizedBox(height: 0)
              : SizedBox(height: (40 / 812.0) * sizeInit(context).height),
          !isVerify ? const SizedBox(height: 0) : const InputDob(),
          !isVerify
              ? const SizedBox(height: 0)
              : SizedBox(height: (40 / 812.0) * sizeInit(context).height),
          !isVerify ? const SizedBox(height: 0) : const InputPhoneNumber(),
          !isVerify
              ? const SizedBox(height: 0)
              : SizedBox(height: (40 / 812.0) * sizeInit(context).height),
          !isVerify ? const SizedBox(height: 0) : const InputPayPal(),
          !isVerify
              ? const SizedBox(height: 0)
              : SizedBox(height: (40 / 812.0) * sizeInit(context).height),
          !isVerify ? const SizedBox(height: 0) : const UploadImage(),
          !isVerify
              ? const SizedBox(height: 0)
              : SizedBox(height: (40 / 812.0) * sizeInit(context).height),
          !isVerify
              ? const SizedBox(height: 0)
              : DefaultButton(
                  text: "Đăng Ký",
                  press: () async {
                    if (RegisterAccountForm.avatarImage == null ||
                        RegisterAccountForm.frontImage == null ||
                        RegisterAccountForm.backImage == null) {
                      alert.showAlertDialog(context, "Thất bại",
                          "Bạn chưa cung cấp đủ hình ảnh\nMời bạn kiểm tra và bổ sung");
                    } else if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      // Navigator.pushNamed(context, CompleteProfileScreen.routeName);

                      setState(() {
                        loading = true;
                      });
                      await FirebaseService()
                          .uploadImageToFirebase(
                              RegisterAccountForm.frontImage!,
                              InputEmail.emailEditingController.text,
                              "front")
                          .then((value) =>
                              RegisterAccountForm.frontImageLink = value)
                          .timeout(
                        const Duration(minutes: 3),
                        onTimeout: () {
                          return alert.showAlertDialog(context, "Thất bại",
                              "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
                        },
                      );
                      await FirebaseService()
                          .uploadImageToFirebase(RegisterAccountForm.backImage!,
                              InputEmail.emailEditingController.text, "back")
                          .then((value) =>
                              RegisterAccountForm.backImageLink = value)
                          .timeout(
                        const Duration(minutes: 1),
                        onTimeout: () {
                          return alert.showAlertDialog(context, "Thất bại",
                              "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
                        },
                      );
                      await FirebaseService()
                          .uploadImageToFirebase(
                              RegisterAccountForm.avatarImage!,
                              InputEmail.emailEditingController.text,
                              "avatar")
                          .then((value) =>
                              RegisterAccountForm.avatarImageLink = value)
                          .timeout(
                        const Duration(minutes: 1),
                        onTimeout: () {
                          return alert.showAlertDialog(context, "Thất bại",
                              "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
                        },
                      );
                      String uid = "";
                      UserSignUp user = UserSignUp(
                          userName: InputName.nameEditingController.text,
                          email: InputEmail.emailEditingController.text,
                          avatar: RegisterAccountForm.avatarImageLink!,
                          password:
                              InputPassword.passwordEditingController.text,
                          address: InputAddress.addressEditingController.text,
                          phone: InputPhoneNumber.phoneEditingController.text,
                          dateOfBirth: DateFormat("dd-mm-yyyy")
                              .parse(InputDob.dateController.text),
                          cccdnumber: InputCccd.cccdEditingController.text,
                          cccdfrontImage: RegisterAccountForm.frontImageLink!,
                          cccdbackImage: RegisterAccountForm.backImageLink!);
                      await UserService().signUpAccount(user).then((value) {
                        if (value.statusCode == 200) {
                          setState(() {
                            print(
                                'Status: ${jsonDecode(value.body)['userId']}');
                            uid = jsonDecode(value.body)['userId'];
                            isSuccess = true;
                            alert.showAlertDialogWithReplaceRoute(
                                context,
                                "Thành Công",
                                "Bạn đã đăng ký thành công tài khoản\nChúng tôi sẽ duyệt và phản hồi lại vào email mà bạn đã đăng ký trong 48h",
                                LoginPage.routeName);
                          });
                        } else {
                          FirebaseService().deleteFile(
                              InputEmail.emailEditingController.text);
                          alert.showAlertDialog(
                              context, "Đăng Ký thất bại", value.body);
                        }
                      }).timeout(
                        const Duration(seconds: 30),
                        onTimeout: () {
                          return alert.showAlertDialog(context, "Thất bại",
                              "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
                        },
                      );
                      if (isSuccess) {
                        await UserService().signUpPayment(
                            uid, InputPayPal.payPalEditingController.text);
                      }
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
        ],
      ),
    );
  }

  Widget emailInput() {
    return TextFormField(
      controller: InputEmail.emailEditingController,
      keyboardType: TextInputType.emailAddress,
      enabled: (getVerify && isClickVerify && isVerify) ? false : true,
      onSaved: (newValue) {
        setState(() {
          // EmailInput.textEditingController.text = newValue!;
        });
      },
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Ẩn bàn phím khi người dùng chạm vào ngoài
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Đăng Ký Tài khoản"),
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: (20 / 375.0) * sizeInit(context).width),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: sizeInit(context).height * 0.04), // 4%
                        Text(
                          "Đăng Ký Tài khoản",
                          style: TextStyle(
                            fontSize: (28 / 375.0) * sizeInit(context).width,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: sizeInit(context).height * 0.08),
                        registerForm(),
                        SizedBox(height: sizeInit(context).height * 0.08),
                        SizedBox(
                            height: (20 / 812.0) * sizeInit(context).height),
                      ],
                    ),
                  ),
                  loading
                      ? Center(
                          child: loadingProcess(
                              context, "Đang xử lí", kLoading, false),
                        )
                      : const SizedBox(height: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
