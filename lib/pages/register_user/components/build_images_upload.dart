import 'dart:io';

import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/pages/login/components/alert_dialog.dart';
import 'package:bid_online_app_v2/pages/register_user/components/register_form.dart';
// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  ImagePicker _imagePicker = ImagePicker();

  Widget frontImage() {
    return Image.file(
      File(RegisterAccountForm.frontImage!.path),
      height: 200,
    );
  }

  Widget avatarImage() {
    return Image.file(
      File(RegisterAccountForm.avatarImage!.path),
      height: 200,
    );
  }

  Widget backImage() {
    return Image.file(
      File(RegisterAccountForm.backImage!.path),
      height: 200,
    );
  }

  Future<void> _captureImage(bool? isFrontImage, bool isAvatarImage) async {
    setState(() {
      if (isFrontImage != null) {
        if (isFrontImage) {
          RegisterAccountForm.loadingFrontImg = true;
        } else if (!isFrontImage) {
          RegisterAccountForm.loadingBackImg = true;
        }
      } else if (isAvatarImage) {
        RegisterAccountForm.loadingAvatarImg = true;
      }
    });
    final XFile? image;
    if (isFrontImage != null) {
      image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );
    } else {
      image = await _imagePicker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front,
          imageQuality: 100,
          maxHeight: 450,
          maxWidth: 450);
    }

    AlertDialogMessage alertDialogMessage = AlertDialogMessage();
    if (image == null) {
      setState(() {
        if (isFrontImage != null) {
          if (isFrontImage) {
            RegisterAccountForm.loadingFrontImg = false;
          } else if (!isFrontImage) {
            RegisterAccountForm.loadingBackImg = false;
          }
        } else if (isAvatarImage) {
          RegisterAccountForm.loadingAvatarImg = false;
        }
      });
      return;
    }
    int fileSize = await image.length();
    bool checkSize = fileSize <= 10 * 1024 * 1024;

    setState(() {
      if (isFrontImage != null) {
        if (isFrontImage) {
          RegisterAccountForm.loadingFrontImg = false;
          if (checkSize) {
            RegisterAccountForm.frontImage = image;
          } else {
            alertDialogMessage.showAlertDialog(
                context, "Thất bại", "Kích thước ảnh không được vượt quá 10MB");
          }
        } else if (!isFrontImage) {
          RegisterAccountForm.loadingBackImg = false;
          if (checkSize) {
            RegisterAccountForm.backImage = image;
          } else {
            alertDialogMessage.showAlertDialog(
                context, "Thất bại", "Kích thước ảnh không được vượt quá 10MB");
          }
        }
      } else if (isAvatarImage) {
        RegisterAccountForm.loadingAvatarImg = false;
        if (checkSize) {
          RegisterAccountForm.avatarImage = image;
        } else {
          alertDialogMessage.showAlertDialog(
              context, "Thất bại", "Kích thước ảnh không được vượt quá 10MB");
        }
      }
    });
  }

  Widget buildFrontImageField() {
    return RegisterAccountForm.loadingFrontImg
        ? const CircularProgressIndicator(color: kPrimaryColor)
        : ElevatedButton.icon(
            onPressed: () {
              _captureImage(true, false);
            },
            icon: const Icon(
              Icons.cloud_upload_outlined,
              size: 24.0,
              color: Colors.white,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
            ),
            label: const Text(
              'Chụp CCCD mặt trước',
              textAlign: TextAlign.center,
            ),
          );
  }

  Widget buildBackImageField() {
    return RegisterAccountForm.loadingBackImg
        ? const CircularProgressIndicator(color: kPrimaryColor)
        : ElevatedButton.icon(
            onPressed: () {
              _captureImage(false, false);
            },
            icon: const Icon(
              Icons.cloud_upload_outlined,
              size: 24.0,
              color: Colors.white,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
            ),
            label: const Text(
              'Chụp CCCD mặt sau',
              textAlign: TextAlign.center,
            ),
          );
  }

  Widget buildAvatarImageField() {
    return RegisterAccountForm.loadingAvatarImg
        ? const CircularProgressIndicator(color: kPrimaryColor)
        : ElevatedButton.icon(
            onPressed: () {
              _captureImage(null, true);
            },
            icon: const Icon(
              Icons.cloud_upload_outlined,
              size: 24.0,
              color: Colors.white,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
            ),
            label: const Text(
              'Chụp khuôn mặt của bạn',
              textAlign: TextAlign.center,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            if (RegisterAccountForm.avatarImage != null) avatarImage(),
            if (RegisterAccountForm.avatarImage != null)
              SizedBox(height: (10 / 812.0) * sizeInit(context).height),
            buildAvatarImageField(),
          ],
        ),
        SizedBox(height: (40 / 812.0) * sizeInit(context).height),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  if (RegisterAccountForm.frontImage != null) frontImage(),
                  if (RegisterAccountForm.frontImage != null)
                    SizedBox(height: (10 / 812.0) * sizeInit(context).height),
                  buildFrontImageField(),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  if (RegisterAccountForm.backImage != null) backImage(),
                  if (RegisterAccountForm.backImage != null)
                    SizedBox(height: (10 / 812.0) * sizeInit(context).height),
                  buildBackImageField(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
