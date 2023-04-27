import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/signup_controller.dart';
import 'package:jangjeon/firebase_options.dart';
import 'package:jangjeon/view/page/signup_page.dart';

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
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => SignupController(), fenix: true); //스플래시 화면 제거
      }),
      home: SignupPage(),
    );
  }
}
