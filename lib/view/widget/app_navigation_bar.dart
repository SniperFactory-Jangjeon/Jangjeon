import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_routes.dart';

class AppNabigationBar extends StatelessWidget {
  const AppNabigationBar({
    super.key,
    // required this.selectIndex,
    // required this.onTap
  });

  // final int selectIndex;
  // final Function(int indet) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10.8,
      decoration: const BoxDecoration(color: Color(0xFFF3F3F3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.stock),
            child: SizedBox(
              height: 50,
              child: Column(
                children: const [
                  Icon(
                    Icons.equalizer,
                    color: Color(0xFF878787),
                    size: 30,
                  ),
                  Text(
                    '주식',
                    style: TextStyle(color: Color(0xFF878787)),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.setting),
            child: SizedBox(
              height: 50,
              child: Column(
                children: const [
                  Icon(
                    Icons.person,
                    color: Color(0xFF878787),
                    size: 30,
                  ),
                  Text('설정', style: TextStyle(color: Color(0xFF878787)))
                ],
              ),
            ),
          )
        ],
      ),
      // child: BottomNavigationBar(
      //   currentIndex: selectIndex,
      //   onTap: onTap,
      //   backgroundColor: const Color(0xFFF3F3F3),
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.equalizer), label: '주식'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: '설정')
      //   ],
      // ),
    );
  }
}
