import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_routes.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.offAllNamed(AppRoutes.main),
      child: Stack(
        children: [
          Container(
            height: 92,
            width: 92,
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              height: 83,
              width: 83,
              decoration: BoxDecoration(
                  color: Color(0xFFEB0F29), shape: BoxShape.circle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
                height: 60,
                width: 60,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
          ),
          Padding(
            padding: const EdgeInsets.all(36),
            child: Container(
              height: 21,
              width: 21,
              decoration: BoxDecoration(
                  color: Color(0xFFEB0F29), shape: BoxShape.circle),
            ),
          )
        ],
      ),
    );
  }
}
