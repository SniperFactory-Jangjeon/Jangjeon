import 'package:get/get.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/view/page/login_page.dart';
import 'package:jangjeon/view/page/main_page.dart';
import 'package:jangjeon/view/page/personal_info_modification_page.dart';
import 'package:jangjeon/view/page/setting_page.dart';
import 'package:jangjeon/view/page/signup_page.dart';
import 'package:jangjeon/view/page/stock_page.dart';
import 'package:jangjeon/view/page/withdrawal_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.main, page: () => const MainPage()),
    GetPage(name: AppRoutes.setting, page: () => const SettingPage()),
    GetPage(name: AppRoutes.stock, page: () => const StockPage()),
    GetPage(
        name: AppRoutes.myinfoedit, page: () => const PersonalInfoEditPage()),
    GetPage(name: AppRoutes.withdrawal, page: () => const WithdrawalPage()),
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.signup, page: () => const SignupPage()),
  ];
}
