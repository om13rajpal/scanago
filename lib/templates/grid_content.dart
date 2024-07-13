import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanago/templates/caption_style.dart';
import 'package:scanago/utils/route_animation.dart';

class GridContent extends StatefulWidget {
  final Color bgColor;
  final String title;
  final String subtitle;
  final String svgPath;
  final Widget? page;
  const GridContent(
      {super.key,
      required this.bgColor,
      required this.title,
      required this.subtitle,
      required this.svgPath,
      required this.page});

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
        padding: const EdgeInsets.only(top: 12, left: 12, bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.bgColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              widget.svgPath,
              width: 22,
            ),
            Text(
              widget.title,
              style: const TextStyle(
                  fontFamily: 'inter',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff0e0e0e)),
            ),
            CaptionStyle(
                textColor: const Color(0xff747474),
                text: widget.subtitle,
                fontSize: 9.2)
          ],
        ),
      ),
    );
  }
}
