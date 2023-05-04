import 'package:firebase_auth/firebase_auth.dart';
import 'package:jangjeon/service/db_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //아이디 중복 체크
  checkIdDuplicate(id) => _firebaseAuth
          .createUserWithEmailAndPassword(
              email: '$id@jangjeon.com', password: '12345678')
          .then(
        (_) {
          _firebaseAuth.currentUser!.delete();
          return true;
        },
      ).catchError(
        (_) => false,
      );

  //회원가입
  signup(id, pw, user) => _firebaseAuth
          .createUserWithEmailAndPassword(
              email: '$id@jangjeon.com', password: pw)
          .then(
        (_) async {
          _firebaseAuth.currentUser!.updateDisplayName(user.name);
          DBService().createUserInfo(_firebaseAuth.currentUser!.uid, user);
          await _firebaseAuth.signOut();
          return true;
        },
      ).catchError(
        (_) => false,
      );

  //로그아웃
  logout() => _firebaseAuth.signOut();
}
