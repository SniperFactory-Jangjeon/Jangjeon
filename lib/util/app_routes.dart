import 'package:jangjeon/view/page/login_page.dart';
import 'package:jangjeon/view/page/main_page.dart';
import 'package:jangjeon/view/page/personal_info_edit_page.dart';
import 'package:jangjeon/view/page/setting_page.dart';
import 'package:jangjeon/view/page/signup_page.dart';
import 'package:jangjeon/view/page/stock_page.dart';
import 'package:jangjeon/view/page/account_delete_page.dart';

class AppRoutes {
  static const main = MainPage.route; //메인페이지
  static const setting = SettingPage.route; // 설정페이지
  static const stock = StockPage.route; // 주식페이지
  static const myinfoedit = PersonalInfoEditPage.route; //개인정보 수정페이지
  static const accountDelete = AccountDeletePage.route; //회원탈퇴페이지
  static const login = LoginPage.route; // 로그인페이지
  static const signup = SignupPage.route; //회원가입 페이지
}
