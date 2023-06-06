import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jangjeon/controller/main_controller.dart';
import 'package:jangjeon/model/stock.dart';
import 'package:jangjeon/util/app_color.dart';
import 'package:jangjeon/util/app_text_style.dart';

class SearchTile extends StatefulWidget {
  SearchTile(
      {super.key,
      required this.index,
      required this.stock,
      this.bookmark = false});

  final int index;
  final Stock stock;
  bool bookmark;

  @override
  State<SearchTile> createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  var main = Get.find<MainController>();

  ImageProvider? isLogoNetwork;

  //즐겨찾기 추가 기능
  handleBookmarkButton() {
    widget.bookmark = !widget.bookmark;
    main.addMyStock(widget.stock.symbol);
    main.getMyStock();
    setState(() {});
  }

  //로고 이미지 로딩 가능 여부 확인
  getLogoProvider() {
    try {
      isLogoNetwork = NetworkImage(widget.stock.logo);
      return isLogoNetwork;
    } catch (_) {
      isLogoNetwork = const AssetImage('assets/icons/circle-user.png');
      return isLogoNetwork;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.bookmark = main.readBookmark(widget.stock.symbol);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Text(widget.index.toString()),
          const SizedBox(width: 8),
          Container(
            width: 56,
            height: 56,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Image.network(
              widget.stock.logo,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return SvgPicture.asset(
                    'assets/svg/floating_action_button.svg');
              },
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.b3B16(color: AppColor.grayscale100),
                  widget.stock.name,
                ),
                Text(
                  style: AppTextStyle.b4M14(color: AppColor.grayscale50),
                  widget.stock.symbol,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed:
                widget.stock.symbol == 'TSLA' ? null : handleBookmarkButton,
            color: widget.bookmark ? Colors.yellow : AppColor.grayscale10,
            disabledColor: Colors.yellow,
            icon: const Icon(
              Icons.star_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
