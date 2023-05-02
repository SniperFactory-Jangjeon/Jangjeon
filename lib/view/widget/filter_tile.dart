import 'package:flutter/material.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class FilterTile extends StatelessWidget {
  const FilterTile({super.key, required this.text, required this.selected});
  final String text;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.5),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? AppColor.grayscale10 : Colors.transparent,
          border: Border.all(
            width: 0.5,
            color: AppColor.grayscale30,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: Text(text,
              style: AppTextStyle.b4M14(
                  color:
                      selected ? AppColor.grayscale100 : AppColor.grayscale30)),
        ),
      ),
    );
  }
}
