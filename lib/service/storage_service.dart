import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/service/db_service.dart';

class StorageService {
  Rx<User> get user => Get.find<AuthController>().user!.obs;
  Rxn<String> profileUrl =
      Rxn<String>(Get.find<AuthController>().user!.photoURL);

  gallery() async {
    var picker = ImagePicker();
    var res = await picker.pickImage(source: ImageSource.gallery);
    if (res != null) {
      var ref = FirebaseStorage.instance.ref('profile/${user.value.uid}');
      await ref.putFile(File(res.path));
      var downloadUrl = await ref.getDownloadURL();
      user.value.updatePhotoURL(downloadUrl);
      this.profileUrl.value = downloadUrl;
      DBService().updateUserInfoPhoto(user.value.uid, downloadUrl);
      return profileUrl;
    }
    Get.back();
  }

  camera() async {
    var picker = ImagePicker();
    var res = await picker.pickImage(source: ImageSource.camera);
    if (res != null) {
      var ref = FirebaseStorage.instance.ref('profile/${user.value.uid}');
      await ref.putFile(File(res.path));
      var downloadUrl = await ref.getDownloadURL();
      user.value.updatePhotoURL(downloadUrl);
      this.profileUrl.value = downloadUrl;
      DBService().updateUserInfoPhoto(user.value.uid, downloadUrl);
      return profileUrl;
    }
    Get.back();
  }
}
