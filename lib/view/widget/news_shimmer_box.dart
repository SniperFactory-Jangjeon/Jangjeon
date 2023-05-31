import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:shimmer/shimmer.dart';

class NewsShimmerBox extends StatelessWidget {
  const NewsShimmerBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.grayscale10,
      highlightColor: AppColor.grayscale20,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          width: Get.width,
          height: 140,
          decoration: BoxDecoration(
            color: AppColor.grayscale10,
            border: Border.all(
              width: 0.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}
