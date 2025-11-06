import 'package:flutter/material.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/components/texts/rich_text_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/extension/theme_extension.dart';

class InputBoxComponent extends StatelessWidget {
  final String? label;
  final double? marginBottom;
  final String? childText;
  final String? placeHolder;
  final Widget? children;
  final Widget? childrenSizeBox;
  final GestureTapCallback? onTap;
  final bool alowClear;
  final String? errorMessage;
  final IconData? icon;
  final bool? isRequired;
  final bool? editable;
  final Function()? clearOnTab;
  final Color? labelColor;
  final Radius? borderRadius;

  const InputBoxComponent({
    super.key,
    this.label,
    this.marginBottom,
    this.childText,
    this.placeHolder,
    this.onTap,
    this.children,
    this.childrenSizeBox,
    this.alowClear = false,
    this.clearOnTab,
    this.errorMessage,
    this.isRequired = false,
    this.icon,
    this.editable,
    this.labelColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: label != null,
          child: RichTextComponent(
            margin: const EdgeInsets.only(bottom: 8),
            teks: [
              RichTextItem(
                text: label ?? '-',
                fontSize: FontSizes.h6,
                fontWeight: FontWeights.semiBold,
              ),
              RichTextItem(
                text: isRequired == true ? "*" : "",
                fontSize: FontSizes.h6,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.danger,
              ),
            ],
          ),
        ),
        Visibility(
          visible: children == null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 48,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      borderRadius == null ? 15 : borderRadius!.x,
                    ),
                    color: context.accent2.withValues(
                      alpha: editable == true ? .2 : .5,
                    ),
                    border: errorMessage != null
                        ? Border.all(
                            color: AppColors.danger.withValues(alpha: .5),
                          )
                        : Border.all(
                            color: context.contrast.withValues(
                              alpha: editable == true ? .2 : .5,
                            ),
                          ),
                  ),
                  padding: childrenSizeBox != null
                      ? null
                      : const EdgeInsets.only(left: 10, right: 10),
                  child:
                      childrenSizeBox ??
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: onTap,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextComponent(
                                  value:
                                      placeHolder != null && childText != null
                                      ? childText
                                      : placeHolder,
                                  fontSize: FontSizes.normal,
                                  fontColor: context.text,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: alowClear,
                            child: SizedBox(
                              width: 20,
                              height: 30,
                              child: InkWell(
                                onTap: clearOnTab,
                                child: const Icon(Icons.close, size: 14),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !alowClear && icon != null,
                            child: SizedBox(
                              width: 20,
                              height: 30,
                              child: InkWell(
                                onTap: onTap,
                                child: Icon(icon, size: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                ),
              ),
              Visibility(
                visible: errorMessage != null,
                child: TextComponent(
                  value: errorMessage ?? "",
                  fontSize: FontSizes.h6,
                  fontColor: AppColors.danger,
                  padding: const EdgeInsets.only(left: 12),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: children != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              children ?? Container(),
              Visibility(
                visible: errorMessage != null,
                child: TextComponent(
                  value: errorMessage ?? "",
                  fontSize: FontSizes.small,
                  fontColor: AppColors.danger,
                  padding: const EdgeInsets.only(left: 12),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: marginBottom ?? 10),
      ],
    );
  }
}
