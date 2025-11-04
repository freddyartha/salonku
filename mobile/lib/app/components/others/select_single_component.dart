import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonku/app/common/app_colors.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/font_weight.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/buttons/button_component.dart';
import 'package:salonku/app/components/images/image_component.dart';
import 'package:salonku/app/components/inputs/input_text_component.dart';
import 'package:salonku/app/components/others/list_component.dart';
import 'package:salonku/app/components/texts/rich_text_component.dart';
import 'package:salonku/app/components/texts/text_component.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/extension/theme_extension.dart';
import 'package:salonku/app/models/select_item_model.dart';

class SelectSingleController<T> extends ChangeNotifier {
  late Function(VoidCallback fn) setState;

  SelectItemModel? _selectedItem;
  String? _errorMessage;
  late bool _required;
  bool _searchConInitialized = false;

  final ListComponentController listController;
  late final InputTextController _searchCon;
  String keyword = "";

  Function(SelectItemModel? item)? onChanged;

  SelectSingleController({required this.listController, this.onChanged});

  SelectItemModel? get value {
    return _selectedItem;
  }

  set value(SelectItemModel? value) {
    _selectedItem = value;
    setState(() {});
  }

  void init(Function(VoidCallback fn) setStateX, BuildContext context) {
    setState = setStateX;
    if (!_searchConInitialized) {
      _searchCon = InputTextController(
        onChanged: (value) {
          keyword = value;
          listController.refresh();
        },
      );
      _searchConInitialized = true;
    }
  }

  Future<void> _selectItemOnTap(BuildContext context) async {
    SelectItemModel? selectedItemsTmp;
    selectedItemsTmp = _selectedItem;

    await ReusableWidgets.customBottomSheet(
      title: "select_data".tr,
      children: [
        InputTextComponent(placeHolder: "search".tr, controller: _searchCon),
        StatefulBuilder(
          builder: (context, setState) => ListComponent(
            withPadding: false,
            controller: listController,
            itemBuilder: (item) => Container(
              decoration: BoxDecoration(
                color: context.accent2.withValues(alpha: 0.7),
                borderRadius: BorderRadius.all(Radius.circular(Radiuses.large)),
                border: Border.all(color: context.contrast),
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    if (selectedItemsTmp?.value == item.value) {
                      selectedItemsTmp = null;
                    } else {
                      selectedItemsTmp = item;
                    }
                  });
                },
                leading: selectedItemsTmp?.value == item.value
                    ? Icon(
                        Icons.check_circle_outline_rounded,
                        color: context.contrast,
                        size: 35,
                      )
                    : null,

                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                title: TextComponent(
                  value: item.title,
                  fontWeight: FontWeights.semiBold,
                ),
                subtitle: TextComponent(value: item.subtitle),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 20,
          children: [
            Expanded(
              child: ButtonComponent(
                text: "cancel".tr,
                isMultilineText: true,
                borderColor: Get.context?.contrast,
                buttonColor: Get.context?.accent,
                textColor: Get.context?.text,
                borderRadius: Radiuses.regular,
                onTap: () {
                  Get.back(result: false);
                },
              ),
            ),
            Expanded(
              child: ButtonComponent(
                text: "ok".tr,
                borderRadius: Radiuses.regular,
                isMultilineText: true,
                onTap: () {
                  Get.back(result: true);
                },
              ),
            ),
          ],
        ),
      ],
    ).then((v) {
      if (v == true) {
        _selectedItem = selectedItemsTmp;
        if (onChanged != null) {
          onChanged!(_selectedItem);
        }
        setState(() {});
      }
    });
  }

  bool get isValid {
    setState(() {
      _errorMessage = null;
    });

    if (_required && _selectedItem == null) {
      setState(() {
        _errorMessage = 'field_is_required'.tr;
      });
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _searchCon.dispose();
    super.dispose();
  }
}

class SelectSingleComponent<T> extends StatefulWidget {
  final SelectSingleController<T> controller;
  final String label;
  final bool editable;
  final bool required;

  const SelectSingleComponent({
    super.key,
    required this.controller,
    required this.label,
    this.editable = true,
    this.required = false,
  });

  @override
  State<SelectSingleComponent<T>> createState() =>
      _SelectSingleComponentState<T>();
}

class _SelectSingleComponentState<T> extends State<SelectSingleComponent<T>> {
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
          padding: widget.controller._selectedItem == null
              ? EdgeInsets.all(10)
              : widget.controller._selectedItem != null && widget.editable
              ? EdgeInsets.only(bottom: 10)
              : null,
          margin: EdgeInsets.only(bottom: 10),
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
                visible:
                    widget.controller._selectedItem == null && !widget.editable,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageComponent(
                        localUrl: "assets/images/png/drawer-empty.png",
                        height: 25,
                        width: 25,
                        color: context.text,
                      ),
                      TextComponent(
                        value: "empty_item".tr,
                        fontSize: FontSizes.h6,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: widget.controller._selectedItem != null,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  title: TextComponent(
                    value: widget.controller._selectedItem?.title,
                    fontWeight: FontWeights.semiBold,
                  ),
                  subtitle: TextComponent(
                    value: widget.controller._selectedItem?.subtitle,
                  ),
                  trailing: widget.editable
                      ? GestureDetector(
                          onTap: () => setState(() {
                            widget.controller._selectedItem = null;
                            if (widget.controller.onChanged != null) {
                              widget.controller.onChanged!(
                                widget.controller._selectedItem,
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
          ),
        ),
      ],
    );
  }
}
