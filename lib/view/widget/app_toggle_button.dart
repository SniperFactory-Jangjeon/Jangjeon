import 'package:flutter/material.dart';
import 'package:jangjeon/util/app_color.dart';

class AppToggleButton extends StatefulWidget {
  const AppToggleButton({super.key});

  @override
  State<AppToggleButton> createState() => _AppToggleButtonState();
}

class _AppToggleButtonState extends State<AppToggleButton> {
  int currentIndex = 0; //현재 선택된 옵션 인덱스
  List<bool> isSelected = [true, false, false, false]; //선택 여부 리스트

  //옵션 선택 핸들러
  _handleSelectOption(index) {
    currentIndex = index;
    for (var i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = true;
      } else {
        isSelected[i] = false;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _handleSelectOption(0),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: currentIndex == 0 ? AppColor.red10 : AppColor.grey,
                borderRadius: BorderRadius.circular(10),
                border: currentIndex == 0
                    ? Border.all(
                        color: AppColor.red100,
                      )
                    : null,
              ),
              child: Text(
                style: TextStyle(
                  color: currentIndex == 0
                      ? AppColor.red100
                      : AppColor.grayscale10,
                  fontSize: 16,
                ),
                'SKT',
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            onTap: () => _handleSelectOption(1),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: currentIndex == 1 ? AppColor.red10 : AppColor.grey,
                borderRadius: BorderRadius.circular(10),
                border: currentIndex == 1
                    ? Border.all(
                        color: AppColor.red100,
                      )
                    : null,
              ),
              child: Text(
                style: TextStyle(
                  color: currentIndex == 1
                      ? AppColor.red100
                      : AppColor.grayscale10,
                  fontSize: 16,
                ),
                'KT',
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            onTap: () => _handleSelectOption(2),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: currentIndex == 2 ? AppColor.red10 : AppColor.grey,
                borderRadius: BorderRadius.circular(10),
                border: currentIndex == 2
                    ? Border.all(
                        color: AppColor.red100,
                      )
                    : null,
              ),
              child: Text(
                style: TextStyle(
                  color: currentIndex == 2
                      ? AppColor.red100
                      : AppColor.grayscale10,
                  fontSize: 16,
                ),
                'LG U+',
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            onTap: () => _handleSelectOption(3),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: currentIndex == 3 ? AppColor.red10 : AppColor.grey,
                borderRadius: BorderRadius.circular(10),
                border: currentIndex == 3
                    ? Border.all(
                        color: AppColor.red100,
                      )
                    : null,
              ),
              child: Text(
                style: TextStyle(
                  color: currentIndex == 3
                      ? AppColor.red100
                      : AppColor.grayscale10,
                  fontSize: 16,
                ),
                '알뜰폰',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
