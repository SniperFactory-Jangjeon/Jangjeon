import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:jangjeon/service/auth_service.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/view/widget/app_dialog.dart';

class AuthController extends GetxController {
  final Rxn<User> _user = Rxn(); //유저 정보

  User? get user => _user.value; //유저 정보 getter

  //아이디 중복확인
  checkIdDuplicate(id) => AuthService().checkIdDuplicate(id);

  //회원가입
  signup(id, pw, user) => AuthService().signup(id, pw, user);

  //로그아웃
  logout() => AuthService().logout();

  //로그인
  login(id, pw) => AuthService().login(id, pw);

  //회원탈퇴
  deleteUser() => AuthService().deleteUser();
  //토큰 로그인
  signInWithCustomToken(token) => AuthService().signInWithCustomToken(token);

  //이메일 인증
  verifyEamil() async {
    AuthService().sendEamilVerification();
    await Get.dialog(
      AppDialog(
        content: '이메일 인증',
        subcontent: '인증메일을 전송했습니다.\n인증 후 로그인해주세요.',
        onCancel: () => Get.back(),
        onConfirm: () => Get.back(),
        cancelText: '닫기',
        confirmText: '확인',
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    deleteUser();
    FirebaseAuth.instance.authStateChanges().listen((value) async {
      _user(value);
      if (Get.currentRoute != AppRoutes.signup) {
        if (value != null) {
          if (_user.value!.emailVerified ||
              _user.value!.uid.substring(0, 5) == 'kakao') {
            await Get.offAllNamed(AppRoutes.main);
          } else {
            await verifyEamil();
            logout();
          }
        } else {
          await Get.offAllNamed((AppRoutes.login));
        }
      }
    });
  }
}
