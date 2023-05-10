import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.offAllNamed(AppRoutes.main)
      },
      child: SvgPicture.asset('assets/svg/floating_action_button.svg')
    );
  }
}
