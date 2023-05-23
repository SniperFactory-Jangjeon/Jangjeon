import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jangjeon/util/app_text_style.dart';

class AiScore extends StatelessWidget {
  const AiScore({super.key, required this.aiScore});
  final int aiScore;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        aiScore > -31 && aiScore < 31
            ? SvgPicture.asset('assets/svg/ai_neutral.svg')
            : aiScore > 0
                ? SvgPicture.asset('assets/svg/ai_positive.svg')
                : SvgPicture.asset('assets/svg/ai_negative.svg'),
        Text(
          aiScore > 0 ? ' +$aiScore' : ' $aiScore',
          style: AppTextStyle.b4B14(),
        ),
      ],
    );
  }
}
