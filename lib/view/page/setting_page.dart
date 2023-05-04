import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/setting_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_dialog.dart';
import 'package:jangjeon/view/widget/app_floatingaction_button.dart';
import 'package:jangjeon/view/widget/app_navigation_bar.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});
  static const route = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_new)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.ticket)),
          const SizedBox(width: 12)
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(radius: 37),
            title: Text('username', style: AppTextStyle.h4B20()),
            subtitle: Text('이용권 구매',
                style: AppTextStyle.b4R14(color: AppColor.grayscale50)),
            trailing: TextButton(
                onPressed: () => Get.dialog(AppDialog(
                    content: '정말 로그아웃 하겠습니까?',
                    onCancel: () => Get.back(),
                    onConfirm: controller.logout,
                    cancelText: '취소',
                    confirmText: '확인')),
                child: Text(
                  '로그아웃',
                  style: AppTextStyle.b4M14(color: AppColor.red100),
                )),
          ),
          const SizedBox(height: 17),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Text(
                      '관심 기업',
                      style: AppTextStyle.b5M12(color: AppColor.grayscale100),
                    ),
                    const SizedBox(height: 6.5),
                    Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: 73,
                        decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text('대충 즐겨찾기.length')))
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    Text(
                      '나의 댓글',
                      style: AppTextStyle.b5M12(color: AppColor.grayscale100),
                    ),
                    const SizedBox(height: 6.5),
                    Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: 73,
                        decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text('대충 댓글.length')))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 29),
          const Divider(color: Color(0xFFECECEC), thickness: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListTile(
              title: Text('관련 뉴스 알림',
                  style: AppTextStyle.b3R16(color: AppColor.grayscale100)),
              trailing: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Obx(
                  //shared_preferences 사용해서 쓰나?
                  () => IconButton(
                      onPressed: () {
                        controller.notifycation();
                      },
                      icon: controller.isNotifycation()
                          ? const Icon(Icons.toggle_on,
                              size: 45, color: AppColor.red100)
                          : const Icon(
                              Icons.toggle_off,
                              size: 45,
                              color: AppColor.grayscale10,
                            )),
                ),
              ),
            ),
          ),
          Container(
              height: 1,
              decoration: const BoxDecoration(color: Color(0xFFECECEC))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListTile(
              title: Text('마케팅 정보 수신 동의',
                  style: AppTextStyle.b3R16(color: AppColor.grayscale100)),
              trailing: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Obx(
                  () => IconButton(
                      onPressed: () {
                        controller.marketingAgree();
                      },
                      icon: controller.isMarketingAgree()
                          ? const Icon(Icons.toggle_on,
                              size: 45, color: AppColor.red100)
                          : const Icon(
                              Icons.toggle_off,
                              size: 45,
                              color: AppColor.grayscale10,
                            )),
                ),
              ),
            ),
          ),
          const Divider(color: Color(0xFFECECEC), thickness: 10),
          ListTile(
            onTap: () => Get.toNamed(AppRoutes.myinfoedit),
            title: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text('개인정보 설정',
                  style: AppTextStyle.b3R16(color: AppColor.grayscale100)),
            ),
          ),
          Container(
              height: 1,
              decoration: const BoxDecoration(color: Color(0xFFECECEC))),
          ListTile(
            onTap: () => print('이용약관페이지 이동'),
            title: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text('이용약관',
                  style: AppTextStyle.b3R16(color: AppColor.grayscale100)),
            ),
          ),
          Container(
              height: 1,
              decoration: const BoxDecoration(color: Color(0xFFECECEC))),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text('버전정보',
                  style: AppTextStyle.b3R16(color: AppColor.grayscale100)),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                '1.2.1',
                style: AppTextStyle.b3B16(color: AppColor.grayscale30),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: const AppFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const AppNabigationBar(),
    );
  }
}
