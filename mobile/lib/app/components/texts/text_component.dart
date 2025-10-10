import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/core/base/theme_controller.dart';

class TextComponent extends StatelessWidget {
  final String? value;
  final Color? fontColor;
  final FontWeight fontWeight;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final bool isMuted;
  final TextAlign textAlign;
  final int? maxLines;
  final Function()? onTap;
  final EdgeInsetsGeometry margin;
  final double? height;
  final Color? underlineColor;
  final FontStyle? fontStyle;
  const TextComponent({
    super.key,
    @required this.value,
    this.fontColor,
    this.onTap,
    this.isMuted = false,
    this.fontWeight = FontWeight.normal,
    this.fontSize = FontSizes.normal,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.height,
    this.underlineColor,
    this.fontStyle = FontStyle.normal,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        fontColor ??
        (ThemeController.instance.themeMode.value == ThemeMode.light
            ? AppColors.lightText
            : AppColors.darkText);
    return Container(
      margin: margin,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Text(
            value ?? "",
            maxLines: maxLines,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor.withValues(alpha: isMuted ? .9 : 1),
                height: height,
                decoration: underlineColor == null
                    ? null
                    : TextDecoration.underline,
                decorationColor: underlineColor,
                decorationThickness: 2,
                fontStyle: fontStyle,
              ),
            ),
            textAlign: textAlign,
            overflow: maxLines != null ? TextOverflow.ellipsis : null,
          ),
        ),
      ),
    );
  }
}
