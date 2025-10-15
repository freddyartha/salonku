import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salonku/app/common/font_size.dart';

import 'package:salonku/app/extension/theme_extension.dart';

class RichTextItem {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? fontColor;
  final Color? underlineColor;

  RichTextItem({
    required this.text,
    this.fontWeight,
    this.fontSize,
    this.fontColor,
    this.underlineColor,
  });
}

class RichTextComponent extends StatelessWidget {
  final List<RichTextItem> teks;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? fontColor;
  final Color? underlineColor;
  final EdgeInsetsGeometry margin;
  const RichTextComponent({
    super.key,
    required this.teks,
    this.fontColor,
    this.fontWeight = FontWeight.normal,
    this.fontSize = FontSizes.normal,
    this.underlineColor,
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    final textColor = fontColor ?? context.text;
    return Container(
      margin: margin,
      child: Text.rich(
        TextSpan(
          children: teks
              .map(
                (e) => TextSpan(
                  text: e.text,
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      fontSize: e.fontSize ?? fontSize,
                      fontWeight: e.fontWeight ?? fontWeight,
                      color: e.fontColor ?? textColor,
                      decoration:
                          e.underlineColor == null && underlineColor == null
                          ? null
                          : TextDecoration.underline,
                      decorationColor: e.underlineColor ?? underlineColor,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
