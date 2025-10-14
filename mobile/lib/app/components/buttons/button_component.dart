import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/core/base/theme_controller.dart';

class ButtonComponent extends StatefulWidget {
  final Function() onTap;
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final FontWeight fontWeight;
  final double fontSize;
  final double borderRadius;
  final double? width;
  final bool isMultilineText;
  final String? icon;
  final bool isSvg;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? iconSize;
  final Widget? trailing;
  final Widget? leading;

  const ButtonComponent({
    super.key,
    required this.onTap,
    required this.text,
    this.textColor,
    this.buttonColor,
    this.fontWeight = FontWeight.normal,
    this.fontSize = FontSizes.h6,
    this.borderColor = Colors.transparent,
    this.width,
    this.isMultilineText = false,
    this.icon,
    this.isSvg = true,
    this.borderRadius = Radiuses.regular,
    this.padding,
    this.margin,
    this.iconSize,
    this.trailing,
    this.leading,
  });

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    final btnColor =
        widget.buttonColor ??
        (ThemeController.instance.themeMode.value == ThemeMode.light
            ? AppColors.lightContrast
            : AppColors.darkContrast);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width ?? double.infinity,
        margin: widget.margin,
        padding: widget.padding ?? const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: widget.borderColor),
          color: btnColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon != null
                ? widget.isSvg
                      ? SvgPicture.asset(
                          widget.icon!,
                          width: widget.iconSize ?? 15,
                          colorFilter: ColorFilter.mode(
                            widget.textColor ?? AppColors.darkText,
                            BlendMode.srcIn,
                          ),
                        )
                      : Image(
                          image: AssetImage(widget.icon!),
                          width: widget.iconSize ?? 15,
                        )
                : SizedBox(),
            if (widget.leading != null) ...[
              widget.leading!,
              SizedBox(width: 5),
            ],
            Flexible(
              flex: widget.isMultilineText ? 1 : 0,
              child: TextComponent(
                value: widget.text,
                fontColor: widget.textColor ?? AppColors.darkText,
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
                textAlign: TextAlign.center,
                margin: widget.icon != null
                    ? const EdgeInsets.only(left: 10)
                    : EdgeInsets.zero,
              ),
            ),
            if (widget.trailing != null) ...[
              SizedBox(width: 5),
              widget.trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
