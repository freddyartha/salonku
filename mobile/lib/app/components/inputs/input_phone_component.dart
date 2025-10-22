import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:salonku/app/common/font_size.dart';
import 'package:salonku/app/common/radiuses.dart';
import 'package:salonku/app/components/inputs/input_box_component.dart';
import 'package:salonku/app/extension/theme_extension.dart';

class InputPhoneController extends ChangeNotifier {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _con = TextEditingController();
  late Function(VoidCallback fn) setState;

  InputPhoneController({this.onTap});

  bool _required = false;
  String _countryCode = "ID";

  VoidCallback? onEditingComplete;
  ValueChanged<PhoneNumber>? onChanged;
  GestureTapCallback? onTap;
  ValueChanged<String>? onFieldSubmitted;
  FormFieldSetter<PhoneNumber>? onSaved;

  String? _validator(
    PhoneNumber? v, {
    FormFieldValidator<PhoneNumber>? otherValidator,
  }) {
    if (_required && (v == null || v.number.isEmpty)) {
      return "field_is_required".tr;
    }

    if (otherValidator != null) {
      return otherValidator(v);
    }
    return null;
  }

  void _init(Function(VoidCallback fn) setStateX) {
    setState = setStateX;
  }

  bool get isValid {
    bool? valid = _key.currentState?.validate();
    if (valid == null) {
      return true;
    }
    return valid;
  }

  dynamic get value {
    return _con.value.text;
  }

  set value(dynamic value) {
    if (value != null) {
      String beforeDash = "$value".split('-').first;
      String afterDash = "$value".split('-').last;
      setState(() {
        _con.text = afterDash;
        _countryCode = beforeDash;
        _con.value = TextEditingValue(text: "$value");
      });
    }
  }

  @override
  void dispose() {
    _con.dispose();
    super.dispose();
  }
}

class InputPhoneComponent extends StatefulWidget {
  final InputPhoneController controller;
  final bool required;
  final String? label;
  final bool editable;
  final double? marginBottom;
  final FormFieldValidator<PhoneNumber>? validator;
  final Radius? borderRadius;
  final FocusNode? focusNode;
  final bool disableInputKeyboard;
  final Color? labelColor;

  final bool isPassword;

  const InputPhoneComponent({
    super.key,
    required this.controller,
    this.required = false,
    this.label,
    this.editable = true,
    this.marginBottom,
    this.validator,
    this.borderRadius,
    this.focusNode,
    this.disableInputKeyboard = false,
    this.labelColor,
    this.isPassword = false,
  });

  @override
  State<InputPhoneComponent> createState() => _InputPhoneState();
}

class _InputPhoneState extends State<InputPhoneComponent> {
  @override
  void initState() {
    widget.controller._init((fn) {
      if (mounted) {
        setState(fn);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller._required = widget.required;

    final decoration = InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      filled: true,
      fillColor: context.accent2.withValues(alpha: widget.editable ? .2 : .5),
      hintText: "placeholder_nomor_hp".tr,
      hintStyle: const TextStyle(fontSize: FontSizes.normal),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          widget.borderRadius ?? Radius.circular(Radiuses.large),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          widget.borderRadius ?? Radius.circular(Radiuses.large),
        ),
        borderSide: BorderSide(color: context.contrast, width: .1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          widget.borderRadius ?? Radius.circular(Radiuses.large),
        ),
        borderSide: BorderSide(
          color: context.contrast,
          width: widget.editable ? .1 : .3,
        ),
      ),
      prefixStyle: TextStyle(color: context.text.withValues(alpha: 0.6)),
      suffixIconConstraints: const BoxConstraints(minHeight: 30, minWidth: 30),
    );

    var phoneFormField = IntlPhoneField(
      cursorColor: context.text,
      decoration: decoration,
      initialCountryCode: widget.controller._countryCode,
      onSaved: widget.controller.onSaved,
      onTap: widget.controller.onTap,
      onSubmitted: widget.controller.onFieldSubmitted,
      obscureText: widget.isPassword,
      style: TextStyle(color: context.text),
      onChanged: (phone) {
        widget.controller._con.value = TextEditingValue(
          text: "${phone.countryCode}-${phone.number}",
        );
        if (widget.controller.onChanged != null) {
          widget.controller.onChanged!(phone);
        }
      },
      validator: (v) =>
          widget.controller._validator(v, otherValidator: widget.validator),
      readOnly: !widget.editable || widget.disableInputKeyboard,
      autovalidateMode: AutovalidateMode.always,
    );

    return InputBoxComponent(
      label: widget.label,
      labelColor: widget.labelColor,
      marginBottom: widget.marginBottom,
      childText: widget.controller._con.text,
      isRequired: widget.required,
      children: Form(key: widget.controller._key, child: phoneFormField),
    );
  }
}
