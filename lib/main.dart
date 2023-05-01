import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/setting_controller.dart';
import 'package:jangjeon/controller/withdrawal_controller.dart';
import 'package:jangjeon/firebase_options.dart';
import 'package:jangjeon/util/app_pages.dart';
import 'package:jangjeon/view/page/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, //우측 상단 DEBUG리본 없애기
      home: MainPage(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => SettingController(), fenix: true);
        Get.lazyPut(() => WithdrawalController(), fenix: true);
      }),
      getPages: AppPages.pages,
    );
  }
}
