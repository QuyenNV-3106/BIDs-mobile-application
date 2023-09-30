import 'dart:io';

import 'package:bid_online_app_v2/components/default_button.dart';
import 'package:bid_online_app_v2/components/loading_process.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/pages/login/components/alert_dialog.dart';
import 'package:bid_online_app_v2/pages/setting/Components/build_Address_Field.dart';
import 'package:bid_online_app_v2/pages/setting/Components/build_Name_Form_Field.dart';
import 'package:bid_online_app_v2/pages/setting/Components/build_Password_Conform_Form_Field.dart';
import 'package:bid_online_app_v2/pages/setting/Components/build_Password_Form_Field.dart';
import 'package:bid_online_app_v2/pages/setting/Components/build_Phone_Number_Form_Field.dart';
import 'package:bid_online_app_v2/services/firebase_service.dart';
import 'package:bid_online_app_v2/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserProfilePage extends StatefulWidget {
  static String routeName = "/user-profile";
  const UserProfilePage({super.key});

  static XFile? avatarImage;
  static bool loadingAvatarImg = false;
  static String? avatarImageLink;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formkey = GlobalKey<FormState>();
  late bool loading = false;
  late bool isSuccess = true;
  late bool isUpdate = false;
  AlertDialogMessage alert = AlertDialogMessage();
  File? _pickedImage;
  XFile? imageUpdate;
  UserProfile? userState = UserProfile.user;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 450,
        maxWidth: 450);

    if (pickedImage != null) {
      int fileSize = await pickedImage.length();
      bool checkSize = fileSize <= 10 * 1024 * 1024;
      setState(() {
        if (checkSize) {
          _pickedImage = File(pickedImage.path);
          imageUpdate = pickedImage;
        } else {
          alert.showAlertDialog(
              context, "Thất bại", "Kích thước ảnh không được vượt quá 10MB");
        }
      });
    }
  }

  Widget avatarProfile() {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: _pickedImage != null
                ? Image.file(
                    File(_pickedImage!.path),
                  ).image
                : Image.network(
                    UserProfile.avatarSt!,
                    fit: BoxFit.fitWidth,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null ? child : Image.asset(noImage),
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset(noImage),
                  ).image,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.red),
                  ),
                  primary: Colors.white,
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  _pickImage();
                },
                child: const Icon(Icons.camera_alt_outlined),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    userState = UserProfile.user;
    super.initState();
  }

  @override
  void dispose() {
    UserProfilePage.avatarImage = null;
    UserProfilePage.loadingAvatarImg = false;
    super.dispose();
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
          title: const Text("Tài Khoản"),
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
                    // child: updateProfileForm(context),
                    child: isUpdate
                        ? updateProfileForm(context)
                        : profileUser(context),
                  ),
                  loading
                      ? Center(
                          child: loadingProcess(
                              context, 'Đang xử lý...', kLoading, false),
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

  Form updateProfileForm(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          SizedBox(height: sizeInit(context).height * 0.04), // 4%
          avatarProfile(),
          SizedBox(height: sizeInit(context).height * 0.08),
          const InputName(),
          SizedBox(height: (30 / 812.0) * sizeInit(context).height),
          const InputPassword(),
          SizedBox(height: (30 / 812.0) * sizeInit(context).height),
          const InpputConformPassword(),
          SizedBox(height: (30 / 812.0) * sizeInit(context).height),
          const InputAddress(),
          SizedBox(height: (30 / 812.0) * sizeInit(context).height),
          const InputPhoneNumber(),
          SizedBox(height: (30 / 812.0) * sizeInit(context).height),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isUpdate = false;
                  });
                },
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(Colors.red),
                    fixedSize: MaterialStatePropertyAll(
                        Size.fromWidth(sizeInit(context).width / 3))),
                child: const Center(
                  child: Text('Hủy'),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    // Navigator.pushNamed(context, CompleteProfileScreen.routeName);

                    setState(() {
                      loading = true;
                    });

                    imageUpdate == null
                        ? null
                        : await FirebaseService()
                            .uploadImageToFirebase(imageUpdate!,
                                UserProfile.user!.email!, "avatar")
                            .then((value) =>
                                UserProfilePage.avatarImageLink = value)
                            .timeout(
                            const Duration(minutes: 1),
                            onTimeout: () {
                              return alert.showAlertDialog(context, "Thất bại",
                                  "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
                            },
                          );
                    UserProfile user = UserProfile(
                        userId: UserProfile.user!.userId,
                        email: UserProfile.emailSt,
                        userName: InputName.nameEditingController.text,
                        avatar: UserProfilePage.avatarImageLink ??
                            UserProfile.avatarSt,
                        password: InputPassword.passwordEditingController.text,
                        address: InputAddress.addressEditingController.text,
                        phone: InputPhoneNumber.phoneEditingController.text,
                        role: UserProfile.user!.role,
                        dateOfBirth: UserProfile.user!.dateOfBirth);
                    await UserService().updateAccount(user).then((value) {
                      if (value.statusCode == 200) {
                        setState(() {
                          isSuccess = true;
                          UserProfile.user = user;
                          userState = user;
                          // UserProfile.emailSt = user.email;
                          // UserProfile.avatarSt = user.avatar;

                          alert.showAlertDialog(context, "Thành Công",
                              "Bạn đã cập nhật thông tin cá nhân thành công");
                          Navigator.pop(context);
                        });
                      } else {
                        imageUpdate == null
                            ? null
                            : FirebaseService()
                                .deleteFileWhenUpdate(UserProfile.emailSt!);
                        alert.showAlertDialog(
                            context, "Cập nhật thất bại", value.body);
                      }
                    }).timeout(
                      const Duration(seconds: 30),
                      onTimeout: () {
                        return alert.showAlertDialog(context, "Thất bại",
                            "Kết nối của bạn không ổn định\nXin hãy kiểm tra lại mạng wifi/4G của bạn.");
                      },
                    );
                    setState(() {
                      loading = false;
                      isUpdate = false;
                    });
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(kPrimaryColor),
                    fixedSize: MaterialStatePropertyAll(
                        Size.fromWidth(sizeInit(context).width / 3))),
                child: const Center(
                  child: Text('Cập nhật'),
                ),
              ),
            ],
          ),

          SizedBox(height: sizeInit(context).height * 0.08),
          SizedBox(height: (20 / 812.0) * sizeInit(context).height),
        ],
      ),
    );
  }

  Center profileUser(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundImage: Image.network(
              userState!.avatar!,
              fit: BoxFit.fitWidth,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null ? child : Image.asset(noImage),
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset(noImage),
            ).image,
          ),
          const SizedBox(height: 20),
          Text(
            UserProfile.user!.userName!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(userState!.email!),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(userState!.phone!),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(userState!.address!),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: Text(DateFormat('dd-MM-yyyy')
                .format(userState!.dateOfBirth!)
                .toString()),
          ),
          ListTile(
            leading: const Icon(Icons.paypal_outlined),
            title: userState!.payPalAccount!.firstOrNull == null
                ? const Text('Không có tài khoản PayPal')
                : const Text('Không có tài khoản PayPal'),
          ),
          ListTile(
            leading: const Icon(Icons.business_center),
            title: Text(userState!.role! == 'Bidder'
                ? 'Bạn có thể tham gia đấu giá'
                : 'Bạn có thể đấu giá và đăng bán'),
          ),
          DefaultButton(
            text: 'Cập nhật',
            press: () {
              setState(() {
                isUpdate = true;
              });
            },
          )
        ],
      ),
    );
  }
}
