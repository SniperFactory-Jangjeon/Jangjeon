import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/main_controller.dart';
import 'package:jangjeon/controller/setting_controller.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_routes.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_dialog.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({super.key});
  static const route = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.find<MainController>().bottomNavIndex(2);
            },
            icon: const Icon(Icons.navigate_before)),
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(AppRoutes.ticket),
              icon: const Icon(CupertinoIcons.ticket))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Obx(
                      () => CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: controller.profileUrl.value != null
                            ? NetworkImage(controller.profileUrl.value!)
                            : null,
                        child: controller.profileUrl.value == null
                            ? Image.asset('assets/icons/circle-user.png')
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Text(controller.userInfo.value?.name ?? '',
                                style: AppTextStyle.h4B20()),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 60,
                            decoration: BoxDecoration(
                                color: AppColor.red100,
                                borderRadius: BorderRadius.circular(17)),
                            child: Center(
                              child: Text(
                                'Basic',
                                style: AppTextStyle.b5M12(
                                    color: AppColor.grayscale0),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 6.5),
                      Text('이용권 구매',
                          style:
                              AppTextStyle.b4R14(color: AppColor.grayscale50)),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: TextButton(
                        onPressed: () => Get.dialog(AppDialog(
                            content: '로그아웃',
                            subcontent: '정말 로그아웃 하겠습니까?',
                            onCancel: () => Get.back(),
                            onConfirm: controller.logout,
                            cancelText: '취소',
                            confirmText: '확인')),
                        child: Text(
                          '로그아웃',
                          style: AppTextStyle.b4M14(color: AppColor.red100),
                        )),
                  ),
                ],
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
                          style:
                              AppTextStyle.b5M12(color: AppColor.grayscale100),
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
                          style:
                              AppTextStyle.b5M12(color: AppColor.grayscale100),
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
                padding: const EdgeInsets.only(left: 15),
                child: ListTile(
                  title: Text('관심 뉴스 알림',
                      style: AppTextStyle.b3R16(color: AppColor.grayscale100)),
                  trailing: Obx(() => Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                            activeColor: AppColor.red100,
                            value: controller.isNotifycation.value,
                            onChanged: (value) {
                              controller.notifycation();
                            }),
                      )),
                ),
              ),
              Container(
                  height: 1,
                  decoration: const BoxDecoration(color: Color(0xFFECECEC))),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ListTile(
                  title: Text('마케팅 정보 수신 동의',
                      style: AppTextStyle.b3R16(color: AppColor.grayscale100)),
                  trailing: Obx(() => Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                            activeColor: AppColor.red100,
                            value: controller.isMarketingAgree.value,
                            onChanged: (value) => controller.marketingAgree()),
                      )),
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
              TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.certify),
                  child: const Text('휴대폰인증화면')),
              Container(
                  height: 1,
                  decoration: const BoxDecoration(color: Color(0xFFECECEC))),
              ListTile(
                onTap: () => Get.toNamed(AppRoutes.termsofservice),
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
        ),
      ),
    );
  }
}
