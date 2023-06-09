import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class CommentTile extends StatelessWidget {
  const CommentTile(
      {super.key,
      required this.nickname,
      required this.content,
      required this.like,
      required this.comment,
      required this.time,
      required this.profileImg,
      required this.onTap});
  final String nickname;
  final String profileImg;
  final String content;
  final int like;
  final int comment;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileImg == ''
                  ? SvgPicture.asset('assets/svg/default_profile.svg')
                  : CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(profileImg),
                    ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(nickname,
                          style:
                              AppTextStyle.b5R12(color: AppColor.grayscale50)),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.circle,
                          size: 3,
                          color: AppColor.grayscale50,
                        ),
                      ),
                      Text(time,
                          style:
                              AppTextStyle.b5R12(color: AppColor.grayscale50)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 55,
                    child: Text(content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: AppTextStyle.b3M16()),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: onTap,
                            child: const FaIcon(
                              FontAwesomeIcons.solidHeart,
                              size: 15,
                              color: AppColor.grayscale10,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(like.toString(), style: AppTextStyle.b5R12()),
                        ],
                      ),
                      const SizedBox(width: 15),
                      // Row(
                      //   children: [
                      //     FaIcon(
                      //       FontAwesomeIcons.solidHeart,
                      //       size: 15,
                      //       color: AppColor.grayscale10,
                      //     ),
                      //     SizedBox(width: 8),
                      //     Text(comment.toString(), style: AppTextStyle.b5R12()),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Text(
            '신고',
            style: AppTextStyle.b5M12(color: AppColor.red100),
          ),
        ],
      ),
    );
  }
}
