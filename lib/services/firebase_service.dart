import 'dart:io';
import 'dart:typed_data';

import 'package:bid_online_app_v2/pages/register_user/components/register_form.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

class FirebaseService {
  Future<String?> uploadImageToFirebase(
      XFile image, String email, String avatar) async {
    try {
      String fileName = Path.basename(image.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instanceFor(bucket: 'gs://bid-online-app.appspot.com')
              .ref('/main')
              .child("/$email/$avatar/$fileName");
      UploadTask uploadTask = firebaseStorageRef.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<List<String>?> uploadImageItem(
    List<Asset> images,
    String email,
    String itemId,
  ) async {
    List<String>? imageUrls = [];
    try {
      for (var asset in images) {
        ByteData byteData = await asset.getByteData(quality: 100);
        // List<int> imageData = byteData.buffer.asUint8List();

        Reference firebaseStorageRef = FirebaseStorage.instanceFor(
                bucket: 'gs://bid-online-app.appspot.com')
            .ref('/main')
            .child("/$email/$itemId/${asset.name}");
        UploadTask uploadTask =
            firebaseStorageRef.putData(byteData.buffer.asUint8List());
        TaskSnapshot taskSnapshot = await uploadTask;
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
      return imageUrls;
    } catch (e) {
      print("Error: $e");
    }
    return imageUrls;
  }

  String getFileName(String url) {
    RegExp regExp = RegExp(r'.+(\/|%2F)(.+)\?.+');
    //This Regex won't work if you remove ?alt...token
    var matches = regExp.allMatches(url);

    var match = matches.elementAt(0);
    return Uri.decodeFull(match.group(2)!);
  }

  Future<void> deleteFileByItem(
      String path, String email, String itemID, List<String> imagesLink) async {
    try {
      List<String> fileNames = [];
      for (var element in imagesLink) {
        String tmpName = getFileName(element).split('/').last;
        fileNames.add(tmpName);
      }

      for (var element in fileNames) {
        FirebaseStorage.instanceFor(bucket: 'gs://bid-online-app.appspot.com')
            .ref('/main')
            .child("/$path/$itemID/$element")
            .delete();
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      String fileNameAvatar =
          getFileName(RegisterAccountForm.avatarImageLink!).split('/').last;
      String fileNameFront =
          getFileName(RegisterAccountForm.frontImageLink!).split('/').last;
      String fileNameBack =
          getFileName(RegisterAccountForm.backImageLink!).split('/').last;

      FirebaseStorage.instanceFor(bucket: 'gs://bid-online-app.appspot.com')
          .ref('/test')
          .child("/$path/avatar/$fileNameAvatar")
          .delete();

      FirebaseStorage.instanceFor(bucket: 'gs://bid-online-app.appspot.com')
          .ref('/test')
          .child("/$path/front/$fileNameFront")
          .delete();

      FirebaseStorage.instanceFor(bucket: 'gs://bid-online-app.appspot.com')
          .ref('/test')
          .child("/$path/back/$fileNameBack")
          .delete();
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> deleteFileWhenUpdate(String path) async {
    try {
      String fileNameAvatar =
          getFileName(RegisterAccountForm.avatarImageLink!).split('/').last;

      FirebaseStorage.instanceFor(bucket: 'gs://bid-online-app.appspot.com')
          .ref('/main')
          .child("/$path/avatar/$fileNameAvatar")
          .delete();
    } catch (e) {
      print("Error: $e");
    }
  }
}
