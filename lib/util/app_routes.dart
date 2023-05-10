import 'package:jangjeon/view/page/certify_page.dart';
import 'package:jangjeon/view/page/find_id_page.dart';
import 'package:jangjeon/view/page/find_password_page.dart';
import 'package:jangjeon/view/page/login_page.dart';
import 'package:jangjeon/view/page/main_page.dart';
import 'package:jangjeon/view/page/news_detail_page.dart';
import 'package:jangjeon/view/page/personal_info_edit_page.dart';
import 'package:jangjeon/view/page/signup_page.dart';
import 'package:jangjeon/view/page/stock_detail_page.dart';
import 'package:jangjeon/view/page/account_delete_page.dart';
import 'package:jangjeon/view/page/terms_of_service.page.dart';
import 'package:jangjeon/view/page/ticket_page.dart';

class AppRoutes {
  static const main = MainPage.route; //메인페이지
  static const myinfoedit = PersonalInfoEditPage.route; //개인정보 수정페이지
  static const accountDelete = AccountDeletePage.route; //회원탈퇴페이지
  static const login = LoginPage.route; // 로그인페이지
  static const signup = SignupPage.route; //회원가입 페이지
  static const stockDetail = StockDetailPage.route; //주식 상세 페이지
  static const findPassword = FindPasswordPage.route; //비밀번호 찾기 페이지
  static const findId = FindIdPage.route; //아이디 찾기 페이지
  static const termsofservice = TermsOfServicePage.route; //이용약관 페이지
  static const ticket = TicketPage.route; //이용권 구매 페이지
  static const certify = CertifyPage.route; //휴대폰 인증 페이지
  static const newsDetail = NewsDetailPage.route; //뉴스 상세 페이지
}
