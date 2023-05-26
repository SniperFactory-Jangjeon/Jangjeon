import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/comments_controller.dart';
import 'package:jangjeon/controller/main_controller.dart';
import 'package:jangjeon/controller/find_id_controller.dart';
import 'package:jangjeon/controller/find_password_controller.dart';
import 'package:jangjeon/controller/news_detail_controller.dart';
import 'package:jangjeon/controller/personal_info_edit_controller.dart';
import 'package:jangjeon/controller/search_controller.dart';
import 'package:jangjeon/controller/setting_controller.dart';
import 'package:jangjeon/controller/account_delete_controller.dart';
import 'package:jangjeon/controller/auth_controller.dart';
import 'package:jangjeon/controller/login_controller.dart';
import 'package:jangjeon/controller/terms_of_service_controller.dart';
import 'package:jangjeon/controller/ticket_controller.dart';
import 'package:jangjeon/firebase_options.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/controller/stock_detail_controller.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:jangjeon/util/app_pages.dart';
import 'package:jangjeon/controller/signup_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  KakaoSdk.init(nativeAppKey: '6a87bfbd18f4ebe698eecbcceba07d34');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(LoginController());
        Get.lazyPut(() => SignupController(), fenix: true);
        Get.lazyPut(() => FindPasswordController(), fenix: true);
        Get.lazyPut(() => FindIdController(), fenix: true);
        Get.lazyPut(() => SettingController(), fenix: true);
        Get.lazyPut(() => AccountDeleteController(), fenix: true);
        Get.lazyPut(() => MainController(), fenix: true);
        Get.lazyPut(() => StockDetailController(), fenix: true);
        Get.lazyPut(() => PersonalInfoEditController(), fenix: true);
        Get.lazyPut(() => TermsOfServiceController(), fenix: true);
        Get.lazyPut(() => TicketController(), fenix: true);
        Get.lazyPut(() => NewsDetailController(), fenix: true);
        Get.lazyPut(() => CommentsController(), fenix: true);
        Get.lazyPut(() => SearchController(), fenix: true);
      }),
      debugShowCheckedModeBanner: false, //우측 상단 DEBUG리본 없애기
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
      //스플래시 화면 제거
    );
  }
}
