import 'package:get/get.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/view/page/find_id_page.dart';
import 'package:jangjeon/view/page/find_password_page.dart';
import 'package:jangjeon/view/page/login_page.dart';
import 'package:jangjeon/view/page/main_page.dart';
import 'package:jangjeon/view/page/personal_info_edit_page.dart';
import 'package:jangjeon/view/page/signup_page.dart';
import 'package:jangjeon/view/page/stock_detail_page.dart';
import 'package:jangjeon/view/page/account_delete_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.main, page: () => const MainPage()),
    GetPage(
        name: AppRoutes.myinfoedit, page: () => const PersonalInfoEditPage()),
    GetPage(
        name: AppRoutes.accountDelete, page: () => const AccountDeletePage()),
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.signup, page: () => const SignupPage()),
    GetPage(name: AppRoutes.stockDetail, page: () => const StockDetailPage()),
    GetPage(name: AppRoutes.findPassword, page: () => const FindPasswordPage()),
    GetPage(name: AppRoutes.findId, page: () => const FindIdPage()),
  ];
}
