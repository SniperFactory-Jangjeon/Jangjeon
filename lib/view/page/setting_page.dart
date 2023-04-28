import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_text_style.dart';
import 'package:jangjeon/view/widget/app_floatingaction_button.dart';
import 'package:jangjeon/view/widget/app_navigation_bar.dart';

class SettingPage extends StatelessWidget {
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
                style: AppTextStyle.b4R14(color: Color(0xFF878787))),
            trailing: TextButton(
                onPressed: () {},
                child: Text(
                  '로그아웃',
                  style: AppTextStyle.b4M14(color: Color(0xFFEB0F29)),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('관심 기업'),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 73,
                    decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10)),
                  )
                ],
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  Text('나의 댓글'),
                  Container(
                    width: 188,
                    height: 73,
                    decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10)),
                  )
                ],
              )
            ],
          )
        ],
      ),
      floatingActionButton: const AppFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const AppNabigationBar(),
    );
  }
}
