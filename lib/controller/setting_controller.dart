import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/controller/main_controller.dart';
import 'package:jangjeon/service/db_service.dart';
import 'package:jangjeon/model/userInfo.dart' as profile;

class SettingController extends GetxController {
  Rx<User> get user => Get.find<AuthController>().user!.obs;
  var main = Get.find<MainController>();
  Rxn<String> profileUrl =
      Rxn<String>(Get.find<AuthController>().user!.photoURL);
  RxBool isNotifycation = false.obs;
  RxBool isMarketingAgree = false.obs;

  Rxn<profile.UserInfo> userInfo = Rxn<profile.UserInfo>();

  //로그아웃
  logout() => Get.find<AuthController>().logout();

  //뉴스 알림 체크
  notifycation() {
    if (isNotifycation.isTrue) {
      isNotifycation(false);
    } else {
      isNotifycation(true);
    }
  }

  //마케팅 정보 수신 동의 체크
  marketingAgree() {
    if (isMarketingAgree.isTrue) {
      isMarketingAgree(false);
    } else {
      isMarketingAgree(true);
    }
    //파이어베이스에 업데이트...
    DBService().updateOptionalAgreement(user.value.uid, isMarketingAgree.value);
  }

  //유저 정보 가져오기
  getUserInfo() async {
    var res = await DBService().getUserInfo(user.value.uid);
    isMarketingAgree(res.optionalAgreement);
    return res;
  }

  @override
  void onInit() async {
    super.onInit();
    userInfo(await getUserInfo());
  }
}
