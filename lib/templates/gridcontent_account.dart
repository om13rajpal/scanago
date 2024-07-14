import 'package:flutter/material.dart';
import 'package:scanago/templates/caption_style.dart';
import 'package:scanago/utils/route_animation.dart';

class GridContent extends StatefulWidget {
  final Color bgColor;
  final String title;
  final String subtitle;
  final Widget? page;
  final double screenWidth;
  const GridContent(
      {super.key,
      required this.bgColor,
      required this.title,
      required this.subtitle,
      required this.page,
      required this.screenWidth});

  @override
  State<GridContent> createState() => _GridContentState();
}

class _GridContentState extends State<GridContent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, createFadeRoute(widget.page!));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.bgColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  fontFamily: 'inter',
                  fontSize: widget.screenWidth * 0.032,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff353535)),
            ),
            CaptionStyle(
                textColor: const Color(0xff646464),
                text: widget.subtitle,
                fontSize: widget.screenWidth * 0.026)
          ],
        ),
      ),
    );
  }
}
