import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/login_controller.dart';
import 'package:jangjeon/firebase_options.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:jangjeon/util/app_pages.dart';
import 'package:jangjeon/view/page/main_page.dart';
import 'package:jangjeon/controller/signup_controller.dart';
import 'package:jangjeon/firebase_options.dart';
import 'package:jangjeon/view/page/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  KakaoSdk.init(nativeAppKey: 'cbe2327f360f8a91c80f74544db1800f');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(LoginController());
        Get.lazyPut(() => SignupController(), fenix: true);
      }),
      debugShowCheckedModeBanner: false, //우측 상단 DEBUG리본 없애기
      home: MainPage(),
      getPages: AppPages.pages,
      //스플래시 화면 제거
    );
  }
}
