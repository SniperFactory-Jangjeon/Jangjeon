import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:jangjeon/service/auth_service.dart';

class AuthController extends GetxController {
  final Rxn<User> _user = Rxn(); //유저 정보

  User? get user => _user.value; //유저 정보 getter

  //아이디 중복확인
  checkIdDuplicate(id) => AuthService().checkIdDuplicate(id);

  //회원가입
  signup(id, pw, user) => AuthService().signup(id, pw, user);

  //로그아웃
  logout() => AuthService().logout();
}
