import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/texts/rich_text_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/extension/theme_extension.dart';
import 'package:salonku/app/models/select_item_model.dart';

class CustomMultipleController<T> {
  late Function(VoidCallback fn) setState;

  final List<T> _selectedItemList = [];
  final SelectItemModel Function(T) mapper;
  final Future<T?> Function(T? selectedItem) createChildren;
  Function(List<T> items)? onChanged;

  String? _errorMessage;
  late bool _required;

  CustomMultipleController({
    required this.mapper,
    required this.createChildren,
    this.onChanged,
  });

  List<T> get values {
    return _selectedItemList;
  }

  set values(List<T> value) {
    _selectedItemList.clear();
    _selectedItemList.addAll(value);
    setState(() {});
  }

  void init(Function(VoidCallback fn) setStateX, BuildContext context) {
    setState = setStateX;
  }

  void _selectItemOnTap(BuildContext context) async {
    var result = await createChildren(null);
    if (result != null) {
      _selectedItemList.add(result);
      if (onChanged != null) {
        onChanged!(_selectedItemList);
      }
    }
  }

  bool get isValid {
    setState(() {
      _errorMessage = null;
    });

    if (_required && _selectedItemList.isEmpty) {
      setState(() {
        _errorMessage = 'field_is_required'.tr;
      });
      return false;
    }
    return true;
  }
}

class CustomMultipleComponent<T> extends StatefulWidget {
  final CustomMultipleController<T> controller;
  final String label;
  final bool editable;
  final bool required;

  const CustomMultipleComponent({
    super.key,
    required this.controller,
    required this.label,
    this.editable = true,
    this.required = false,
  });

  @override
  State<CustomMultipleComponent<T>> createState() =>
      _CustomMultipleComponentState<T>();
}

class _CustomMultipleComponentState<T>
    extends State<CustomMultipleComponent<T>> {
  @override
  void initState() {
    widget.controller.init((fn) {
      if (mounted) {
        setState(fn);
      }
    }, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller._required = widget.required;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichTextComponent(
          margin: EdgeInsetsGeometry.only(bottom: 5),
          teks: [
            RichTextItem(
              text: widget.label,
              fontSize: FontSizes.h6,
              fontWeight: FontWeights.semiBold,
            ),
            RichTextItem(
              text: widget.required ? "*" : "",
              fontSize: FontSizes.h6,
              fontWeight: FontWeight.w500,
              fontColor: AppColors.danger,
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(
            bottom: widget.controller._errorMessage != null ? 0 : 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Radiuses.large)),
            border: Border.all(
              color: widget.controller._errorMessage != null
                  ? AppColors.danger
                  : context.contrast,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: widget.controller._selectedItemList.isNotEmpty,
                child: Padding(
                  padding: widget.editable
                      ? EdgeInsets.only(bottom: 20)
                      : EdgeInsets.zero,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.controller._selectedItemList.length,

                    itemBuilder: (context, index) {
                      var item = widget.controller.mapper(
                        widget.controller._selectedItemList[index],
                      );
                      return Container(
                        margin:
                            index <
                                widget.controller._selectedItemList.length - 1
                            ? EdgeInsets.only(bottom: 5)
                            : EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: context.accent2.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.all(
                            Radius.circular(Radiuses.large),
                          ),
                          border: Border.all(color: context.contrast),
                        ),
                        child: ListTile(
                          onTap: () => widget.controller
                              .createChildren(
                                widget.controller._selectedItemList[index],
                              )
                              .then((v) {
                                if (widget.controller.onChanged != null) {
                                  widget.controller.onChanged!(
                                    widget.controller._selectedItemList,
                                  );
                                }
                              }),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          title: TextComponent(
                            value: item.title,
                            fontWeight: FontWeights.semiBold,
                          ),
                          subtitle: TextComponent(value: item.subtitle),
                          trailing: widget.editable
                              ? GestureDetector(
                                  onTap: () => setState(() {
                                    widget.controller._selectedItemList
                                        .removeAt(index);

                                    if (widget.controller.onChanged != null) {
                                      widget.controller.onChanged!(
                                        widget.controller._selectedItemList,
                                      );
                                    }
                                  }),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.accent2,
                                    ),
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: AppColors.danger,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                visible: widget.editable,
                child: InkWell(
                  onTap: () => widget.controller._selectItemOnTap(context),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.contrast,
                      ),
                      child: Icon(
                        Icons.add_circle_outline_outlined,
                        color: AppColors.darkText,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.controller._errorMessage != null,
          child: TextComponent(
            value: widget.controller._errorMessage?.tr,
            fontColor: AppColors.danger,
            margin: EdgeInsetsGeometry.only(bottom: 15),
          ),
        ),
      ],
    );
  }
}
