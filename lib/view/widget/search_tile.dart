import 'package:flutter/material.dart';
import 'package:jangjeon/model/stock.dart';
import 'package:jangjeon/util/app_color.dart';

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
  handleBookmarkButton() {
    widget.bookmark = !widget.bookmark;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.index.toString()),
        CircleAvatar(backgroundImage: NetworkImage(widget.stock.logo)),
        Column(
          children: [
            Text(widget.stock.name),
            Text(widget.stock.symbol),
          ],
        ),
        IconButton(
          onPressed: handleBookmarkButton,
          color: widget.bookmark ? Colors.yellow : AppColor.grayscale10,
          icon: const Icon(
            Icons.star_rounded,
          ),
        ),
      ],
    );
  }
}
